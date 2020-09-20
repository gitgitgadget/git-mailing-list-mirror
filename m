Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4727FC43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026B0208B8
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgITFfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 01:35:03 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46990 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgITFfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 01:35:03 -0400
Received: by mail-ej1-f68.google.com with SMTP id z23so13283682ejr.13
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 22:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4UKcXBIbB0fWWVm0c7S56u4i7PlgVGmR2C0anNzqrs=;
        b=jvwtogliRKyT4aczPoyRRudW3FJBHO2XCD5BtbBI563ABSQvnARdoUY42u40qHy77j
         oGm6FwKVlOSHRIpd925+5pKs3M8mLH33ywop9ks/OuPQ1OhvTMOu27eK2WBqoK9zi7nb
         1JAk/mIUh1Q8PFHIdGMjL5CNmBtmVKMklC5vBy9rTxcqpLF8g2+bp37DMN6so2nb3PK+
         NI5sgpxW5HZT4/NOfXqJaBrg4R3gC9fHNCICnGgMA918KZWKTrIk4qcS2Pt7+rJjlpY0
         2gOREDnZAruiMJROBxTpzr8gwewjM/nWdAT6YfF10TR3+eZUd5dk5kTWo2vmpKB/QynQ
         eETg==
X-Gm-Message-State: AOAM530n+v5xUgOBQKlkxvj1Z9DnwHhEowEcTCAM96H91gWwx7BBHM0C
        xMCexwsy8/zlz3EYL+mIncWpvSu0nrYEwTgMP2jm20N0hZ8=
X-Google-Smtp-Source: ABdhPJwhGL4g2/mUznRt8mtuCWsrPuu8sgsgXrl0Jwy1eDIpmrk+/20A+J2tvq2xsfq/FcAiRem/2sTAwu6stJwGtXo=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr43342513ejq.138.1600580101865;
 Sat, 19 Sep 2020 22:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200919085441.7621-1-luke@diamand.org> <20200919085441.7621-2-luke@diamand.org>
 <20200919085441.7621-3-luke@diamand.org>
In-Reply-To: <20200919085441.7621-3-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Sep 2020 01:34:51 -0400
Message-ID: <CAPig+cQ2ccTC+d85A7HCHWeUp1aPgj-LBvbcO_Bv-nVkvTm=RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: use HEAD~$n to find parent commit for unshelve
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 19, 2020 at 4:54 AM Luke Diamand <luke@diamand.org> wrote:
> git-p4: use HEAD~$n to find parent commit for unshelve

This commit message repeats what the patch itself says but doesn't
explain why this change is being made or what problem is being solved.
Some explanation to help readers understand the problem would be
welcome.

> Found-by: Liu Xuhui (Jackson) <Xuhui.Liu@amd.com>

I believe this would generally be stated as Reported-by:.

> Signed-off-by: Luke Diamand <luke@diamand.org>
