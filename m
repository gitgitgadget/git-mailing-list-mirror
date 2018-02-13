Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BF81F404
	for <e@80x24.org>; Tue, 13 Feb 2018 23:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966097AbeBMXp2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 18:45:28 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:45995 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966064AbeBMXp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 18:45:27 -0500
Received: by mail-yw0-f173.google.com with SMTP id b16so13558740ywh.12
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 15:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WuhluE/jL15GU/wohuNodm1kYOwYx3E8OajjHUKgKDE=;
        b=vSL2bJ9bNGHit4UTJjyswAROEYqpCR4oGq0M3zn4FuOs6Qn5+AEDz98xUbGu3QxIqK
         fOwz4WSmZnR5NZCDjajnTZ/jIUPqbXtwGSCTCMTG3mSZrpDSnt72PAA8mX0ThvZgfcyK
         HWbsr3mQmH0GLjtADYh90FAyVemfZSV0KdeQFvx+NF7rLK5u9XXIBfplUlwEMav5TZCZ
         B57w/VKQGTf39g0FXZ3r60F27xvYQlBIkQ1qaAIQEzW80sbkBCIwsgBTvPDG3Qr9cyRR
         alcPqoSyvCRte2xVAqknty+NfH9/XN3HxdZyXXL6vpBruQdmnCyRIb3e3g+VY97IYjpX
         7eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WuhluE/jL15GU/wohuNodm1kYOwYx3E8OajjHUKgKDE=;
        b=Fht8fihMma/klvmcq8izis1y8Zy/ibDJxi0QWsACRRsJGwVOfwxebzOKBSWHzJHTZb
         6FzXz+/m/ORw8EBdAtgZJJD1k3x9JLBtyrYWFWyV5xW0bc17exj8eQptHTWe+3gcDcZb
         2hlI9vMeYvdBYn7RxR05J49S7QPaZ0i8sxTd81oiTHWPjvXl5KE/feSdx16G9B80KZaw
         dv3czgMRZ3GjlbUJa04YsSpiWmmAZmPtVg3P61jv9GIqZwT85IimQDoC7X/Fi223HgaO
         MiecW6naWVGSmXvq13KlX684OkqXXvphnyPE7/d70v/FyT5vNuXPiLSaW/vZgypRSGTU
         M2ew==
X-Gm-Message-State: APf1xPAgVuOa56bNW7k/NhxLgmDueZM3Hrs90I6uiu/iDwBNnj13VCXU
        3ey8L0z6Ow5GaN2V/DHS/UUb9815IhXvOXI9CX3Hju0S
X-Google-Smtp-Source: AH8x2255Koe3SFLpUXS0JYLcpppdglobB1qyDpMI8KH0KfZlsGBumwB3voPUjMpROXCG5AICLuopbvJmmyh/0vbhLzI=
X-Received: by 10.13.221.19 with SMTP id g19mr2018680ywe.249.1518565526171;
 Tue, 13 Feb 2018 15:45:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Tue, 13 Feb 2018 15:45:25 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802131831410.16573@localhost.localdomain>
References: <alpine.LFD.2.21.1802131831410.16573@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Feb 2018 15:45:25 -0800
Message-ID: <CAGZ79kY7a0zFkatY4vvTAGjFnvr43EWkFC_RW0O-Lp4e+dwOPA@mail.gmail.com>
Subject: Re: [PATCH] Correct mispellings of ".gitmodule" to ".gitmodules"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 3:33 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> There are a small number of misspellings, ".gitmodule", scattered
> throughout the code base, correct them ... no apparent functional
> changes.

Thanks for catching these!


>  Documentation/technical/api-submodule-config.txt | 2 +-
>  contrib/subtree/git-subtree.txt                  | 2 +-
>  submodule-config.c                               | 4 ++--
>  t/t5526-fetch-submodules.sh                      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Please sign off your patch. (See Documentation/SubmittingPatches)

>
> ---
>
>   fairly brainless correction of what appear to be minor misspellings.

the code looks good.

Thanks,
Stefan

>
> diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
> index 3dce003fd..ee907c4a8 100644
> --- a/Documentation/technical/api-submodule-config.txt
> +++ b/Documentation/technical/api-submodule-config.txt
> @@ -4,7 +4,7 @@ submodule config cache API
>  The submodule config cache API allows to read submodule
>  configurations/information from specified revisions. Internally
>  information is lazily read into a cache that is used to avoid
> -unnecessary parsing of the same .gitmodule files. Lookups can be done by
> +unnecessary parsing of the same .gitmodules files. Lookups can be done by
>  submodule path or name.
>
>  Usage
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 60d76cddd..352deda69 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -28,7 +28,7 @@ as a subdirectory of your application.
>
>  Subtrees are not to be confused with submodules, which are meant for
>  the same task. Unlike submodules, subtrees do not need any special
> -constructions (like .gitmodule files or gitlinks) be present in
> +constructions (like .gitmodules files or gitlinks) be present in
>  your repository, and do not force end-users of your
>  repository to do anything special or to understand how subtrees
>  work. A subtree is just a subdirectory that can be
> diff --git a/submodule-config.c b/submodule-config.c
> index 2aa8a1747..602ba8ca8 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -9,7 +9,7 @@
>  /*
>   * submodule cache lookup structure
>   * There is one shared set of 'struct submodule' entries which can be
> - * looked up by their sha1 blob id of the .gitmodule file and either
> + * looked up by their sha1 blob id of the .gitmodules file and either
>   * using path or name as key.
>   * for_path stores submodule entries with path as key
>   * for_name stores submodule entries with name as key
> @@ -91,7 +91,7 @@ static void submodule_cache_clear(struct submodule_cache *cache)
>         /*
>          * We iterate over the name hash here to be symmetric with the
>          * allocation of struct submodule entries. Each is allocated by
> -        * their .gitmodule blob sha1 and submodule name.
> +        * their .gitmodules blob sha1 and submodule name.
>          */
>         hashmap_iter_init(&cache->for_name, &iter);
>         while ((entry = hashmap_iter_next(&iter)))
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index a552ad4ea..74486c73b 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -485,7 +485,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>         )
>  '
>
> -test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodule entry" '
> +test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
>         (
>                 cd downstream &&
>                 git fetch --recurse-submodules
>
> --
>
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
>
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
