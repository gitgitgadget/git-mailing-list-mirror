Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E361F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 01:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfJZBMy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 21:12:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38321 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJZBMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 21:12:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so2803404pfp.5
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tGdRXhHZJScjvnV6wSLvv8/EAbgxFVY8xb600ZQrpNo=;
        b=UJ6bDZBvmkfTR/KvU4C+ZfLoTIaDaq+6+XnDeDFc3MH8AO7aIDvRpHPKybHjCMkENS
         vfMYjxzBPIkWW45bwlsnr7ZDBf3ncy46fwZm1jCfnJ1pk37+QImpMoGME+sWkJby+dX7
         /sjGJKPERHI+lZJynzo4FuNRC84MCpLznmO8Dm90irZO08lneOas36GmfksimgsvmpzZ
         pLiNKcgyCPIhWTXN3K6LMWZHav7OUOHWAKmnkoiCwhByo/CjbzzjUbL4nUhiklvrGA41
         1bAfZ6vTgGHqWLriTi3bpuG3dnKDe/ON/vyyL5wQ5I9nmKRp74k6d84CmiZDaqcIrQSg
         a8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGdRXhHZJScjvnV6wSLvv8/EAbgxFVY8xb600ZQrpNo=;
        b=IDjOi2icT4IM6c6hVs1QgjLTyhIfaT5bXssWFg4YUyVuTExZePnlytia5ZTFmA4p0P
         tWlOGNutLIlov+ye+zUMnduxCaX2Y/ZkfaBcbWmDMSeG8zb+PuSKvfVR3ugPKTpbA6y3
         FmuPsBiF2jsoq6A+VyVGUYeI7DdF1eACBK1DMfwXP7vmdHFg7ugsakz33FJ6AG0Vc1sN
         g5MskqlK70A9csYswJ4lMItamf8POEubJk37NjPQM8KplG8vARDKG6QchgXY8XIn6cvx
         8FcyTexrtgMp5agBawF7PNuXjWnLvlcn2B7n+0QqkV9MEiDEXJKSQneOEUTCGomHgrhn
         2wRw==
X-Gm-Message-State: APjAAAX+7VVCnC4YByJW8v4z2g3CwzyNb6BzJFQ1lC3ZBfmXaCbtzE9q
        tm5GmtOo6G9m3XmqqITG/wC60LcA
X-Google-Smtp-Source: APXvYqz27YfA7BP6HwRVS8cDpMG91iXpAtmw07Sa9KjkjewgXcaL56qqGaIwFwDRoo+JohMdZHzT5g==
X-Received: by 2002:a63:1b0d:: with SMTP id b13mr7773360pgb.312.1572052373103;
        Fri, 25 Oct 2019 18:12:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t13sm3494054pfh.12.2019.10.25.18.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 18:12:52 -0700 (PDT)
Date:   Fri, 25 Oct 2019 18:12:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] myfirstcontrib: add dependency installation step
Message-ID: <20191026011250.GB39574@google.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026005159.98405-3-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> Indicate that the user needs some dependencies before the build will run
> happily on their machine; this dependency list doesn't seem to be made
> clear anywhere else in the project documentation.

In theory, this info should be in INSTALL.  I wouldn't be surprised if
it's missing some info, though.

[...]
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -38,6 +38,30 @@ $ git clone https://github.com/git/git git
>  $ cd git
>  ----
>  
> +[[dependencies]]
> +=== Installing Dependencies
> +
> +To build Git from source, you need to have a handful of dependencies installed
> +on your system. For a hint of what's needed, you can take a look at
> +`ci/install-dependencies.sh`.
> +
> +To install the dependencies needed for a basic build on Linux, run something
> +like this (or replace `apt` with your distribution's package manager of choice):

pedantic nit: s/or replace/replacing/ ("or" would mean rpm is an
alternative to what came before, but "something like" in the phrase
before has rpm already included)

> +
> +----
> +# apt install libssl-dev zlib1g-dev libcurl4-gnutls-dev libexpat1-dev

Perhaps build-essential, too, in case they're using a system not set up
for development.

> +----
> +
> +Make sure that your environment has everything you need by building your brand
> +new clone of Git from the above step:
> +
> +----
> +$ make
> +----
> +
> +NOTE: The Git build is parallelizable. `-j#` is not included above but you can
> +use it as you prefer, here and elsewhere.
> +
>  [[identify-problem]]
>  === Identify Problem to Solve
>  
> @@ -138,9 +162,6 @@ NOTE: When you are developing the Git project, it's preferred that you use the
>  `DEVELOPER` flag; if there's some reason it doesn't work for you, you can turn
>  it off, but it's a good idea to mention the problem to the mailing list.
>  
> -NOTE: The Git build is parallelizable. `-j#` is not included above but you can
> -use it as you prefer, here and elsewhere.
> -
>  Great, now your new command builds happily on its own. But nobody invokes it.
>  Let's change that.

With whatever subset of the changes above make sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
