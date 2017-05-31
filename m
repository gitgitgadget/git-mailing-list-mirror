Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFCE1FD09
	for <e@80x24.org>; Wed, 31 May 2017 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdEaTIg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 15:08:36 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33162 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEaTIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 15:08:35 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so15440438pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qGwDf+GtrMEBgUMxV7H/LCQN2RyApBvUyU7QAbOSQoM=;
        b=J4e0fWdU5EIN7WXTflht03WCzkZIB9RlG+RWjrmGFMusJvPJYtxjTu4GJLNg+hpb7z
         RyLuFxg9m/XJ0meLHOS1+QJsWBRbE3kZ+9vya7fTIyiiynDFi6zpNAsutgQfdm1uImsv
         7LIJX4OLJRAuJncPJvUtscJfE9HWafxa42S9DbfMFaQ9Xc9GaFgW4SPXWWVGSEclqHn/
         F2LsoznuJdY+3j4m9GiYBNkrq0X1nvB+BNgk8v3HrNQpQ0X37Vm7Jea9U8N0d28wTmfF
         azCU8wwMds+4rO4Hh5DinVNuACgqH6pkqf4eyVZRJgWTGg8TiFlO3zjT5jkpiy/tksEm
         16Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qGwDf+GtrMEBgUMxV7H/LCQN2RyApBvUyU7QAbOSQoM=;
        b=W1JwQbT6Y87isrflKHHy6VSKKDsLjv521Pw7ArKaIa2buzHATbEnRVkjoc3c3iTpZ1
         pV3zgXQMZjFz2zCOWmjQUcIKJKduchTdz/1gafz0+u2nBsCidtqElT7EkvbD0XhqWhys
         UWfcNekng0eG1gJI+fhl4agjjrhRrg6w5ZFVTnZVvTc6H4WLHiRewsRN3gW4XlN2U+ev
         QplXF0VnNiZc1jaCMaXvkTj+ZeM2JIYooXpbHFRKzQSSSnPIRrnoqCM8akLvdAohMEol
         1o8awOYoQ2S082j/kFG6cQZBxoGw8XKHxGDZvqtzlOWZXEubDscopyvojkTvbfUm6NqF
         pk5A==
X-Gm-Message-State: AODbwcDgADZZF+eAKEKnRg3FOu4xLV/R6JXJC/0qkEpTxk5/KrhJrgDc
        JMBu8GPXXfESnahCkFMY0iwFWqERIe6v
X-Received: by 10.99.60.82 with SMTP id i18mr9982654pgn.183.1496257714536;
 Wed, 31 May 2017 12:08:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 12:08:34 -0700 (PDT)
In-Reply-To: <20170531150427.7820-3-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com> <20170531150427.7820-3-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 12:08:34 -0700
Message-ID: <CAGZ79kYns3CWS5acxGRk67mqdfBvPC=hngnNyovrOkjRRwhRCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: turn on progress option by default for format-patch
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 8:04 AM, Kevin Willford <kcwillford@gmail.com> wrote:
> This change passes the progress option of format-patch by
> default and passes the -q --quiet option through to the
> format-patch call so that it is respected as well.

This is not conflicting with Johannes rewrite of rebase in C?
(rebase is a huge beast IIUC)

When passing the progress option by default to formatting patches,
maybe we should use start_progress_delay in the previous patch instead
to omit the progress for short lived patch formatting sessions?
(say a delay of one second?)

Thanks,
Stefan

>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  git-rebase--am.sh | 5 +++--
>  git-rebase.sh     | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 375239341f..ab2be30abf 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -51,8 +51,9 @@ then
>  else
>         rm -f "$GIT_DIR/rebased-patches"
>
> -       git format-patch -k --stdout --full-index --cherry-pick --right-only \
> -               --src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +       git format-patch $git_format_patch_opt -k --stdout --full-index \
> +               --cherry-pick --right-only --src-prefix=a/ --dst-prefix=b/ \
> +               --no-renames --no-cover-letter --progress \
>                 "$revisions" ${restrict_revision+^$restrict_revision} \
>                 >"$GIT_DIR/rebased-patches"
>         ret=$?
> diff --git a/git-rebase.sh b/git-rebase.sh
> index db1deed846..b72e319ac9 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -73,6 +73,7 @@ test "$(git config --bool rebase.stat)" = true && diffstat=t
>  autostash="$(git config --bool rebase.autostash || echo false)"
>  fork_point=auto
>  git_am_opt=
> +git_format_patch_opt=
>  rebase_root=
>  force_rebase=
>  allow_rerere_autoupdate=
> @@ -308,6 +309,7 @@ do
>         --quiet)
>                 GIT_QUIET=t
>                 git_am_opt="$git_am_opt -q"
> +               git_format_patch_opt="$git_format_patch_opt -q"
>                 verbose=
>                 diffstat=
>                 ;;
> --
> 2.13.0.92.g73a4ce6a77
>
