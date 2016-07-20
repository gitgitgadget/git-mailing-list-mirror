Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE221F744
	for <e@80x24.org>; Wed, 20 Jul 2016 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbcGTSFq (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 14:05:46 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35246 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbcGTSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 14:05:44 -0400
Received: by mail-yw0-f180.google.com with SMTP id j12so45477778ywb.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 11:05:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/1iQ3WhiK9VBuw/WVCSKTxvC0vnqrdBTyi86qXRaNgk=;
        b=kcK8ndGt1p51rgJ8jDMfFcrYkXAJT2wYvULipuHVgNDzYoJolRY5ISnLWGFxB/n+K2
         wfE9k1EkQEiwuT1ZP2UGRQT1cE9oaa0TLPO2o0b/pmV5NWB+1xMJszudgJQwG6Nh7FnO
         y1+Hz2BiH0f5mNwsndTXeVWF1suBDFQoG/PCf9MThW+SM/Yi0YG19QI1sq+ynEJgFJ5y
         UZg2X/pgEWt7BdI9A3ywXxCRtNBtnDW5v/fW4CnY40g+uhxV+5A047VnIr6pacx3tPjX
         0u3G7IbjgvaREXTQME0eerHHPCpI3hFR+TBy6N0clwNzbC4flB/MTOTn8WxnfTFoO9o/
         eaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/1iQ3WhiK9VBuw/WVCSKTxvC0vnqrdBTyi86qXRaNgk=;
        b=iCpClska2DJyddkUUjG3Yf4wFTb2vev2tW6vSoZVLDp2pxa00CtGhivs30F/XpkoyH
         C3l0+nKRWHnWAYRZlNqqdrWjfpFnKW4OIF2Dk/xL/wXQLOFveZ6EmB8ulAjXFbB9fCxP
         GGdZ63JRhaZU+y70MaPyaf80wiQKdgo4COOINsI1pFw+QrWyLIoYKpZgrXZr23nFAWZ2
         VJn+BJDb7J59o0dFWFDpQ8m/w67f3/AIgcV7Jvqzmgw9kNW0yaQWtrka7TAhAEILA3kk
         8dTOqyWqJ+rjsgrxR0pXxds4jah+l44ncrtqK12eJXdBYPt+JzOGPYwU/fVoyERqZiDJ
         GH/g==
X-Gm-Message-State: ALyK8tLUg9oWxbTq4kidED6WSHC3vp/42nxY9h/mU6TRo1KnjP8RAWNJl+3Ro5E4RSPBsqDIQMDZ32aS9ZitSw==
X-Received: by 10.129.106.197 with SMTP id f188mr13997089ywc.38.1469037944038;
 Wed, 20 Jul 2016 11:05:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 20 Jul 2016 11:05:24 -0700 (PDT)
In-Reply-To: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
References: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 20 Jul 2016 11:05:24 -0700
X-Google-Sender-Auth: 7THX2fe2R5kJZAct6PMZQVItk3A
Message-ID: <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com>
Subject: Re: [ANNOUNCE] GitRev News edition 17
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 5:58 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi everyone,
>
> I'm happy announce that the 17th edition of Git Rev News is now published:
>
> https://git.github.io/rev_news/2016/07/20/edition-17/

Micronit. 2.9.1 (or 2.9.2) would not be a "major release". 2.9.0 was,
and x.y.z (z > 0) are "maintenance releases".
