Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2561F424
	for <e@80x24.org>; Wed,  9 May 2018 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965877AbeEIRTy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:19:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37971 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935551AbeEIRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:19:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id n9-v6so22968452pgq.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzAHdUiaMylzZvUFqc6ISS3/5icIKa/Q2hRkapWHHsw=;
        b=vLJxdim8c3v7Xa7dIJ7uIY7yOOOwVDMbVSujnBfczwR9LNh/kaN/zoWcXFobMPijZw
         tp2uDfjPyNXbLLoMQYF9vPuVYyklrrOCrUyPqTcSMjs1XFjv5HAKXHfayDyDPyTr2S0h
         XIJZ5uDuKtH2ugTpIF/quLx1I5CAT01+Sy3I78QTIkCg/+VlQf6hOqgPj8x510ZSB061
         bCwQDj+X5pbNtjDel2xjFYtFB7xhyU50SgLmRCVsX1zlXJPdJVxBVf4BJiWzksnoLAQh
         jd6pXCOLuXRX6k2C4CIvbDceM3mg7S2L9Gz9Y8R77FI6KMfFR8cyZnHoUan9aIvJXtpb
         i4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzAHdUiaMylzZvUFqc6ISS3/5icIKa/Q2hRkapWHHsw=;
        b=GdyB2UpXm7+qKpa+TzKfLa9qRo8xfz5hwe27HozuI6OQBcVwJKKbZdDZofSQMNEvnf
         sZAbk5F0cfhiKUvkGt1zMwovsWBZmoDMRKIBhpnxkqPhepjGk9wdSYglDVq0n2kEiFX7
         8viyJJDz0ONcHOtN/gZhnAVb28NIbHcWTfb9kyLSIbP6HTFOdaolhVwNxSVehydTi6TM
         W1L3WiqjVpbOhhn74Ib3jCzDNv1iDKRLrhTHSds4qfjlg7Z16tKRTaiPrSENSg9HIrFi
         zowNeLaFRvd11Okn0FvGhRXi4PcuJm8Mbvdkt/r3lUC/bq47iPpX4xQ9CeWkumxdWB+k
         +qMw==
X-Gm-Message-State: ALQs6tBXQvmcn2NI7Or3dYY4CCR2/tVv4tqXm0YR/ItXLLkU6d4R82un
        ZZ8MszDDQU72IG6eU0QQUft8xGzKAC0=
X-Google-Smtp-Source: AB8JxZq8+MuXZiYxhSc0qVyLfeKKYxS+47fTxCiFidHYV5UPe9iRDSS5mI2IJj+1OlHO5fBNyXSQUQ==
X-Received: by 10.98.196.19 with SMTP id y19mr44781880pff.97.1525886391559;
        Wed, 09 May 2018 10:19:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t14sm45880649pfa.31.2018.05.09.10.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 10:19:50 -0700 (PDT)
Date:   Wed, 9 May 2018 10:19:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix config API documentation about
 config_with_options
Message-ID: <20180509171950.GB63423@google.com>
References: <20180509131628.20099-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509131628.20099-1-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/09, Antonio Ospite wrote:
> In commit dc8441fdb ("config: don't implicitly use gitdir or commondir",
> 2017-06-14) the function git_config_with_options was renamed to
> config_with_options to better reflect the fact that it does not access
> the git global config or the repo config by default.
> 
> However Documentation/technical/api-config.txt still refers to the
> previous name, fix that.
> 
> While at it also update the documentation about the extra parameters,
> because they too changed since the initial definition.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
> 
> Patch based on the maint branch.

Thanks for updating the docs.  Maybe one day we can migrate these docs
to the source files themselves, making it easier to keep up to date.
For now this is good :)

> 
> Ciao,
>    Antonio
> 
>  Documentation/technical/api-config.txt | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 9a778b0ca..fa39ac9d7 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -47,21 +47,23 @@ will first feed the user-wide one to the callback, and then the
>  repo-specific one; by overwriting, the higher-priority repo-specific
>  value is left at the end).
>  
> -The `git_config_with_options` function lets the caller examine config
> +The `config_with_options` function lets the caller examine config
>  while adjusting some of the default behavior of `git_config`. It should
>  almost never be used by "regular" Git code that is looking up
>  configuration variables. It is intended for advanced callers like
>  `git-config`, which are intentionally tweaking the normal config-lookup
>  process. It takes two extra parameters:
>  
> -`filename`::
> -If this parameter is non-NULL, it specifies the name of a file to
> -parse for configuration, rather than looking in the usual files. Regular
> -`git_config` defaults to `NULL`.
> +`config_source`::
> +If this parameter is non-NULL, it specifies the source to parse for
> +configuration, rather than looking in the usual files. See `struct
> +git_config_source` in `config.h` for details. Regular `git_config` defaults
> +to `NULL`.
>  
> -`respect_includes`::
> -Specify whether include directives should be followed in parsed files.
> -Regular `git_config` defaults to `1`.
> +`opts`::
> +Specify options to adjust the behavior of parsing config files. See `struct
> +config_options` in `config.h` for details. As an example: regular `git_config`
> +sets `opts.respect_includes` to `1` by default.
>  
>  Reading Specific Files
>  ----------------------
> -- 
> 2.17.0
> 

-- 
Brandon Williams
