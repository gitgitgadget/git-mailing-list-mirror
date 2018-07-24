Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90941F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeGXXGJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:06:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33476 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbeGXXGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:06:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so2347688plb.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2FOJL1AYftJCPrxMKqlZSXRf2FwzB3c8eSP7YQu8W4=;
        b=TaNVYrfZE8IEQHX8oS57YiW+ODenObhZkMSbE0uHk7v2u7M0EfAF+exR48FoICbpxO
         h3l3Iipsuomek2xkK0lvkE7Fsbc5tFct8rrrc9HX/sKf3zVC+c0FwW6x0/3aDT/rN/Qz
         eIu80WUM975HpHhYgr95GVcZBrjbcJkqTCB/UOY0YKt3p+GVWXkQWuckP7RibpL3/025
         SWM1YX3dmFsxhdARItSKMfDElgmGibUDUSTDjIa8PL6B26V6fiBghOm82jzPH7Q+t63q
         ld17UgL9ikQFfz6dr+YnK6faIW0GSZLA/mgodd+uBa1h7Y52ZLhXfgxODvzmUO/YLX6d
         l7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2FOJL1AYftJCPrxMKqlZSXRf2FwzB3c8eSP7YQu8W4=;
        b=ZZG0Gwf2Nrnp/FQQQB6avBDpo9LLpQO/LJx4oGa2Z1HZiGLE/tv4KSI8Ck9UQwh9Gh
         FCYbVsIbzsJiBhULbcs1xmKEdF2Bywbj9/Czp1SHWT/eo5UuT/00HPRF1HY+iNCoEQ7+
         zsPvIUla9BXbu5HOBwbt09XsEEburzhKtErH0FNIXz0s0fLHe0BqOYyWz4utyj2+0wuC
         4EVH+0nYYua7fjOTUvli65YFvgfnLlWRINY9FDH95M3FlidtIJURQVZ1xzu81L1JybN8
         bIVs6QUxrO5pxZhfA65iDpm9q01lBCf3LhVomRatqhmtfsIcyXUBUjgWw5+is1auiQ9u
         b5Zg==
X-Gm-Message-State: AOUpUlEBtR8Fuqz4tDp5o3P/0MY+aYVHSMHcluexfdJMjbfMU2bV4Fgz
        7dC629Ld4RyJm5MCCKKQlmOfZX4P
X-Google-Smtp-Source: AAOMgpeQr0xoIGXzvE9mWHs/c4nPA0t4cNrYoCR20WCFiXiSARvboXXZe0NOVY9gP+3wS3QJVR0Ckg==
X-Received: by 2002:a17:902:243:: with SMTP id 61-v6mr18320964plc.301.1532469458832;
        Tue, 24 Jul 2018 14:57:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u13-v6sm16569514pfm.121.2018.07.24.14.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:57:38 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:57:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/2] packfile: drop a repeated enum declaration
Message-ID: <20180724215736.GC136514@aiede.svl.corp.google.com>
References: <20180724215223.27516-1-dev+git@drbeat.li>
 <20180724215223.27516-2-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724215223.27516-2-dev+git@drbeat.li>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Beat Bolli wrote:

> --- a/packfile.h
> +++ b/packfile.h
> @@ -6,7 +6,6 @@
>  /* in object-store.h */
>  struct packed_git;
>  struct object_info;
> -enum object_type;
>  
>  /*
>   * Generate the filename to be used for a pack file with checksum "sha1" and

Good catch.  This means packfile.h should #include "cache.h" ---
otherwise, it is not usable in a file that does

	#include "git-compat-util.h"
	#include "packfile.h"

Thanks and hope that helps,
Jonathan
