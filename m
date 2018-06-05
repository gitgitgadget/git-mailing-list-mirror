Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C9A1F517
	for <e@80x24.org>; Tue,  5 Jun 2018 16:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeFEQG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:06:29 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46505 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeFEQG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:06:27 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so2560723oig.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YoHslcEPXlKxl0PcoIyL/S8lqbGbm1BHXONCJ7BJ9wc=;
        b=ufihL18LNavNBbG/5WU5+UiTo7FKLC362kG3MBvZT/r5RjpIspq/mZNfbWfUuITaaF
         p7yUJBdG6pAaoE5Ovzo0a0kYaL2GnWvmZGDrfkcCBwAA6Bwj8IhOgdEAw5ysqQb8X36k
         k93fFYtKxanQwacnI8XL/iNjAF6SfKLNrPju63C9YZ8CpuOWona/1qfBwsk6C/65mFKQ
         fZzys4UeLjDVwrQY+3x2qGB7cTyQ+Ni6vFdiXqSGhyUVvD0mxWJWMv6izURhO6LWrH54
         B+EBubGDzsGhvLTYVe64vWb/zDIdqPojmA1hodEcMvZPaiB3ppq5FG9k6KFd8A6T71pb
         k9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YoHslcEPXlKxl0PcoIyL/S8lqbGbm1BHXONCJ7BJ9wc=;
        b=N5/i5gHy3nnADAkDkx2c+5seE4dPRtDnQNI0zghHIaJ2p+c+cCJZv8CK6YjOGik6Io
         1gXGNcCKuYswvuvRX9qW2ysu2r5z7MM12pBOeMKTrgrA8MhC2E1ldVuzKi3Sc7nDmKbF
         tSaSvFJ3r69JUXqpUIzV3AfV0vbjc8cpKWsr4K8RNQbogPQ6lm48jTQ5rJ9nxrzry9rv
         zLSAUpHfwlY5aJrEgXzfjDuCerHOZGsYGU6xvvUY0fxIxDpzX7qA78PJpGJlVd+6aD58
         fFUuxd6mYaAPhHwA5Jg0Ul+my+CTlYkyu3Kom1uTH699rQcLvaECQcsFNzrT+NG7zv9F
         p2FA==
X-Gm-Message-State: APt69E29HenkElArwA+orbVrasJSOC8ty/yh9+EZapOnlroyTCtoE5xs
        jz30x9D+iC5G5+aKRkCjt6HmiwmOpcxilWBqWzQ=
X-Google-Smtp-Source: ADUXVKI1WtYtn55AAqfJL4EiVEI1O8yYzoyYm/gd2RmI6rnPMk6roFre3igpArfjNkB0M/SMV45T3IjWziO7V/VsPkw=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr15704948oii.34.1528214787123;
 Tue, 05 Jun 2018 09:06:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 09:05:56 -0700 (PDT)
In-Reply-To: <20180604215023.20525-1-rafa.almas@gmail.com>
References: <20180604215023.20525-1-rafa.almas@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 5 Jun 2018 18:05:56 +0200
Message-ID: <CACsJy8DVi0rqjw0dCdxppb=e+jH5yNcX9XcRXDnvLXS8x0QsJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] docs: reflect supported fetch options of git pull
To:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marius Giurgi <marius.giurgi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 11:50 PM, Rafael Ascens=C3=A3o <rafa.almas@gmail.com=
> wrote:
> `git pull` understands some options of `git fetch` which then uses in
> its operation. The documentation of `git pull` doesn't reflect this
> clearly, showing options that are not yet supported (e.g. `--deepen`)
> and omitting options that are supported (e.g. `--prune`).
>
> Make the documentation consistent with present behaviour by hiding
> unavailable options only.

A better option may be making git-pull accept those options as well. I
see no reason git-pull should support options that git-fetch does (at
least most of them). But I would understand if you would not want to
go touch the code. It's basically a couple of OPT_PASSTRHU though so
not very hard to do.

PS. Anybody up to making parse-options accept multiple struct option
arrays? This way we can have much better option passthru without
specifying them again and again.

>
> Reported-by: Marius Giurgi <marius.giurgi@gmail.com>
> Signed-off-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> ---
>
> Marius asked on freenode.#git if pull supported `--prune`, upon
> inspection seems like the man page was missing some of the supported
> options and listing others that are not supported via pull.
>
> Here's a quick summary of the changes to pull's documentation:
>
> add:                      remove:
>   --dry-run                 --deepen=3D<depth>
>   -p, --prune               --shallow-since=3D<date>
>   --refmap=3D<refspec>        --shallow-exclude=3D<revision>
>   -t, --tags                -u, --update-head-ok
>   -j, --jobs=3D<n>
>
>  Documentation/fetch-options.txt | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-option=
s.txt
> index 8631e365f..da17d27c1 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -14,6 +14,7 @@
>         linkgit:git-clone[1]), deepen or shorten the history to the speci=
fied
>         number of commits. Tags for the deepened commits are not fetched.
>
> +ifndef::git-pull[]
>  --deepen=3D<depth>::
>         Similar to --depth, except it specifies the number of commits
>         from the current shallow boundary instead of from the tip of
> @@ -27,6 +28,7 @@
>         Deepen or shorten the history of a shallow repository to
>         exclude commits reachable from a specified remote branch or tag.
>         This option can be specified multiple times.
> +endif::git-pull[]
>
>  --unshallow::
>         If the source repository is complete, convert a shallow
> @@ -42,10 +44,8 @@ the current repository has the same history as the sou=
rce repository.
>         .git/shallow. This option updates .git/shallow and accept such
>         refs.
>
> -ifndef::git-pull[]
>  --dry-run::
>         Show what would be done, without making any changes.
> -endif::git-pull[]
>
>  -f::
>  --force::
> @@ -63,6 +63,7 @@ ifndef::git-pull[]
>  --multiple::
>         Allow several <repository> and <group> arguments to be
>         specified. No <refspec>s may be specified.
> +endif::git-pull[]
>
>  -p::
>  --prune::
> @@ -76,8 +77,14 @@ ifndef::git-pull[]
>         subject to pruning. Supplying `--prune-tags` is a shorthand for
>         providing the tag refspec.
>  +
> +ifdef::git-pull[]
> +See the PRUNING section on linkgit:git-fetch[1] for more details.
> +endif::git-pull[]
> +ifndef::git-pull[]
>  See the PRUNING section below for more details.
> +endif::git-pull[]
>
> +ifndef::git-pull[]
>  -P::
>  --prune-tags::
>         Before fetching, remove any local tags that no longer exist on
> @@ -89,9 +96,6 @@ See the PRUNING section below for more details.
>  +
>  See the PRUNING section below for more details.
>
> -endif::git-pull[]
> -
> -ifndef::git-pull[]
>  -n::
>  endif::git-pull[]
>  --no-tags::
> @@ -101,7 +105,6 @@ endif::git-pull[]
>         behavior for a remote may be specified with the remote.<name>.tag=
Opt
>         setting. See linkgit:git-config[1].
>
> -ifndef::git-pull[]
>  --refmap=3D<refspec>::
>         When fetching refs listed on the command line, use the
>         specified refspec (can be given more than once) to map the
> @@ -119,6 +122,7 @@ ifndef::git-pull[]
>         is used (though tags may be pruned anyway if they are also the
>         destination of an explicit refspec; see `--prune`).
>
> +ifndef::git-pull[]
>  --recurse-submodules[=3Dyes|on-demand|no]::
>         This option controls if and under what conditions new commits of
>         populated submodules should be fetched too. It can be used as a
> @@ -129,6 +133,7 @@ ifndef::git-pull[]
>         when the superproject retrieves a commit that updates the submodu=
le's
>         reference to a commit that isn't already in the local submodule
>         clone.
> +endif::git-pull[]
>
>  -j::
>  --jobs=3D<n>::
> @@ -137,6 +142,7 @@ ifndef::git-pull[]
>         submodules will be faster. By default submodules will be fetched
>         one at a time.
>
> +ifndef::git-pull[]
>  --no-recurse-submodules::
>         Disable recursive fetching of submodules (this has the same effec=
t as
>         using the `--recurse-submodules=3Dno` option).
> @@ -153,7 +159,6 @@ ifndef::git-pull[]
>         recursion (such as settings in linkgit:gitmodules[5] and
>         linkgit:git-config[1]) override this option, as does
>         specifying --[no-]recurse-submodules directly.
> -endif::git-pull[]
>
>  -u::
>  --update-head-ok::
> @@ -163,6 +168,7 @@ endif::git-pull[]
>         to communicate with 'git fetch', and unless you are
>         implementing your own Porcelain you are not supposed to
>         use it.
> +endif::git-pull[]
>
>  --upload-pack <upload-pack>::
>         When given, and the repository to fetch from is handled
> --
> 2.17.1
>



--=20
Duy
