Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612F01F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 17:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJIA0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 20:26:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43844 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIA0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 20:26:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so21690387qtq.10
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=UMUbxdpCchAg6KqpAQ7TJEVpWBEYfs/aUc6O5yIzDrc=;
        b=i2BjC1sXzvXJU7PN6EoUYo0SsDxHV8Wrfj5l8tK/mdlKtu0Xh4LVd8ggatLQGDMvf8
         8ZJyGkFNEjAALpC2u5cBQoGL8GzokwC2Q4dQ4L5VmEh4satZipCfQ6WORgD4pbLykAib
         K6h3X99lbPTSKdaS35yKVUcgsCaX5UpbQhUsSmlZooPDsMhvgASDwx2VHKNhWCnew8ll
         WaRzukz6xVWA9H8ZClfP+EGxlRNFin1WpVg9i4hUxuBTo50sKTSRCTwI1enE7bxki6hS
         1vHPqkdKagZPoiCX/QJlpaJyfJ70m2QNx9mEbhXtkQ2m9NXPKEQDER/TOspnVLCElJ9d
         Q5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UMUbxdpCchAg6KqpAQ7TJEVpWBEYfs/aUc6O5yIzDrc=;
        b=d+MzWDa0AsJFXUmuJm1Nt5nryw0edjf5R8gl9Ls/ybTkO8bDKvZeCFtGQKziFsPN6f
         NDk6hunPlzyViSlRHxgbr951WefxSzxoVkGDu9IgwG98PIU3EXz27j3SjCZcdo3KU+ic
         mznbeGi0KQsab8WcJyCqmm9fjH8X6tJYHS30zEw5d5e8CV2BM+xbYfA8oEjKax7VGP/r
         ZqFR5gIuYLqjdJUXOIsm7w+xWCx/UghK5OGEYlv46bLOQe7mROH/NbEFp1XycpiEeoY3
         GISTXMOxboJizqMN5GrPNaIke/Sf3C78KDQ2ma+i9zBCVv9cbwHmgfr7eElSi620xsoM
         PmwA==
X-Gm-Message-State: ABuFfoitWACMOAQodsW7kiTslQBQSMoSSq/WssdHTgJRst11ixbonQwC
        oFAxzU8hYWLxcZ2FlLa5oxA=
X-Google-Smtp-Source: ACcGV61ZSq/j3+Nkjru9ptYRfdt/LALmmk1FXYfgxEUufzaz68nDFgH+cTpBXt0/PK03/K8VNKk/oA==
X-Received: by 2002:a0c:d285:: with SMTP id q5mr2951980qvh.46.1539018806182;
        Mon, 08 Oct 2018 10:13:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1c56:381e:537f:a878? ([2001:4898:8010:0:58c:381e:537f:a878])
        by smtp.gmail.com with ESMTPSA id k71-v6sm10094106qkh.30.2018.10.08.10.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 10:13:25 -0700 (PDT)
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h
 in header files
To:     Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
References: <20181008170505.GA13134@manohar-ssh>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
Date:   Mon, 8 Oct 2018 13:13:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008170505.GA13134@manohar-ssh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2018 1:05 PM, Ananya Krishna Maram wrote:
> Hi All,
Hello, Ananya! Welcome.

> I was searching through #leftovers and found this.
> https://public-inbox.org/git/CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com/
>
> This patch address the task discussed in the above link.
The discussion above seems to not be intended for your commit message, 
but it does show up when I run `git am` and provide your email as input. 
The typical way to avoid this is to place all commentary below the "---" 
that signifies the commit message is over.
> From: Ananya Krishan Maram <ananyakittu1997@gmail.com>
>
> skip the #include of git-compat-util.h since all .c files include it.
>
> Signed-off-by: Ananya Krishna Maram <ananyakittu1997@gmail.com>
> ---
>   advice.h             | 1 -
>   commit-graph.h       | 1 -
>   hash.h               | 1 -
>   pkt-line.h           | 1 -
>   t/helper/test-tool.h | 1 -
>   5 files changed, 5 deletions(-)
>
> diff --git a/advice.h b/advice.h
> index ab24df0fd..09148baa6 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -1,7 +1,6 @@
>   #ifndef ADVICE_H
>   #define ADVICE_H
>   
> -#include "git-compat-util.h"
>   
>   extern int advice_push_update_rejected;
>   extern int advice_push_non_ff_current;
> diff --git a/commit-graph.h b/commit-graph.h
> index b05047676..0e93c2bed 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -1,7 +1,6 @@
>   #ifndef COMMIT_GRAPH_H
>   #define COMMIT_GRAPH_H
>   
> -#include "git-compat-util.h"
>   #include "repository.h"
>   #include "string-list.h"
>   #include "cache.h"
> diff --git a/hash.h b/hash.h
> index 7c8238bc2..9a4334c5d 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -1,7 +1,6 @@
>   #ifndef HASH_H
>   #define HASH_H
>   
> -#include "git-compat-util.h"
>   
>   #if defined(SHA1_PPC)
>   #include "ppc/sha1.h"
> diff --git a/pkt-line.h b/pkt-line.h
> index 5b28d4347..fdd316494 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -1,7 +1,6 @@
>   #ifndef PKTLINE_H
>   #define PKTLINE_H
>   
> -#include "git-compat-util.h"
>   #include "strbuf.h"
>   
>   /*
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e07495727..24e0a1589 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -1,7 +1,6 @@
>   #ifndef __TEST_TOOL_H__
>   #define __TEST_TOOL_H__
>   
> -#include "git-compat-util.h"
>   
>   int cmd__chmtime(int argc, const char **argv);
>   int cmd__config(int argc, const char **argv);
I applied these changes locally and confirmed the code compiles, so all 
.c files including these _do_ include git-compat-util.h properly.

Thanks,
-Stolee

