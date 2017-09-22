Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09039202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdIVVhp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:37:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:50597 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdIVVho (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:37:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id m63so1140540pfk.7
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGhWxONy8pBoSRIXh63LXHTUVbwgwvcU/RQJsCKPwpI=;
        b=bNIH6DHXv9tt/qPiHm0S9evWY05LlTqBj0HaZNjDPVPmpZiffBVrtR2HSUZ/sFiHZZ
         Duq5u3jLNLnpvEbc5pdgewMNT/sqMZdkjf4D7HZvwZz10SGuuvrGW1tLUVGyk4G72fQo
         DHIaJsg7h9K6AAAkT0coEz4rhHxiF1RhJvDxwB1C6M42Qoczjp8kQVkiGRIjfRbuWd87
         CTy7YyCyJeaNGyiwqmyUmeJPB7keTtWy12yJLk+SUeGRzUz78sAc/Vjd3spLUt2D9Rh+
         Fbpvr6uOnaXdFqkgZK98vHldQ2PUiYI0VX2yfM2lXHKdERTRVAKYPpFpPXPZt+JktOMB
         bs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGhWxONy8pBoSRIXh63LXHTUVbwgwvcU/RQJsCKPwpI=;
        b=RsG2lGOpuIfyXZ0NrxHNAXFC55/MYOFJ3mwY2KAF4ixvkI1SNI1/P1w3ZGLnZF2nFb
         691StBm2EX+SetgQOInh/AAuPBMxqqLMhDc3pmYFKDL51UKNASAe18hB0Ux1mssNdJgK
         erWXVuEJm68E+dSRVgjO//i20Mr6EE7AQ46jQSYdq/Mrf5l7q/w9EnJ9Hogy6uhfQzyY
         T5pEoqk5krLWAtebTM5NdQjhcR92tvCpZBIs/Pd+bTK9uRaaG2DokjTODEz6h+6DPS7M
         FW6QzGMeo15RUWSx1DbehX+jwGiCrZQVomBzlLUdH+SY8q403elj19PuyveHp1OK6pu+
         a27g==
X-Gm-Message-State: AHPjjUi18x+uYEqPp6uNrmwrh0+z+shiOnausPufT89gGruoDUgG46lk
        GKSrc6hNSNpbjKd4kIYRxRIbQ8zn
X-Google-Smtp-Source: AOwi7QCYF5jXE5zse+OZmbj7DyJKfJ3zXeJ3WDxR32ARhP5T9THoSHuaDQ/G7/TQuatmon3OagcFbw==
X-Received: by 10.159.255.12 with SMTP id bi12mr25907plb.284.1506116263168;
        Fri, 22 Sep 2017 14:37:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:a8e5:9a8:2d5b:f3dd])
        by smtp.gmail.com with ESMTPSA id x128sm807869pgb.6.2017.09.22.14.37.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 14:37:42 -0700 (PDT)
Date:   Fri, 22 Sep 2017 14:37:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/config: clarify the meaning of
 submodule.<name>.update
Message-ID: <20170922213740.GL27425@aiede.mtv.corp.google.com>
References: <20170922212818.9958-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922212818.9958-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> With more commands (that potentially change a submodule) paying attention
> to submodules as well as the recent discussion[1] on submodule.<name>.update,
> let's spell out that submodule.<name>.update is strictly to be used
> for configuring the "submodule update" command and not to be obeyed
> by other commands.

Good idea, thank you.

You'll want to update Documentation/gitmodules.txt, too.

I think this can go further: it should say explicitly that commands
like "git checkout --recurse-submodules" do not pay attention to this
option.

> These other commands usually have a strict meaning of what they should
> do (i.e. checkout, reset, rebase, merge) as well as have their name
> overlapping with the modes possible for submodule.<name>.update.
>
> [1] https://public-inbox.org/git/4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com/

Can you summarize what this discussion concluded with so the reader
does not have to look far to understand it?

> Signed-off-by: Stefan Beller <sbeller@google.com>

Reported-by: Lars Schneider <larsxschneider@gmail.com>

> ---
>  Documentation/config.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index dc4e3f58a2..b0ded777fe 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3085,10 +3085,9 @@ submodule.<name>.url::
>  	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>  
>  submodule.<name>.update::
> -	The default update procedure for a submodule. This variable
> -	is populated by `git submodule init` from the
> -	linkgit:gitmodules[5] file. See description of 'update'
> -	command in linkgit:git-submodule[1].
> +	The method how a submodule is updated via 'git submodule update'.
> +	It is populated by `git submodule init` from the linkgit:gitmodules[5]
> +	file. See description of 'update' command in linkgit:git-submodule[1].
>  

Wording nits: s/The method how/The method by which/; s/via/by/

More importantly, can this be more explicit about how it is meant to
be used?  E.g. to say

 1. This only affects "git submodule update" and doesn't affect
    commands like "git checkout --recurse-submodules".

 2. It exists for historical reasons; settings like submodule.active
    and pull.rebase are more likely to be what someone is looking for.

Thanks and hope that helps,
Jonathan
