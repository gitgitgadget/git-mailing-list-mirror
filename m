Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5EC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1056103C
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhJZSX4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Oct 2021 14:23:56 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45736 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbhJZSXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 14:23:47 -0400
Received: by mail-ed1-f41.google.com with SMTP id m17so11822edc.12
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 11:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8ZyIeh0cZ5pnJd3J9O2CzU5rVhkTxax74aPKerwp8I=;
        b=XorQMo11BBv3UdBCUTzrtEnzqPhYPAR6FG3EU/tQhjrNbUYB7YelG5Xq3RJEIsRApi
         +P0YhJoB+5qmjVowy1ALOArAnNhenlRaxu8Hl0bpSgdtpugfoQUMhClqo7elzLUh1dix
         B5TkbD/2NiAtCjeaidI2oQYsg9rQ0S5Un29pd05KW94NrHxdVGm+HMywQG1yX5yXtYM2
         8YJfrahXnmBHkSA2RrGRrxYTeEfZ3FV84zuG//YQD9Zc5rceIFpuB7tf2KrBmVTJH9x2
         HeIC+eJdXFWM8HEiwHWIW43yIeVYc8G2wYs2EK0ObmiMQ8a32OvwV4hsEcqEPDVLkeFl
         vntQ==
X-Gm-Message-State: AOAM532ygdfNk2kwpgiqORLu/pwxyOR/nrMiebl5nZuGpmasez4SmIS6
        zS87vJzB6e8yM0wuJhoEP796j3lN34RAxLEz5k8=
X-Google-Smtp-Source: ABdhPJyfSFqqZ7716yJ6m2Rb2RnN0WDwI9IFP73HZDcwgqMwSiS7Aj1meFyn2dCY9xE/lKk9QW99v0iMT0sbAReRWl8=
X-Received: by 2002:a17:906:39b:: with SMTP id b27mr1812653eja.568.1635272481703;
 Tue, 26 Oct 2021 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 14:21:10 -0400
Message-ID: <CAPig+cQVChdH6eJGKPuRExt5TpfNWDwY95bge01dixr7jkiUuQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix grammar rules in commands'syntax
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 11:11 AM Jean-Noël Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> doc: fix grammar rules in commands'syntax

Missing space.

> According to the coding guidelines, the placeholders must:
>  * be in small letters
>  * enclosed in angle brackets
>
> Some other rules are also applied.

Perhaps just mention them here?

    * use hyphens rather than underscores or spaces
      between words
    * indicate repetition with `...` rather than `*`

were some that I saw while reading.

Overall, the patch looks good. One or two notes below...

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
> -'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
> +'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]

Nice to see this attention to detail.

> @@ -43,7 +43,7 @@ You could omit `<branch>`, in which case the command degenerates to
> -'git checkout' -b|-B <new_branch> [<start point>]::
> +'git checkout' -b|-B <new-branch> [<start-point>]::

Likewise.

> @@ -145,11 +145,11 @@ as `ours` (i.e. "our shared canonical history"), while what you did
> --b <new_branch>::
> +-b <new-branch>::
>         Create a new branch named `<new_branch>` and start it at
>         `<start_point>`; see linkgit:git-branch[1] for details.

The names in the description need fixing too: s/_/-/g

> --B <new_branch>::
> +-B <new-branch>::
>         Creates the branch `<new_branch>` and start it at `<start_point>`;
>         if it already exists, then reset it to `<start_point>`. This is
>         equivalent to running "git branch" with "-f"; see

Likewise: s/_/-/g

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -9,20 +9,20 @@ git-config - Get and set repository or global options
> -'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
> +'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch <name> <URL>

The commit message talks about using lowercase, so perhaps? s/URL/url/

> @@ -102,7 +102,7 @@ OPTIONS
> ---get-urlmatch name URL::
> +--get-urlmatch <name> <URL>::
>         When given a two-part name section.key, the value for
>         section.<url>.key whose <url> part matches the best to the
>         given URL is returned (if no such key exists, the value for

Ditto. In fact, lowercase <url> is already used in the description,
but not in the item line.

If wanting to match other documentation files, this would also be
typeset as `<url>` rather than <url> in the description text, but that
change may be well outside the scope of this patch.

> @@ -145,7 +145,7 @@ See also <<FILES>>.
> --f config-file::
> +-f <config-file>::
>  --file config-file::

Need to apply brackets around `config-file` for the `--file` option
too, just as you did for short `-f`.

> @@ -246,7 +246,7 @@ Valid `<type>`'s include:
> ---get-colorbool name [stdout-is-tty]::
> +--get-colorbool <name> [<stdout-is-tty>]::
>
>         Find the color setting for `name` (e.g. `color.diff`) and output
>         "true" or "false".  `stdout-is-tty` should be either "true" or

Should you wrap `stdout-is-tty` within angle brackets within the
description too?

> @@ -257,7 +257,7 @@ Valid `<type>`'s include:
> ---get-color name [default]::
> +--get-color <name> [<default>]::
>
>         Find the color configured for `name` (e.g. `color.diff.new`) and
>         output it as the ANSI color escape sequence to the standard

And here? <name> rather than `name`?

> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> @@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
> -git credential <fill|approve|reject>
> +git credential [fill|approve|reject]

The original was indeed wrong but the revised text is also slightly
misleading. The square brackets suggest that the "action" is optional,
but in fact it's not, so this should be using parentheses:

    git credential (fill|approve|reject)

Also, the usage text in builtin/credential.c is wrong:

    % git credential
    usage: git credential [fill|approve|reject]

It should be using parentheses, as well, but fixing that may be
outside the scope of this patch (and can be done later).

> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> @@ -9,11 +9,11 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
> -'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
> +'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]
>               [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
> -             [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
> +             [-C <git-repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
>               [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
> -             [-r <remote>] [-R] [<CVS_module>]
> +             [-r <remote>] [-R] [<CVS-module>]

I wonder if <commitlimit> should be changed to <commit-limit>?

> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
>          [--[no-]full] [--strict] [--verbose] [--lost-found]
>          [--[no-]dangling] [--[no-]progress] [--connectivity-only]
> -        [--[no-]name-objects] [<object>*]
> +        [--[no-]name-objects] [<object>...]

Okay.

> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> @@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
> ---shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
> +--shared[=(false|true|umask|group|all|world|everybody|0<octal>)]::

This feels slightly unusual; I'd have expected just plain `<octal>`
without the leading `0`, and...

> @@ -110,13 +110,14 @@ the repository permissions.
> -'0xxx'::
> +'0<octal>'::

.. this would also say just `<octal>`, and...

> -'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
> -override users' umask(2) value (and not only loosen permissions as 'group' and
> -'all' does). '0640' will create a repository which is group-readable, but not
> -group-writable or accessible to others. '0660' will create a repo that is
> -readable and writable to the current user and group, but inaccessible to others.
> +'0<octal>' is an octal number and each file will have mode
> +'0<octal>'. '0<octal>' will override users' umask(2) value (and not
> +only loosen permissions as 'group' and 'all' does). '0640' will create
> +a repository which is group-readable, but not group-writable or
> +accessible to others. '0660' will create a repo that is readable and
> +writable to the current user and group, but inaccessible to others.

... this would then go on to explain that `<octal>` "... is an octal
number starting with literal `0`...".

But it's subjective and others might feel differently.

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> @@ -81,7 +81,7 @@ produced by `--stat`, etc.
> -<revision range>::
> +<revision-range>::
>         Show only commits in the specified revision range.  When no
>         <revision range> is specified, it defaults to `HEAD` (i.e. the
>         whole history leading to the current commit).  `origin..HEAD`

Also need to fix the description: s/<revision range>/<revision-range>/

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> @@ -10,8 +10,8 @@ SYNOPSIS
>  'git ls-files' [-z] [-t] [-v] [-f]
> -               (--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
> -               (-[c|d|o|i|s|u|k|m])*
> +               [--(cached|deleted|others|ignored|stage|unmerged|killed|modified)...]
> +               [-(c|d|o|i|s|u|k|m)...]

I wonder if we could make it easier on users if written like this:

    [--cached|--deleted|--others|--blah|--blah]...
    [-c|-d|-o|-i|-s|-u|-k|-m]...

But that's subjective.

> diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
> @@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
> -'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
> +'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <.pack-filename>... )

I'd probably drop the leading dot in <.pack-filename>. It shouldn't be
difficult for a reader to figure out that these are the files with
`.pack` extension, and if they do need help understanding that, then
probably better to explain in prose that <pack-filename> is a pack
file with `.pack` extension.

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> @@ -89,7 +89,7 @@ counts both authors and co-authors.
> -<revision range>::
> +<revision-range>::
>         Show only commits in the specified revision range.  When no
>         <revision range> is specified, it defaults to `HEAD` (i.e. the
>         whole history leading to the current commit).  `origin..HEAD`

Need to update the description to: s/<revision range>/<revision-range>/

> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> @@ -11,7 +11,7 @@ given by a list of patterns.
> -'git sparse-checkout <subcommand> [options]'
> +'git sparse-checkout <subcommand> [<options>...]'

The addition of `...` would make more sense if it was spelled
"option", but with it already being plural "options", I have trouble
understanding why `...` is added.

> diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
> @@ -9,7 +9,7 @@ git-stage - Add file contents to the staging area
> -'git stage' args...
> +'git stage' <arg>...

It's subjective, but I find plain `<args>` easier to interpret than
`<arg>...`. Does our documentation favor one form over the other, or
is there a random mix?

> diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
> @@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
> -'git web{litdd}browse' [<options>] <url|file>...
> +'git web{litdd}browse' [<options>] (<url>|<file>)...

Good.
