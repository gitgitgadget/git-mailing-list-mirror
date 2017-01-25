Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F0F1F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbdAYAnp (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:43:45 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:31167 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdAYAnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:43:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 6CC0F1E186C;
        Wed, 25 Jan 2017 01:43:40 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lOL2fyd-jzpW; Wed, 25 Jan 2017 01:43:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 042FB1E2CF2;
        Wed, 25 Jan 2017 01:43:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kh9t0aQGWMbv; Wed, 25 Jan 2017 01:43:39 +0100 (CET)
Received: from [192.168.178.31] (aftr-185-17-206-134.dynamic.mnet-online.de [185.17.206.134])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 77AD41E186C;
        Wed, 25 Jan 2017 01:43:39 +0100 (CET)
Subject: Re:
To:     Stefan Beller <sbeller@google.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com>
Cc:     j6t@kdbg.org, bitte.keine.werbung.einwerfen@googlemail.com,
        git@vger.kernel.org, gitster@pobox.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <ec2a198e-edf5-68a1-523c-12a9d1333c58@tngtech.com>
Date:   Wed, 25 Jan 2017 01:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170125002116.22111-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25/2017 01:21 AM, Stefan Beller wrote:
>>
>>> Do not PGP sign your patch, at least *for now*. (...)
>>
> 
> And maybe these 2 small words are the bug in the documentation?
> Shall we drop the "at least for now" part, like so:
> 
> ---8<---
> From 2c4fe0e67451892186ff6257b20c53e088c9ec67 Mon Sep 17 00:00:00 2001
> From: Stefan Beller <sbeller@google.com>
> Date: Tue, 24 Jan 2017 16:19:13 -0800
> Subject: [PATCH] SubmittingPatches: drop temporal reference for PGP signing
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/SubmittingPatches | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 08352deaae..28da4ad2d4 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -216,12 +216,12 @@ that it will be postponed.
>  Exception:  If your mailer is mangling patches then someone may ask
>  you to re-send them using MIME, that is OK.
>  
> -Do not PGP sign your patch, at least for now.  Most likely, your
> -maintainer or other people on the list would not have your PGP
> -key and would not bother obtaining it anyway.  Your patch is not
> -judged by who you are; a good patch from an unknown origin has a
> -far better chance of being accepted than a patch from a known,
> -respected origin that is done poorly or does incorrect things.
> +Do not PGP sign your patch. Most likely, your maintainer or other
> +people on the list would not have your PGP key and would not bother
> +obtaining it anyway. Your patch is not judged by who you are; a good
> +patch from an unknown origin has a far better chance of being accepted
> +than a patch from a known, respected origin that is done poorly or
> +does incorrect things.
>  
>  If you really really really really want to do a PGP signed
>  patch, format it as "multipart/signed", not a text/plain message
> 

It definitely is an improvement. Though it would still leave me puzzled
when finding a section about signing just below.

Is changing heading (5) too big a change? Like so:

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 08352de..71898dc 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -246,7 +246,7 @@ patch.
      *2* The mailing list: git@vger.kernel.org
 
 
-(5) Sign your work
+(5) Certify your work by signing off.
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
