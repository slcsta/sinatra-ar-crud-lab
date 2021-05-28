
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

# READ request
# root route - usually welcome page
  get '/' do
  end

# READ
# create the get '/articles' controller action.
# this action uses Active Record to grab all of the articles
# and store them in an instance variable @articles

  get '/articles' do
    @articles = Article.all
    erb :index    # render the index.erb view - uses ERB to iterate over 
  end             # @articles and render them on the page


# CREATE
# create a route in your controller: get '/articles/new'
# it renders the new.erb view. 
# the view will be a blank form that submits a POST request
# to /articles

  get '/articles/new' do
    @article = Article.new
    erb :new
  end

#CREATE 
# Tell controller what to do when your :new form sends that POST
# request, so create a route on your controller post '/articles' that 
# creates a new article from the params from the form, then redirects to that new 
# article's show page

post '/articles' do
  @article = Article.create(title: params[:title], content: params[:content])
  redirect to "/articles/#{@article.id}"
end

# create the get '/articles/:id' controller action. This action should use
# active record to grab the article with the id that is in the params and
# set it equal to @article. Then it should render the show.erb view page.
# That view should use ERB to render the @article's title and content.

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

# create a controller action, get '/articles/:id/edit' that renders the view edit.erb
# this view should contain a form to update a specific article--similar to the form
# you made for a new article, but the fields should be pre-populated with the existing
# title and content of the article.

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  

  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect to "/articles"
  end
end





  
