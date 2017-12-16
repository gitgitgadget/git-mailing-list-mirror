Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7091F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdLPJfA (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:35:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36303 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPJe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:34:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so21649012wmg.1
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 01:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0bVbKiL3dHi6IQcn8BVZpZ4ddmEraQlGb2aMy5+G+vM=;
        b=p8LR/wgLdTiorTu4TwP7p2k9N9Goj4n6LSkINEMygwFQKQWQTwXrRzehPt0phtKVzr
         Dt+XY/Lo6w+L00zRiGHvPFgHmdtU2gBahV/Gf4pVC0hEfFtkqBkxoWxelvApUijWUbxw
         9q28bHsGyBXxuJkKsakmZGco1u61ZAQ2jkhAUijoyDuqrmK5nOmikcT+fckDJMeW+8D9
         ZXATHkNme2gnF0zAtEZbxihKphduPbHdZoQfUKDUFMkomN0NoIHZXQeVPwKlFh5X74Ue
         Tud51hE8/WGC7c/sbxptDIidLT/Z3NWn2rmEFMiKQSZ9nG5E8fGJ2VWFHe5lMYhxeYfD
         yQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bVbKiL3dHi6IQcn8BVZpZ4ddmEraQlGb2aMy5+G+vM=;
        b=BsrZEqCB+UZeeGuVLN5ry6D33KoB+S85mdgnlZFmLta4lQlyVw8F7AcyTYVA1dRzXl
         DoCi1F2ssxzM+PcAb5rdnmDbd1AjQR1iDL9KlrrLr0pfsVPU6TzDgr4hXjlavzAOxcMj
         fo4qbbqbDaXWTOf2ZmlOQcmZ9Txhf4h7XF9JRXJjgwdB9uh8YIeRwhb8a4nxAS6ohFn+
         blIjSLdRGYTKkaCdOBN9rnsD4NpMFV2lMhCvCnEPLKtm1KBTKQCdA9UrZxDM7HYGZmFQ
         uFeA62IP2hpGe1idWy4shU6hgJGF1baLI16JW6uBomSuqA729vZJ1IKeJzdztbJwOpwL
         w+CQ==
X-Gm-Message-State: AKGB3mJUGw92M1V3ignkrhggxT8ywtKkwhcT8mtzijuKCu/iBVapBZ+X
        5Ak211l6uObQPvx73ZnHQi1nwA==
X-Google-Smtp-Source: ACJfBotiDS6JlWGSCGeU+/SOluu6iMz64oDxUGGVxyHM7EHKh56YLS3nFq75Tq2+3xZu7tuEX1Up9A==
X-Received: by 10.80.221.130 with SMTP id w2mr20743421edk.226.1513416895941;
        Sat, 16 Dec 2017 01:34:55 -0800 (PST)
Received: from localhost ([193.138.219.250])
        by smtp.gmail.com with ESMTPSA id y1sm7113623edl.39.2017.12.16.01.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Dec 2017 01:34:55 -0800 (PST)
Date:   Sat, 16 Dec 2017 09:34:40 +0000
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: Re: Re* [PATCH v2 2/2] t: add tests for pull --verify-signatures
Message-ID: <20171216093440.GB5617@darpa.mil>
References: <20171209090530.6747-1-hji@dyntopia.com>
 <20171210065358.8156-1-hji@dyntopia.com>
 <20171210065358.8156-2-hji@dyntopia.com>
 <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com>
 <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv2jpyb6.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 11:48:29AM -0800, Junio C Hamano wrote:
> Here is what I would propose as a follow-up polishing.
> 
> -- >8 --
> Subject: [PATCH 3/2] t5573: clean up after unexpected success of 'pull', too
> 
> The previous step added test_when_finished to tests that run 'git
> pull' with expectation of success, so that the test after them can
> start from a known state even when their 'git pull' invocation
> unexpectedly fails.  However, tests that run 'git pull' expecting
> it not to succeed forgot to protect later tests the same way---if
> they unexpectedly succeed, the test after them would start from an
> unexpected state.
> 
> Reset and checkout the initial commit after all these tests, whether
> they expect their 'git pull' invocations to succeed or fail.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5573-pull-verify-signatures.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks!  t7612-merge-verify-signatures.sh also lacks cleanup for
test_must_fail brokenness.  Would you prefer test_when_finished to be
included in the two patches as a v3?

-- 
hji
