Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0B11F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbdASAAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 19:00:41 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33808 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdASAAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 19:00:40 -0500
Received: by mail-pg0-f52.google.com with SMTP id 14so8466457pgg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/y2oTvsnQMOycnAVbkUKWGAoPFC7s8j/ZE1KdIu4vg=;
        b=JXubhhwh7NK6CKqQCeY5sDacay+n7SCKeaF7mIVz9D5WDSGKUIS5iSA47O14fE9BHc
         IlyKYkMyuvSlKRFSTaRgdWltS4FXaNZFa9CywLh0NOmFX/cEAp9rpatJUgwh9CsGI2E0
         qASwlHSZuNhEVc1emSrFI6f2SPNlcdLSqjA8mNZdZIAVen8S8KzLBiErNxxQCXppoLAz
         lxJfkjE6vcXjgw+Df/vdo3m8JeRSBMvuLSZ3BJMOyCKzEzcggRe7B5OeZRll0Mj4objl
         6yfGBWOB/+SNCvFKya45nVm4hlZYU7vG3Zg7BEFx52S7GmbDVQBkne2INOWKJIOrtFcl
         b94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/y2oTvsnQMOycnAVbkUKWGAoPFC7s8j/ZE1KdIu4vg=;
        b=mgGaSU8LSMG7VZpdlomBruMEdrkLaDcfZSqdOsDRf/AuEyAnYSSWvUhKx+nv/2kp5k
         hGu4dFUj+IkTUT70HJ9wpH5ZKElJSgJWj8Yp2H8LMVU6Rr2++ZL27HidONuPy9wkYqkb
         wPRKUDWOob8kLE5bJPXwM6lfmse9v46B9nPloV6KKN4x4Ms8sC/+BSdFVYlsNzd2QrSh
         cIwhtf2DxN+OGmWsuADH5K35SUjTBndCfrpJ7AvfTUrLRJd1lWh8DKBfqAX7Hy0XzuwT
         y/m3wgxY+HaYualXdnNAv4WeMLS17bF7YTyo38YhqLwNfsCuhPsgQJBmHCmXYw5rtQC0
         sSgQ==
X-Gm-Message-State: AIkVDXL5aXrLu1+VdfzO5uE5czJ/n3EJ2A9j6bRiaOaUFDr+08vin6Xu65/A++HVOh2svaYV
X-Received: by 10.98.93.152 with SMTP id n24mr6677779pfj.107.1484784039275;
        Wed, 18 Jan 2017 16:00:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id z70sm3323498pff.26.2017.01.18.16.00.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 16:00:38 -0800 (PST)
Date:   Wed, 18 Jan 2017 16:00:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCHv2 3/4] cache.h: document add_[file_]to_index
Message-ID: <20170119000037.GF10641@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
 <20170118232145.31606-1-sbeller@google.com>
 <20170118232145.31606-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118232145.31606-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  cache.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 87eccdb211..03c46b9b99 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -609,13 +609,24 @@ extern int remove_index_entry_at(struct index_state *, int pos);
>  
>  extern void remove_marked_cache_entries(struct index_state *istate);
>  extern int remove_file_from_index(struct index_state *, const char *path);
> -#define ADD_CACHE_VERBOSE 1
> -#define ADD_CACHE_PRETEND 2
> -#define ADD_CACHE_IGNORE_ERRORS	4
> -#define ADD_CACHE_IGNORE_REMOVAL 8
> -#define ADD_CACHE_INTENT 16
> +
> +#define ADD_CACHE_VERBOSE 1		/* verbose */
> +#define ADD_CACHE_PRETEND 2 		/* dry run */
> +#define ADD_CACHE_IGNORE_ERRORS 4	/* ignore errors */
> +#define ADD_CACHE_IGNORE_REMOVAL 8	/* do not remove files from index */
> +#define ADD_CACHE_INTENT 16		/* intend to add later; stage empty file */

I usually prefer having defines like these use shift operators to set
the desired bit '(1<<2)' instead of '4', etc.  Is there a preference for
git as a whole?  I know this is just a documentation change so maybe
this isn't even the place to discuss this.

-- 
Brandon Williams
