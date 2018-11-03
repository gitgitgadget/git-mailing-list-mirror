Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B84C1F454
	for <e@80x24.org>; Sat,  3 Nov 2018 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKCXzF (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 19:55:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34393 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeKCXzF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 19:55:05 -0400
Received: by mail-io1-f67.google.com with SMTP id d80-v6so3454262iof.1
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6T+yzCE2NxQrPLzDaV3A4hZs0cvtIdBH6IPpuqt4umM=;
        b=SJ7cWUyeeD38owqd/jnZh13mt9lxviwCCgivfNrGTg7B8NlFibTlbq287Tr3fqgPVg
         qcgXqJJy0n+YuqitLGK6qdFzutxVcdlV9aNiamFszSmKtSQn+WlYVEsRptzyOogmCk5Y
         WrB9qigzfY8Mtru2Bib/0Auu9KOdUvkCHzQvTYJWDDnUwwQk10zfic0jfiPxsjULuFXW
         fPfPDwDhsa8+JKuwsAqj7wi72VZ5ptK64+ZTOoahJetIK+Ml8Bxs8HOiNGpmrSBxTOUx
         +5MaqIoSGtOEdmiWgBYWur36KzwfI2QDrGHFlK7+CSNF5nYlnoTHR7uMCslIxU3rHGA0
         erxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6T+yzCE2NxQrPLzDaV3A4hZs0cvtIdBH6IPpuqt4umM=;
        b=HcEPHUdhkXVjogKtoH7Jp1IpoQbz/4+U1zaGyhU1nnO2nbr0WfnyqU2jKt10Y+49uD
         et76hvwle2umR/2N8wudetrD+/idcmp6nG1w9jvPlDcTX0fowzSarhiXYjneVBHYj5+K
         sZpY3vG4mcQc1CsanQRNprNmB6uvnv31V9sk5KKaS5W0OmtTxjK+pSOv3r4tJ5I9ZOly
         j7V1u2wVZJFf5IsoqcRJYxdBj/f9xXGUzsFsw8ssFsE5BN3nwplN/I/E7R81+cbvXq26
         Jwslwaf3EabK7yA/RM7cV0KEKIgNeQaMtPdEpd9gvK1tzC0qXiicgkbWYQnqHOGvZf+G
         dyWw==
X-Gm-Message-State: AGRZ1gKDON+GZocBBwYjfMWj6MZp+XHhryNrd+t6Wxp/UIOJ0qbEPqC/
        6ZNfOrsVurwjmGrUoVrvKeJnvhN+EhQe+lqcwOc=
X-Google-Smtp-Source: AJdET5dgIUtjLtMuf/DRHQlJTkIOov3UvNCiNuEa2t2y9qPLRrHCKOxC88mOOdA9lH9YWwQU0o+AXlsOyqFP5uknzAo=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr12624181ioc.118.1541256212426;
 Sat, 03 Nov 2018 07:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181103112535.5730-1-tanushreetumane@gmail.com> <20181103115300.6518-1-tanushreetumane@gmail.com>
In-Reply-To: <20181103115300.6518-1-tanushreetumane@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 15:43:06 +0100
Message-ID: <CACsJy8DttJ2EBcN8Kq-yECY0Pvp3vd0Vx45=szWD0cBW0Mcixw@mail.gmail.com>
Subject: Re: [[PATCH v2]] commit: add a commit.allowempty config variable
To:     tanushreetumane@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 12:55 PM tanushree27 <tanushreetumane@gmail.com> wrote:
>
> Add commit.allowempty configuration variable as a convenience for those
> who always prefer --allow-empty.
>
> Add tests to check the behavior introduced by this commit.
>
> This closes https://github.com/git-for-windows/git/issues/1854
>
> Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
> ---
>  Documentation/config.txt     |  5 +++++
>  Documentation/git-commit.txt |  3 ++-
>  builtin/commit.c             |  8 ++++++++
>  t/t7500-commit.sh            | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c0727b7866..ac63b12ab3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1467,6 +1467,11 @@ commit.verbose::
>         A boolean or int to specify the level of verbose with `git commit`.
>         See linkgit:git-commit[1].
>
> +commit.allowempty::

The current naming convention is camelCase. So this should be commit.allowEmpty.

> +       A boolean to specify whether empty commits are allowed with `git
> +       commit`. See linkgit:git-commit[1].
> +       Defaults to false.
> +
>  credential.helper::
>         Specify an external helper to be called when a username or
>         password credential is needed; the helper may consult external
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f970a43422..07a5b60ab9 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>         Usually recording a commit that has the exact same tree as its
>         sole parent commit is a mistake, and the command prevents you
>         from making such a commit.  This option bypasses the safety, and
> -       is primarily for use by foreign SCM interface scripts.
> +       is primarily for use by foreign SCM interface scripts. See
> +       `commit.allowempty` in linkgit:git-config[1].

Same.

>
>  --allow-empty-message::
>         Like --allow-empty this command is primarily for use by foreign

-- 
Duy
