Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840811F404
	for <e@80x24.org>; Thu,  8 Mar 2018 13:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966222AbeCHNMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 08:12:51 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35851 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935865AbeCHNMc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 08:12:32 -0500
Received: by mail-oi0-f41.google.com with SMTP id u73so4289614oie.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrQhRwCqwantg1ke6CFEpplG6tI/mZyxy5tqEEzSiHM=;
        b=rIFUy74yWiOKko1RolMtl1op9YoOTj3fR8vZn2NIZG+ndJrs+mQlhJ3k9eIdWACvCF
         PYUavzbR41HJWZls8Ze057ZNwJEHOZRSGrT017swppgM2WUUmQFPDtwt4+FLRNrUu5za
         V/lff8mwLPAaaQLb3YqGMOI2v6AVzBkevTk3LHNrLt9tWGu8KJiLWpa6kxZlIvTda55J
         cRkTkLHyoksc8sw4MjQtQqYfDA8iEHh+2m7+U+aoALrM+4EbuTKfTcFBLpOSufLsvlUh
         YTlGHf48UFj8YUkdGhQfayjX+gJIrW9haKu0mqScVK3woeVFTwQmCkLAVNGUFy8Nv0uw
         vllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrQhRwCqwantg1ke6CFEpplG6tI/mZyxy5tqEEzSiHM=;
        b=qYDJxyUFU5sWRHvjqGuGsqAfeRUxZilAVJaPzYETRjFy8COL5jCzuFWL0yJcNKbR/7
         kCWen07vsY9wPUAy+GS7893fORyWc2SAPQIcsDlTh59b3k7DG/w9Asyj91HyQgZwUkLD
         ovhrHDNmhorTF1qsvvw0iiAJy3q5iq5AZQmdYWxJGFwdkors16v9hiKQy8RWfNHM3N1E
         NmrkzfOI9aHqkqKKc46EYcb4RLuqpv2YlEvy6l7BmVERcoM8jNUClqUF/0u5TNbnCBTY
         thThFTHkPA5j9M9xhovJZffLC8fh30+OpXOJHCh/coK+nXmkPnqUARUrE0zq/4cUYcGZ
         FMJQ==
X-Gm-Message-State: AElRT7E2zO7DyDmFlnyUGwOQX9fuB9XHJnOw+veUR3xjkkt0c/v34rIi
        Y5zS0sNxZaurKBoCqKLVhCU1On44BwGiQfa7gWuT9g==
X-Google-Smtp-Source: AG47ELseSLXqsHElTwnaMocqapYwou0Hdq2q0kB12rFR9shtGr8G+ZDornlvhtmzckGqah34BbQ0o0Zoqqpwn1eYxhY=
X-Received: by 10.202.102.83 with SMTP id a80mr17280156oic.35.1520514751666;
 Thu, 08 Mar 2018 05:12:31 -0800 (PST)
MIME-Version: 1.0
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sguorb5.fsf@evledraar.gmail.com>
In-Reply-To: <871sguorb5.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Thu, 08 Mar 2018 13:12:20 +0000
Message-ID: <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It would be great to have this rebooted now that my perl cleanup efforts
> have un-blocked this. Will be happy to help review & test the next
> iteration.

Yes, I was just thinking the same thing. I wanted to make sure the Perl
changes had landed, and I'm pleased to see that they have. I should have
time in the next few days to rebase and put up a new version of the patch
series. I'll keep you in the loop, and thanks for pinging!
