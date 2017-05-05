Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE050207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdEEXuV (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:50:21 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36523 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbdEEXuV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:50:21 -0400
Received: by mail-pf0-f172.google.com with SMTP id q66so8995868pfi.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L3ja0qhmqEJsU/joD+1USewTO88912rwPiQzsGcCy0c=;
        b=mcRfh/sEEtoRApj97NHJpSrxEVyKQL5mWFt2ckP1ZQZFynqQ441gnua9pHDa/jJMKx
         s3XxdtW02w7E8/yWhgV1ExtHHZ9VQ25vrxhMBzmE3MytfFO4L5xWSVPHZCArtqediBGU
         suyDrRPoKL6Wbvjdgj2a2z1njuBxkoCHF5StkXfruO332+lFfTVIijx0DWmxAsdhc317
         ltRckeAYKkYM/FOXh3mR74XufQOiDEXltyPNv2RDWeikpEAnwbCnv2Jl0At5Fz2/bonL
         QSOwda/qU2FZLF1b7v29OeSfelo3KRR5ZWd5H3KtFuih0zBgInt/zNtLQMy1URJwvfNz
         YIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3ja0qhmqEJsU/joD+1USewTO88912rwPiQzsGcCy0c=;
        b=ihdGIe63FcOsNSusJXL4LekhTFU/3n45puxPUJTaDJCE1aC/AORtRznH8T+ceIBLYa
         wchl0dq+OEdII92jJa8bsRljr05EtGzrlU9JWvVQyzQipuwdZ7uZ78KKVWYomBkgV8vt
         LGlsdGDgYv/p23Rmo1jP50CZXg0KR+ytdhQi7TbrjOYt9JNB9pqTpDeuVgTwrc1kRgDa
         0uyCk1I2k8P5TN3XyiRJTedlGZBHrYU3K+vACLWkH77wfeIRMALW7Jv9wE6tCmyS9MGM
         5IGgG7FvT5aPwP4AOVef4H4bIcQAtlCGxAMK6L4c/WmLY5KZRI71Kt1S/kzBYgXZzR1d
         hMUw==
X-Gm-Message-State: AN3rC/4/QfQ2GYMIHN8UGCICUXPWirxb26ZldspszhXHN6gB3hiGe5LV
        70KCQ1WTuEqKrOJI
X-Received: by 10.84.128.33 with SMTP id 30mr10846756pla.111.1494028220383;
        Fri, 05 May 2017 16:50:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:68f1:1fe9:5380:71aa])
        by smtp.gmail.com with ESMTPSA id c83sm12377247pfd.113.2017.05.05.16.50.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:50:18 -0700 (PDT)
Date:   Fri, 5 May 2017 16:50:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/3] docs: correct receive.advertisePushOptions default
Message-ID: <20170505235017.GC55152@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05, Jonathan Tan wrote:
> In commit c714e45 ("receive-pack: implement advertising and receiving
> push options", 2016-07-14), receive-pack was taught to (among other
> things) advertise that it understood push options, depending on
> configuration. It was documented that it advertised such ability by
> default; however, it actually does not. (In that commit, notice that
> advertise_push_options defaults to 0, unlike advertise_atomic_push which
> defaults to 1.)

This looks like a good fix to the documentation as advertise_push_options
does indeed default to 0.

> 
> Update the documentation to state that it does not advertise the ability
> by default.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/config.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5..f49a2f3cb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2620,9 +2620,8 @@ receive.advertiseAtomic::
>  	capability, set this variable to false.
>  
>  receive.advertisePushOptions::
> -	By default, git-receive-pack will advertise the push options
> -	capability to its clients. If you don't want to advertise this
> -	capability, set this variable to false.
> +	When set to true, git-receive-pack will advertise the push options
> +	capability to its clients.
>  
>  receive.autogc::
>  	By default, git-receive-pack will run "git-gc --auto" after
> -- 
> 2.13.0.rc1.294.g07d810a77f-goog
> 

-- 
Brandon Williams
