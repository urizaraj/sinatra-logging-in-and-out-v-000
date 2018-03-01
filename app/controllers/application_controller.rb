require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])

    return erb(:error) unless @user

    session[:user_id] = @user.id
    redirect '/account'
  end

  get '/account' do
    @session = session
    erb :account
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/admin' do
    User.create(username: 'admin', password: 'admin', balance: 20.00)
    redirect '/'
  end
end
