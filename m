Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C6B1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeFEUhc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:37:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35069 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeFEUhc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:37:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id i5-v6so2259817plt.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HxDN1zZ4PCa/hea3y+iJgXQm8XjL27CdMmvnqIJxM2M=;
        b=iKmJi5cZSd9oNgIvGUat6sUNYkE3TbmSq6NNKBgfuKkDf5ogeKi9llTFvpuA9NYEqa
         B2B+UjFkq50nr1/oPcR8OCH2eMsc8aiU2AC3Et16FULRNH6pUKhi65o7wkVmHcy4ciU4
         5KAF1nGDzwqukbBz2CBDWBbUcLNF+9hiqXbIuY2DEj0SWgC6FN6B659UM1VOJFOLtbYl
         WBRD5vsGjLOYbJ5kshWB4vGxZ/tlfjpaqWZWHdlseKIipgUZiq9Y7+Js7ZZ8D742IIoN
         XedmIhT6+WjG6DWFF2s2GWPzONNGIIsdqHPb7X2n7M5vxN73qI/zuMSf0s1R999F/DBW
         jWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxDN1zZ4PCa/hea3y+iJgXQm8XjL27CdMmvnqIJxM2M=;
        b=c10Z7FSgwzxtP4bMJit62R4fxwxOmiZAaJ3kAqqhTs37wextTDVOWuQTISTwmfexZC
         u8wY3r1M7NU+IHOwiCc2kppzA2XxUWxSIah18xLYtDHIIDTbVcavtlMY1Upx983h/ny0
         AnJ2+OSeWfQZshpA57sUdggXBt9F5jSVQYHUDqo5c9jMX8Kcjz/mxpGgxYsjS2TCKE2D
         osrvVim5IkQetiHmHgpTdtOjGKVrErOznpCTKIoV7rD0e2IuBRmnNIdIcVEGfM3t/F7s
         bfnrdJL057bogBdLlDdleC8oF3erHXMTAZ7AGHU+r5yJpANn+BkdYcuSLaAMMsHIMfNq
         SFtg==
X-Gm-Message-State: APt69E1nObXuU82nBzPBABKl9U3Pmi+iINumAI/xyzx8TV9UqyREmLCw
        4eci8K70l96eIZt+0K6JF6w=
X-Google-Smtp-Source: ADUXVKKrLAJIQJ9wywsuqHGil/ZUaI3Dv6Rur+ASltOU8MoXp0dy8B0+UTYxkxvbDB5El/DAlTG73w==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr166779pls.264.1528231051544;
        Tue, 05 Jun 2018 13:37:31 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s134-v6sm32145457pgc.30.2018.06.05.13.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:37:30 -0700 (PDT)
Date:   Tue, 5 Jun 2018 13:37:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: link to gitsubmodules
Message-ID: <20180605203704.GA9266@aiede.svl.corp.google.com>
References: <20180605202449.28810-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605202449.28810-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Add a link to gitsubmodules(7) under the `submodule.active` entry in
> git-config(1).
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a..1277731aa 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3327,12 +3327,13 @@ submodule.<name>.ignore::
>  submodule.<name>.active::
>  	Boolean value indicating if the submodule is of interest to git
>  	commands.  This config option takes precedence over the
> -	submodule.active config option.
> +	submodule.active config option. See linkgit:git-submodule[1] for
> +	details.

This takes the user to gitsubmodules(7), but with a hop to
git-submodule(1) along the way there:

	DESCRIPTION
	       Inspects, updates and manages submodules.

	       For more information about submodules, see gitsubmodules(7).

I suppose I'd prefer that it links directly to
linkgit:gitsubmodules[7] just because that would steer people toward
commands like "git checkout --recurse-submodules" instead of "git
submodule init".

With or without that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Tested using

	make -C Documentation/ git-config.1
	man Documentation/git-config.1

Thanks,
Jonathan

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 1277731aa4..efbd7e5652 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -3327,13 +3327,13 @@ submodule.<name>.ignore::
 submodule.<name>.active::
 	Boolean value indicating if the submodule is of interest to git
 	commands.  This config option takes precedence over the
-	submodule.active config option. See linkgit:git-submodule[1] for
+	submodule.active config option. See linkgit:gitsubmodules[7] for
 	details.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
-	commands. See linkgit:git-submodule[1] for details.
+	commands. See linkgit:gitsubmodule[7] for details.
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
