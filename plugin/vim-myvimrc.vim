" =============================================================================
" File:          plugin/vim-myvimrc.vim
" Description:   My vimrc.
" Author:        Weilong Wang <github.com/wilon>
" =============================================================================

" ===================
"  默认设置
" ===================
set nocompatible

" ===================
"  字符设置
" ===================
syn on                      "语法支持
set ai                      "自动缩进
set laststatus=2            "总是显示状态行
set expandtab               "以下三个配置配合使用，设置tab和缩进空格数
set shiftwidth=4
set tabstop=4
" set cursorline              "为光标所在行加下划线
set nu                      "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入
set ignorecase              "检索时忽略大小写
set hls                     "检索时高亮显示匹配项
"set fdm=manual       "代码折叠模式：自定义
set langmenu=zh_CN.UTF-8
set helplang=zh

" UTF-8乱码解决
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=chinese

" 解决菜单乱码
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

" 解决consle输出乱码
language messages zh_CN.utf-8

" ===================
"  GUI设置
" ===================
set noeb                 " 消除声音
set vb                   " 消除声音
set shortmess=all
set showtabline=2        " 默认显示标签
set guioptions-=e        " 默认标签样式
" colorscheme Monokai      " 配色
syntax enable
colorscheme monokai
set guifont=DejaVu_Sans_Mono:h14:cANSI     "字体
"autocmd GUIEnter * simalt ~x              " 全屏
set cmdheight=1

" 隐藏菜单栏、工具栏
set guioptions-=m        " 隐藏菜单栏
set guioptions-=T        " 隐藏工具栏
set guioptions+=c        " 使用字符提示框
set guioptions-=L        " 隐藏左侧滚动条
set guioptions-=b        " 隐藏底部滚动条
map <silent> <F11> : if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

" 状态栏设置
" set statusline=%f%m%r%h%w%=%{&ff}%Y\ \|\ Line:%3l,Str:%c%V\ \|\ ASSIC:%b\ \|\ %P\ \|\ TotleLine:%L\ \.
set statusline=%f%m%r%h%w%=Line:%3l\/%L,Str:%c%V\ \|\ ASSIC:%b\ \|\ %P\ \

" 优化标签标题
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
"set guitablabel=%{ShortTabLabel()}
" 显示tab和空格
set list
" 设置tab和空格样式
set lcs=tab:\|\ ,nbsp:%,trail:-
" 设定行首tab为灰色
highlight LeaderTab guifg=#ffffff
" 匹配行首tab
match LeaderTab /^\t/
" 打开文件列表样式
let g:netrw_preview   = 1
let g:netrw_liststyle = 1
let g:netrw_winsize   = 30
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" ===================
"  插件设置
" ===================

" ***** 设置ctrlp *****
let g:ctrlp_newcache = 1
let g:ctrlp_cache_dir = '~/.vim/cache/ctrlp'
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 0

" ***** 设置vim-tips *****
let g:vim_tip_lang = 'learnenglish_0'
let g:vim_tip_frequency = 0.1

" ===================
"  vim 自定义插件
" ===================
"
" ***** 选择缓冲区文件进行diff *****
command -complete=buffer -nargs=1 Wilondiff call WilonDiff('<args>')
function! WilonDiff(name)
    exec "vertical diffsplit ".a:name
endfunction
"
" ***** 退出 *****
command Bye call Bye()
function! Bye()
    let g:netrw_liststyle = 1
    exec "qa!"
endfunction

function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
map <C-B> :call ToggleVExplorer()<CR>

" ===================
"  项目设置
" ===================

" ===================
"  快捷键设置
" nore 表示非递归; n 普通模式下生效; v 可视模式下生效; i 插入模式下生效; c 命令行模式下生效
" ===================
map <F2> gT<CR>    " 左边标签
map <F3> gt<CR>    " 右边便签
map gf <C-w>gf<CR>    " 打开所在文件
" map <F5> :source $MYVIMRC<CR>    " 刷新vim配置
