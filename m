Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045311F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdAYGzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 01:55:04 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:50280 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdAYGzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 01:55:03 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id WHT4crwrKgKstWHT4cw1X6; Wed, 25 Jan 2017 06:54:08 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=FtYL4oDj57Bkap42mIQA:9 a=wPNLvfGTeEIA:10 a=nJcEw6yWrPvoIXZ49MH8:22
Message-ID: <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <cornelius.weig@tngtech.com>
Cc:     <j6t@kdbg.org>, <bitte.keine.werbung.einwerfen@googlemail.com>,
        <git@vger.kernel.org>, <gitster@pobox.com>,
        <thomas.braun@virtuell-zuhause.de>, <john@keeping.me.uk>,
        "Stefan Beller" <sbeller@google.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com> <20170125002116.22111-1-sbeller@google.com>
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
Date:   Wed, 25 Jan 2017 06:54:06 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMck1yEJR6tNkk3ND0sSeZ1LyoZTfEUpL4VEd/TuTxjZcQp8YsJgk583JGtxC5h41BfTsfCbCaFi7fkaRo/v42E5QpBgb+BYSG1QjGDXgZGtJlw5Qiwi
 gvI0W66b+mcH8nH+nTDH//uaLgAIkWgBXMn1fcLMSLL4BunEdInnmSSAuf3wmfEb1brT4dpMmy2rB6RCX+nkoALvbNH4krKNe8ynTGFyIkUJc//VE15YISf5
 2ZfuaekeV7prMnMksNssFBZWpE2zWqWknzY4JoKph8U4wdVKQpyMoBhmkWY/2NAN0sB0P5j79t+5oW9gVuYWZ/Khr8n7pwIRjQ4Q9PLnCsm8z2TBXPLJWPK4
 nzNguX0K7tIGbYyETG/kwQNcbuHy509LugKCmPsH5HjofRDLU2BQ+Ahwbv6JomR+pPeeVRNJTer066MDJOpxEkZKrl2gebQghTv819slAIFTBLM5vOY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
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
> Subject: [PATCH] SubmittingPatches: drop temporal reference for PGP 
> signing
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> Documentation/SubmittingPatches | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches 
> b/Documentation/SubmittingPatches
> index 08352deaae..28da4ad2d4 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -216,12 +216,12 @@ that it will be postponed.
> Exception:  If your mailer is mangling patches then someone may ask
> you to re-send them using MIME, that is OK.
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

Wouldn't this also benefit from a forward reference to the section 5 on the 
DOC signining? This would avoid Cornelius's case where he felt that section 
5 no longer applied.

> If you really really really really want to do a PGP signed
> patch, format it as "multipart/signed", not a text/plain message
> -- 
> 2.11.0.495.g04f60290a0.dirty
--
Philip 

