Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B0D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfBUNK1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:10:27 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:39302 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUNK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:10:27 -0500
Received: by mail-it1-f177.google.com with SMTP id l15so22653975iti.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydT7GfFoKzsAi8PlQ7SrWIzjYidZ3jBEPML2XPVJ5eU=;
        b=UEi5LtDWKwkOMaOcRTzE5+nRWQZZJa7+ie+LFJ8rnmwAmxiLCIkr7UeD6eXbNCOZRF
         j/282UEF1XjrjibFfqRy9SLe8dtPVRsUxj9XI15W3OuYkeQzUlQDYXKDhLA7LKYk8zq7
         3oXRd2VCyW00ALdL6VGFFrpPeHKqi2itQFB7la+/iiQIJ8qNOS6yreznv7151v0JPyQV
         z4IId1i/amrZyt2h4pMHRFgiD8Z2a8r0hJ8o0gCqn2XSh4Zg5ygydVErJLU3jp9ogA4c
         rr69VXC+mtPNIZO09WSAvJ7miIsG/CrEuua17lNsspXkLtFCQL6VRylxdwGeQxN5ytAD
         x5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydT7GfFoKzsAi8PlQ7SrWIzjYidZ3jBEPML2XPVJ5eU=;
        b=nqPDtDxtBKUv5EyWb0TvDWSl2HjHO67k9mYawxbxaeYwukjugwm7MJuutNC18OLsuU
         MDn5WTdSKXcbW+AjM/+dprWGVDpcrKyre1Ds4Lqa+GMlo8cFW4QoPBWCmRQHRD0dzyKX
         9SBvAeEIANmEZMP7JA996LZFiSCwT8nEs20sqPiEkGD3FHjPrtE03qSMI5rvgSenlsZl
         9vmPpR8h/Sy9cWpb39/QA8zsQQ9u/vh+b1MN7i6L7Nh+5hiM/sKTDovNjKLu25OSk7sj
         I8c9YMIEbdBD2rfHoVC/i2Fsu6S5heYkNQv5Yr0yL2FWKg6AqSz2vHFCtJ3wdRrv2N4V
         ZG6Q==
X-Gm-Message-State: AHQUAuZZHQFib5gjKkxWfhUl4w0HZ7Is7VX7r40awmwo13sqRqYhqtkt
        FuZL1yXcrHZa+h43cwnEUEVqhtWToRzJdHws0Oma/A==
X-Google-Smtp-Source: AHgI3IYxcFQS+Dv4mAT5Rf7IFzepGIi0cQGkDaK+B2z1XzAYAeCJ4YCTAxEHymz17cnn4zQVbM3hDYWtDxMv2lqtzIQ=
X-Received: by 2002:a02:568a:: with SMTP id u10mr22118533jad.130.1550754626490;
 Thu, 21 Feb 2019 05:10:26 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
 <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 20:10:00 +0700
Message-ID: <CACsJy8D=-+TqZSf1oyTJs_O+=KAV66OE_As5cTKXxHoXAhzkGw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 2:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> Another mention of /dev/zero appears in t/helper/test-sha1.sh (not
> to be confused with t/helper/test-sha1.c).  This seems to be run
> only with an explicit "make -C t/helper check-sha1" request, so
> perhaps nobody on your platform ran it to get hit by it.  I wonder
> if anybody runs this on any platform, to be honest, though.

I vaguely remember Brian added something to test SHA-512 performance
but I can't find it. Maybe when he adds something (if it's not there
already) we can retire this script, or update it to check sha-512 too.

> Duy Cc'ed as the last person to touch that particular target---yes, I
> know I was guilty of introducing it in b65bc21e ("Makefile: add
> framework to verify and bench sha1 implementations.", 2006-06-24).
-- 
Duy
