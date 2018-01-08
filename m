Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9BB1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbeAHSpE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:45:04 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46490 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755867AbeAHSpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:45:02 -0500
Received: by mail-qt0-f196.google.com with SMTP id r39so14814591qtr.13
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J7qa+L0NSnmFSWdlt9/CBB+Z6PTf8FbDelnUf9X9Lyk=;
        b=ObPNoRG8gbNYC3kmhRfYMAzM756TgtFLY1DpTndqBS0Sy+7RoFwtHUxX/gODLCOaVO
         +QnEh86tP+o2C0V7p8RbzmL+YpTnrhiayJBMqRp2BDvpkFZbfbVXEpVe7Bv8FPBYjPXv
         HS6Mqak8XZGhaZkyY/4vHJT69+tG48JABhV4hawDIj7/oiOI2POYdb+WU3A46qdbTRNm
         rNY5vksHvKMzCDjS0a9jxiPPMtWaV7JBfTqUz5rXSwYF9bQ0lr+UJVktbe+x8SIz31gV
         oxVAgKkTuMUe7HB036wz/qIjPFXxAARfZpRzKEU0ADaDyvcIpgrElUoa1PPV4bhshKnL
         Oaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J7qa+L0NSnmFSWdlt9/CBB+Z6PTf8FbDelnUf9X9Lyk=;
        b=j6zFvBex1Py44bieujr0aAfN6wNadLdy51Bq3jXQu1L7oaCi21RQw2FsedcI4f9s27
         9LC4wiQcjGC808VMOsHV9MDvVjmCkod+LP5Rt8MhMcn/PMeIe0kibYQ+T35xmONHcr4C
         xwEwmWJvmbOx0/Rao0WiJ1g/j7mIY5qUvw33oJIER6SSAfbbTcJT5QUd2lPkMYXvxyD2
         opeDm+LOQtk+DIKBtUqo03vPGEL3tOMNA+Q0LHRY54tI79a+OF/SeB9b2ndEmNAN/PQz
         UZLchzZgtRaFE2tBV26B5SgjQt0fDvGtcN2yaIkyjI8oOn2Wb47VteC1knw6dg+W3GYU
         T4HA==
X-Gm-Message-State: AKwxytcCnYbs3kUeyX69ah88iVBM0MlnSjad3knIyF1faUaS0Qn9pSC2
        SY8dPxbMc4NVUumHexvoY96SEd20gfuBtb7CS1hfvQ==
X-Google-Smtp-Source: ACJfBosk2wNjeok0A33m1/2arevO7FA0mcC9WDcDWE4QeaXGLsG8GLSDnZlcDk9vMrMbx1bOHPLwcW3zMM/QgcOhjaI=
X-Received: by 10.237.53.50 with SMTP id a47mr18371475qte.29.1515437101888;
 Mon, 08 Jan 2018 10:45:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:45:01 -0800 (PST)
In-Reply-To: <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:45:01 -0800
Message-ID: <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> index 3f73983d5..e3c798d2a 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -76,9 +76,9 @@ The configuration of submodules
>  Submodule operations can be configured using the following mechanisms
>  (from highest to lowest precedence):
>
> - * The command line for those commands that support taking submodule specs.

++ The command line for those commands that support taking submodules
as part of their pathspecs[1].
++
++[1] pathspec is an official term according to `man gitglossary`.

Maybe?

> -   Most commands have a boolean flag '--recurse-submodules' whether to
> -   recurse into submodules. Examples are `ls-files` or `checkout`.
> + * The command line for those commands that support taking submodule
> +   specifications. Most commands have a boolean flag '--recurse-submodules
> +   whether to recurse into submodules. Examples are `ls-files` or `checkout`.
>     Some commands take enums, such as `fetch` and `push`, where you can
>     specify how submodules are affected.
>
> --
> 2.16.0.rc0.223.g4a4ac8367
>
