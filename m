Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BA52035B
	for <e@80x24.org>; Mon, 10 Jul 2017 22:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbdGJWu0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:50:26 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36555 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754848AbdGJWuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:50:25 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so56392242pgb.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h2TG5vHJcN32P6eE6oGTGKAVqbeXvGV7IbfEclN7l9I=;
        b=QwMq4FsND+JgmSjgVkLZlaahie6VlSd82oJEPztx7A7lbzFgiLchAhLbCrTKnzfAIP
         v1x8oN0iML5f46uLoLd3GL5YGBbM42QKFPNjx6VrQFwK9OZ/Aof6grSOTtV/SezeYiRf
         OSeI+IsgaFnciOpGDusIvEN0Pcdq5rouo/XMZb6URc2xPRhV2v12Esvr0433Xn9KGwah
         din7j/6u4EmfkIk00VK7LJt65fPs19WlEaf/sXg5CxbWWuIxOVsglo2hYXJ3smTi9ZR4
         NJEP5nWWO13BUVNxD0Rci6OfvQs8+vE7hh41Z0zJEhkj905ZwEBird38G7zpX4OJDtEG
         nRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h2TG5vHJcN32P6eE6oGTGKAVqbeXvGV7IbfEclN7l9I=;
        b=mtGvzKx1E4J4f7fwXbb/qZT4COKvKNWGBWRRYk8CKLRIt5k3DR559ZsoSL4XOQ/gA6
         m8ha+OxWob51oQPaOpzBjFRceXrjqcP/Ork0YC5LYoy5hf8vmTZf/6V95ToBmNHOWtqE
         gxack/ekCXJgLhJZ4mJQPNulLX8HHBG2RqEpw+v7sWQwlOY6fDqrO5oMxXKm6Mhv6QAx
         eGppgDfeTSn1eFe3oCR55WHq4MP938G+T5L0FszIjUaYrQs7Wfiy5rq4KHJlUTGAt9hr
         n0SGOX33NWke0aRlr37cL+kPeHQXu+eoAYDeQHUBbR4uw7IovqEWSQqGU6jKkyAXJh/y
         B++g==
X-Gm-Message-State: AIVw110y+BXrglsqEOy/KW65Wa4DAw2wJATDqE2VpfbyTkKMqC7liJO1
        vpZYU5VaoEnargIt
X-Received: by 10.98.178.15 with SMTP id x15mr46000344pfe.75.1499727024880;
        Mon, 10 Jul 2017 15:50:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c8d3:611:f474:c770])
        by smtp.gmail.com with ESMTPSA id e189sm24162157pfe.100.2017.07.10.15.50.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:50:24 -0700 (PDT)
Date:   Mon, 10 Jul 2017 15:50:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/7] api-builtin.txt: document SUPPORT_SUPER_PREFIX
Message-ID: <20170710225022.GB161700@google.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <1b08c5f568028645325367d6d6b97b9da17894ff.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b08c5f568028645325367d6d6b97b9da17894ff.1499723297.git.martin.agren@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10, Martin Ågren wrote:
> Commit 74866d75 ("git: make super-prefix option", 2016-10-07) introduced
> SUPPORT_SUPER_PREFIX as a builtin flag without documenting it in
> api-builtin.txt. The next patch will add another flag, so document
> SUPPORT_SUPER_PREFIX, thereby bringing the documentation up to date with
> the available flags.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/technical/api-builtin.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
> index 22a39b929..60f442822 100644
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -42,6 +42,10 @@ where options is the bitwise-or of:
>  	on bare repositories.
>  	This only makes sense when `RUN_SETUP` is also set.
>  
> +`SUPPORT_SUPER_PREFIX`::
> +
> +	The builtin supports --super-prefix.
> +
>  . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
>  
>  Additionally, if `foo` is a new command, there are 3 more things to do:

I added SUPER_PREFIX as an implementation detail when trying to recurse
submodules using multiple processes.  Now that we have a 'struct
repository' my plan is to remove SUPER_PREFIX in its entirety.  Since
this won't happen overnight it may still take a bit till its removed so
maybe it makes sense to better document it until that happens?

Either way I think that this sort of Documention better lives in the
code as it is easier to keep up to date.  Last time I tried to look at
stuff in Documentation/technical the files were either place holders or
completely out of date with what the code did.

-- 
Brandon Williams
