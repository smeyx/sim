set nocompatible              " be iMproved, required
set shell=/bin/bash
" vim-plug config
" auto-installer
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" visual plugins
Plug 'itchyny/lightline.vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'sainnhe/everforest'

" syntax plugins
Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'elzr/vim-json'

" functional plugins
"" snippets for react
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
"" 
Plug 'vim-test/vim-test'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
"
"" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"
"" shortcut plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
"
"" completion/linting
"Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'heavenshell/vim-jsdoc', {
            \ 'for': [
            \ 'javascript', 
            \ 'javascript.jsx', 
            \ 'typescript', 
            \ 'typescript.tsx', 
            \ 'typescirptreact', 
            \ 'javascriptreact'
            \ ],
            \ 'do': 'make install'
            \}

call plug#end()


""" ============ plugin specific ============

" import config for 
"runtime coc_config.vim

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-html', 'coc-tailwindcss', 'coc-tsserver']

" python provider
let g:python3_host_prog = '/usr/bin/python3'

"make coc-tsserver understandt tsx/jsx correclty
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

let g:ale_linters = {
            \   'javascript': ['eslint'],
            \}

""" ============ testing stuff ============ 
let test#strategy = "vimterminal"


""" ============ colorscheme and lightline ============ 

" lightline and colorscheme configuration. 

if strftime('%H') >= 7 && ( strftime('%H') < 17 )
            colo meh
else
            colo meh
endif

    let g:lightline = {
                \   'colorscheme': 'PaperColor',
                \   'background': 'dark',
                \    'active': {
                \        'left': [ [ 'mode', 'paste'],
                \                    [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
                \    },
                \    'component_function': {
                \        'cocstatus': 'coc#status'
                \    },
                \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
""" ============ syntax specific stuff ============

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" 4 Spaces als Einrueckung
set ts=4
set sw=4
set sts=4

" javascript specific indenting
autocmd FileType javascript setlocal ts=2 sw=2 sts=2 
autocmd FileType typescript setlocal ts=2 sw=2 sts=2
autocmd FileType typescriptreact setlocal ts=2 sw=2 sts=2
autocmd FileType javascriptreact setlocal ts=2 sw=2 sts=2
autocmd FileType css setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal ts=4 sw=4 sts=4


" NERDTree stuff
map <C-n> :NERDTreeToggle<CR>

" set leader to comma
let mapleader = ","

imap <M-Space> <Esc>
nnoremap <Leader>tf :TestFile
nnoremap <Leader>ts :TestSuite
nnoremap <Leader>tn :TestNearest

nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>s :sp<CR>
nnoremap <Leader>v :vsp<CR>

tnoremap <Leader><Esc> <C-\><C-n>
" source vimrc
" nnoremap <Leader>s :so ~/.vimrc<CR>
let g:UltiSnipsExpandTrigger = "<C-J>"

""" ============

" ignore files for ctrlp
set wildignore+=*/.git/*,*/node_modules/*

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

set t_Co=256

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
"check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 <https://github.com/neovim/neovim/pull/2198>
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
" Based on Vim patch 7.4.1770 (`guicolors` option)
" <https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
" <https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
if (has("termguicolors"))
    set termguicolors
endif
