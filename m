Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3DA20756
	for <e@80x24.org>; Fri, 20 Jan 2017 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdATNgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 08:36:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35967 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbdATNgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 08:36:19 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so6765546wmr.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h7fEOGOvUCgsLHkN7YGeGUrCHXa57SbAGSBUFhTdmJA=;
        b=pT1105qviMsgacWDFZ1mNHHZLeXOZwRcXvBkW5GSG/6wkEJ4lggd/OiZiRmWkZcWAN
         AKo4w75WN4KRe7oCEBvXaIEFA1V4z0YgzHjMEQP1QpxvQIfrYtgq+JJYpFvcna3tHDK9
         ZA0eRAsoB0rt/dIphiNOF1dZoq3qMHKbtKZI2h5oHyVu0iXxBjiThjS/Y5SgCXwHu7kq
         n1ZNJ4Zm3eQf7vzODMkIGSkjEy3qXlvClJr73I5t/f33F11OEeich/C/qWgzTYIaUOiJ
         Bk0JosEY5X8b1uFC8ogp3ncPsz9nzuKQ0u4opO9Q5rWTjdILY1UsB76mQhhlGNulTeyh
         qz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h7fEOGOvUCgsLHkN7YGeGUrCHXa57SbAGSBUFhTdmJA=;
        b=FiOwhPf/VaF4F9eKY1/f03IrRIBppTulcMGCbAyPdniGD7SKtJXChMDEgYVRd1V2D5
         yU3ZOBOap/fbUL6AWl7yfB0wWk9hombszWi1h3DrOlJcWCKyCFsxEto5PiAqyLypDYNg
         so/5WoAMdz364GTUVohkyGj8M5zhFNINvnFXJEBQ3K8jHD0q/nqmz8Iyw3gc0f1qI5lG
         zOQy2lS47UqV1YW8u2iYFXWjiRVXQRN+wdES7VxLllgGK1cfkQal3nQkkeZHo4HY7uCp
         t0R+gth2Dlmdprxj0vn/4INqyNsuWuqVJMFHQmp0YdFG80GoF8PQy9XRYVLd1r5WVw23
         ez0A==
X-Gm-Message-State: AIkVDXI7sy73f0qOnDYq0WZiHqBphyOV0ko3qGJL174/tyNTJxeJkwt8/H9Un0mxKlErHVrKarGF1v96RyOu0w==
X-Received: by 10.223.128.3 with SMTP id 3mr1181803wrk.58.1484919327970; Fri,
 20 Jan 2017 05:35:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Fri, 20 Jan 2017 05:35:27 -0800 (PST)
In-Reply-To: <1484870858-6336-1-git-send-email-email@benjaminfuchs.de>
References: <1484870858-6336-1-git-send-email-email@benjaminfuchs.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 20 Jan 2017 14:35:27 +0100
Message-ID: <CAM0VKjmkOL6Ty=KLUbuV2CZao7x1YF_+X82JxyX-8gchi6Dzhg@mail.gmail.com>
Subject: Re: [PATCH] git-prompt.sh: add submodule indicator
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        felipe.contreras@gmail.com, ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not well-versed in submodules, so I won't comment on whether this
is the right way to determine that a repository is a submodule, but I
was surprised to see how much you have to work to find this out.

My comments will mostly focus on how to eliminate or at least limit
the scope of subshells and command executions, because fork()s and
exec()s are rather expensive on Windows.

On Fri, Jan 20, 2017 at 1:07 AM, Benjamin Fuchs <email@benjaminfuchs.de> wrote:
> I expirienced that working with submodules can be confusing. This indicator
> will make you notice very easy when you switch into a submodule.
> The new prompt will look like this: (sub:master)
> Adding a new optional env variable for the new feature.
>
> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
> ---
>  contrib/completion/git-prompt.sh | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)

Tests?

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 97eacd7..4c82e7f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -93,6 +93,10 @@
>  # directory is set up to be ignored by git, then set
>  # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>  # repository level by setting bash.hideIfPwdIgnored to "false".
> +#
> +# If you would like __git_ps1 to indicate that you are in a submodule,
> +# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
> +# the branch name.
>
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -284,6 +288,32 @@ __git_eread ()
>         test -r "$f" && read "$@" <"$f"
>  }
>
> +# __git_is_submodule
> +# Based on:
> +# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
> +__git_is_submodule ()

Use the '__git_ps1' prefix in the function name, like the other
functions.

> +{
> +       local git_dir parent_git module_name path
> +       # Find the root of this git repo, then check if its parent dir is also a repo
> +       git_dir="$(git rev-parse --show-toplevel)"

 1. This is a somewhat misleading variable name, because git_dir (with
    or without underscore or dash) refers to the path to the .git
    directory of a repository through the codebase, documentation and
    CLI options, not the top-level directory of the worktree.

 2. In a bare repository or in the .git directory of a "regular"
    repository '--show-toplevel' doesn't output anything, leading to
    an empty $module_name below, which ultimately results in no
    submodule indicator.

    As fas as behavior is concerned, this is good in the bare
    repository case, because as I understand it there is no such thing
    as a bare submodule.  I'm not sure whether the submodule indicator
    should be displayed in the ".git dir of a submodule" case.  I
    leave it up to you and Stefan to discuss.

    However, the info about whether we are in a bare repository or
    .git dir is already availabe in certain variables, so we know
    upfront when the current repository can't be a submodule.  In
    those cases this function should not be called only to spend
    several subshells and command executions to figure out what we
    already knew anyway.

 3. The path to the .git directory of the current repository
    is already available in the (not particularly descriptively named)
    $g variable from __git_ps1.  Perhaps you could use that variable
    instead, thus avoiding a subshell and executing a git command
    here.

> +       module_name="$(basename "$git_dir")"

This is executed even when there is no repository in the parent
directories, but it's only needed when there _is_ a repo up there.
Please move it into the conditional below, to avoid a subshell and
command execution in the main code path.

Since this $git_dir comes directly from our own 'git rev-parse' do we
have to be prepared for a Windows-style path there?  If it were always
a UNIX-style path, then we could strip all directories with shell
parameter expansion, eliminating both the subshell and the basename
execution.

> +       parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"

Style nit: no space after redirection, i.e. it should be '2>/dev/null'.

More importantly, I don't think you really need this variable:

 1. The existence of a parent git repository can be determined from
    'git rev-parse's exit code alone.

 2. When you run 'git submodule' below, you don't have to cd to the
    _top-level_ directory of the parent repository's worktree.  You
    just have to cd to _any_ directory in the parent, and you can do
    that with 'git -C "$git_dir/.." submodule ...', without knowing
    the parent's top-level directory.

This means that you don't need 'git rev-parse's output, thus there is
no need for the command substitution.  Yet another subshell spared! :)
However, then you have to be careful with changing directories, and
should write it as 'git -C "$git_dir/.." rev-parse ...'.

> +       if [[ -n $parent_git ]]; then

Unquoted path.

> +               # List all the submodule paths for the parent repo
> +               while read path
> +               do
> +                       if [[ "$path" != "$module_name" ]]; then continue; fi
> +                       if [[ -d "$git_dir/../$path" ]];    then return 0; fi
> +               done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)

Unquoted path and space after redirection again.

This loop will get confused if one of the submodule paths contains a
newline, though probably no one in their right mind would do something
like that.  Is it even possible to have a submodule name with newline
in it?
I wonder whether it would be possible to move the conditions from the
loop body to the shell command evaluated by 'submodule foreach', thus
eliminating the loop entirely and making submodule detection
newline-safe.  Or whether it's worth the trouble...

> +    fi
> +    return 1

Indent with spaces, please use tabs instead.

> +}
> +
> +__git_ps1_submodule ()
> +{
> +       __git_is_submodule && printf "sub:"
> +}

This function is unnecessary.
First, it's so short that it's body can be safely inlined in its
caller.  Second, it _prints_ its output to stdout, forcing the
caller to use a command substitution.  You can simply assign the value
to $sub based on __git_ps1_is_submodule()'s return value.

> +
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>  # when called from PS1 using command substitution
>  # in this mode it prints text to add to bash PS1 prompt (includes branch name)
> @@ -513,8 +543,13 @@ __git_ps1 ()
>                 b="\${__git_ps1_branch_name}"
>         fi
>
> +       local sub=""

Thank you for _not_ introducing yet another one letter variable name
:)

> +       if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
> +               sub="$(__git_ps1_submodule)"
> +       fi
> +
>         local f="$w$i$s$u"
> -       local gitstring="$c$b${f:+$z$f}$r$p"
> +       local gitstring="$c$sub$b${f:+$z$f}$r$p"
>
>         if [ $pcmode = yes ]; then
>                 if [ "${__git_printf_supports_v-}" != yes ]; then
> --
> 2.7.4
>
