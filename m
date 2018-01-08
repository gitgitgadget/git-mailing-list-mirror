Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EB71FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755977AbeAHStq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:49:46 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43111 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755932AbeAHStp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:49:45 -0500
Received: by mail-qk0-f196.google.com with SMTP id j137so15437888qke.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9MfYL8VchtM3DEh6CkvbjdgM+fBAx3Q2oXJugiViBk=;
        b=eqN0QHsqc/zGolyWyEH05gGaRsIzQ+FbE1178hIL8mYtXWQEd/wF2SAUm0HZPM1Hs4
         odHNmpLWtbt5G5Pv1U/dYw6Gq+H73lhEEnMmd8ZCEDif3Q5JDQxL2Z6tw/0dW8yjJ0ux
         7aNA5sQA+XJgUV5J6xkrdKAiSuc6XwQYN4THmGZ+fRpwOc5f5lx+2xB8RvrPhk4M/8qD
         9uBJDUtC/uZsd5IRC9NA+t7K6k9v5Qnpm7UbEfaOh55LgwcwGXuvxXGrOYVIpPedGwUe
         raLFCeKVAe7Ky/0QswD8kd57q1t5ondCxWVe3/horcxosN+gTEGrJ8dNLbZYPSyVyeAz
         pJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9MfYL8VchtM3DEh6CkvbjdgM+fBAx3Q2oXJugiViBk=;
        b=iHiv27n8NIeaBJTMKvQFZGhenvAz32RNKgsdx+B2Hs7N2TnLCrV7nppZ21r5GDvb5e
         ZwnsITrRu8DA+jryWpMZ5Bn/pth0cqemAxC8Q8T9eAWnS1kmxv3HeJr/hEA/SNM6+7Pf
         G0mconr1zKo+UsKgJunb90yfEWUuIrIbZH6bOLXUS9zKtLxEiysnQZwFS3HLaxRAfdmR
         DxBctatWHYPo3wdk+vmnNr/Pir1EQX2zmfP4fwg/xvhRjoYKdTKVs5jCZ6h/L7CtEBmK
         AH1ngtjktIb/CtjWA3ezwSLt3eA21OpY9kgqVjZC9kmQ32C9RjbQ8K7RTMKbmToyzGyZ
         51mg==
X-Gm-Message-State: AKwxytcLnigOEvdLoTA0sHRAxz4joUk0A9DNxthhexeHQyrn9qoX5Ggw
        DpWqTK5JFHD53BOFHmI/La0k31UZYXunL9f6ODtjQg==
X-Google-Smtp-Source: ACJfBotP2zArl7D3YSx0uWSzt7t/Pj6B3saYtpEvHTMPqaAjXXNjgy4nyK5N0ospFEkm9zWuM0B6/1Qt05kU1Gj/GUE=
X-Received: by 10.55.19.162 with SMTP id 34mr17616453qkt.40.1515437384003;
 Mon, 08 Jan 2018 10:49:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:49:43 -0800 (PST)
In-Reply-To: <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:49:43 -0800
Message-ID: <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain lines
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
>  Documentation/gitsubmodules.txt | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> index 745a3838e..339fb73db 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -76,9 +76,10 @@ The configuration of submodules
>  Submodule operations can be configured using the following mechanisms
>  (from highest to lowest precedence):
>
> - * The command line for those commands that support taking submodule
> -   specifications. Most commands have a boolean flag '--recurse-submodules
> -   whether to recurse into submodules. Examples are `ls-files` or `checkout`.
> + * The command line arguments of those commands that support taking submodule
> +   specifications. Most commands have a boolean flag '--recurse-submodules'
> +   which specify whether they should recurse into submodules. Examples are
> +   `ls-files` or `checkout`.
>     Some commands take enums, such as `fetch` and `push`, where you can
>     specify how submodules are affected.
>
> @@ -90,8 +91,8 @@ Submodule operations can be configured using the following mechanisms
>  For example an effect from the submodule's `.gitignore` file
>  would be observed when you run `git status --ignore-submodules=none` in
>  the superproject. This collects information from the submodule's working
> -directory by running `status` in the submodule, which does pay attention
> -to its `.gitignore` file.
> +directory by running `status` in the submodule while paying attention
> +to the `.gitignore` file of the submodule.

Both are grammatically correct and expressive, thanks!

>  +

Extra spurious line?

>  The submodule's `$GIT_DIR/config` file would come into play when running
>  `git push --recurse-submodules=check` in the superproject, as this would
> @@ -107,13 +108,13 @@ If the submodule is not yet initialized, then the configuration
>  inside the submodule does not exist yet, so configuration where to
>  obtain the submodule from is configured here for example.
>
> - * the `.gitmodules` file inside the superproject. Additionally to the
> -   required mapping between submodule's name and path, a project usually
> + * The `.gitmodules` file inside the superproject. Additionally, if mapping
> +   is required between a submodule's name and its path, a project usually

This changes meaning, originally it tries to say:

* it requires mapping path <-> names.
* but there can be more.

whereas the new lines are:

* mapping is optional
* there can be more.

>     uses this file to suggest defaults for the upstream collection
>     of repositories.
>  +
> -This file mainly serves as the mapping between name and path in
> -the superproject, such that the submodule's Git directory can be
> +This file mainly serves as the mapping between the name and path of submodules
> +in the superproject, such that the submodule's Git directory can be
>  located.

makes sense!

Thanks,
Stefan

>  +
>  If the submodule has never been initialized, this is the only place
> --
> 2.16.0.rc0.223.g4a4ac8367
>
