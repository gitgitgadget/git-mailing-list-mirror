Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1936A201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbdBQXHM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:07:12 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35078 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbdBQXHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:07:11 -0500
Received: by mail-pf0-f181.google.com with SMTP id 68so5558489pfx.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6kx5NkIzZ1qOxbHzB5NKnU2tE8tcm2vNwyTdOQt/Ic=;
        b=mEN5+l8p8EqZEIci1GCAJwqnU8FQWSGVMPXvRXeeTtNofums1pq94kKZvKHSEPSiMh
         gg8R7TMZvy43+AIvWarDhAGZb6sBgYpfymw4rF1m6GRYkzs1RDT9m8gy9T21ScGJSir8
         N8Od4v+4o3FKsBuS0t0ycrGF8p9y3eB3jbaKMSv951KTTgZ0l0MBajAW/F2zj8g4SUra
         zxDz9KLN9Qtv5h2lEs3V9vANq0k3oxMP5OOhr28vi5ZgBC+mF23IjecEa+M0h8cpzyoW
         PGnGIML9CSliXFUnebLKi258/DqMAbmoQ+Sh1OT5KHTJjTsj4ahAB/jqnDBdAJIqa2+3
         OpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6kx5NkIzZ1qOxbHzB5NKnU2tE8tcm2vNwyTdOQt/Ic=;
        b=M07kCMGSOlq2CkKw6EhpkxUHtBUl0/GXlcGWgiI2gk7WLt0ZtF+Td0oV0zNVwCrhs7
         BhQenG62xBLdwqtzUf1m6eInBBV9tKobFa33rdolPFamV2P+3m83RTqiw8XZqmxwiFEI
         cxidN0Wgg7m1tMN/nD2kxeMjxOP1VKWV11H9cHCoQktbpLM/SKP0eH1L6IG4ujCYk+su
         MG5VKnByGvpJUZpgZZuIk+SYuJoqGP6+dHcR9sE6rbjIcQjI14U+HbkKDkFGOFjzjqGs
         eLAz/aL0XCl470MQhyitXI5Ms2Csf8FXnfkUbXdy/kO4sKClU+DNuWmnX8kqIFOUILj8
         tD4w==
X-Gm-Message-State: AMke39l1Q5eIXOle+tcRCWCA8u4WVGx/iNicMrD0x4s+Zba8l2F/0PvcfFJ9d9Y+71/Vops+
X-Received: by 10.99.215.5 with SMTP id d5mr13267894pgg.51.1487372830317;
        Fri, 17 Feb 2017 15:07:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:8ee:9aa0:dea:69e7])
        by smtp.gmail.com with ESMTPSA id s21sm21477422pgg.65.2017.02.17.15.07.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:07:09 -0800 (PST)
Date:   Fri, 17 Feb 2017 15:07:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Phillip Sz <phillip.szelat@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] submodule.c: Add missing quotation marks
Message-ID: <20170217230708.GA13751@google.com>
References: <20170217230433.23336-1-phillip.szelat@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217230433.23336-1-phillip.szelat@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18, Phillip Sz wrote:
> Hi,
> 
> just found this while translating, sorry if this is intended.
> 
> Best regards,
> 
> Phillip

Definitely not intended.  Thanks for catching that.

> ---
>  submodule.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6..b064ed080 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1181,7 +1181,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	cp.dir = path;
>  	if (start_command(&cp)) {
>  		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
> -			die(_("could not start 'git status in submodule '%s'"),
> +			die(_("could not start 'git status' in submodule '%s'"),
>  				path);
>  		ret = -1;
>  		goto out;
> @@ -1194,7 +1194,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  
>  	if (finish_command(&cp)) {
>  		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
> -			die(_("could not run 'git status in submodule '%s'"),
> +			die(_("could not run 'git status' in submodule '%s'"),
>  				path);
>  		ret = -1;
>  	}
> -- 
> 2.11.1
> 

-- 
Brandon Williams
