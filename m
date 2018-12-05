Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA297211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeLECsi (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 21:48:38 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33829 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLECsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 21:48:38 -0500
Received: by mail-ed1-f50.google.com with SMTP id b3so15734724ede.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 18:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1YfNuRj6y1LY4rc/BuJN57qoh1tY2TbB2hLP5ZELSg=;
        b=X2LWV/pZonJzOxZAE2R+L3zkNGW253aiFQfrJe8LwdzNwdr2WgRZldzqyBFoStg/6/
         PpHK6yaZY7fRhsAYLPueDeqhHjlm6pHMHU0W4l/rXh/Evf6pTUlg9opkYKgWcd1B0hVj
         Ojs4odxl/VVC16T2X1ZOUttHxAfkHGLNzD7jRa94EvC8E2lCF65lkgZwLhnaeooxTSyf
         2jwCmnwG0PWlLQnnLOR2CQQoIZfr08PIIc7h+QlzNiByqqwJBk6kV+a21lgxmTFTKoOI
         1PIeCuiync1CP4I9jNdQjWi/OO0f7bzHakdG/DRBU9I4s4xLOrZBPUJnPhCzl8+8wxQR
         mTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1YfNuRj6y1LY4rc/BuJN57qoh1tY2TbB2hLP5ZELSg=;
        b=hR9veB+buk0PB+QrzwtKFzkAcCw9dOJqTzVFVeIbzsqCxVvcmherB0OZ9oDrPl96lS
         KPUQTSiysJ3s42DEXBd92sYKQoIGK1Rwl8K7GtElBtBKm48GxcXhznga5xMbYBhjO08O
         a44Hu4jYt9XnxEBZpL0sTTm9bNznwSGY362tzGqsJEeoQQsgafi6TQ7B3yJLv//9p4Vf
         6OBZORbcQtZ2J3DAuJlWFzSlB13/W9nx9GBnLBjhMIN5/w3zuwNTHTz5xn7SM8mrnsLZ
         pvl64UyZKuhpt3/mbROYvIPqIHQBzPCiXxC8EDPI0sIP2MVl+uYjCUjRFFaf8rtA6T0D
         oHcg==
X-Gm-Message-State: AA+aEWZJM+4QdyeQ8JoGEOOYuFN6A1VPsB4fB6rGeJjrpKLOu4v05h4p
        sA9XACDpJTcIi2A6SeBprcISdolhJeI896CyvAdsFA3blWA=
X-Google-Smtp-Source: AFSGD/UmcvSYzmHhT3NcO8Ty3c8L/v4qupiKp5oLdnso7qBIPyEwmTZTzoX5p9/LKanzTCS1TBGdW+8lBt1O54CPDww=
X-Received: by 2002:aa7:df07:: with SMTP id c7mr19868499edy.85.1543978116469;
 Tue, 04 Dec 2018 18:48:36 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com> <87in09ytd2.fsf@evledraar.gmail.com>
In-Reply-To: <87in09ytd2.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Dec 2018 18:48:22 -0800
Message-ID: <CAGZ79kZPXoST3Jfmd06ALV3BGX+yd5rYKUhVkWpHmj94Kit-wQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        git-packagers@googlegroups.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-cc linux list


> Perhaps we should note this more prominently, and since Brandon isn't at
> Google anymore can some of you working there edit this post? It's the
> first Google result for "git protocol v2", so it's going to be quite
> confusing for people if after 2.20 the instructions in it no longer
> work.

Thanks for pointing this out, we missed the implications when that patch was
discussed. Looking into it.
>
> 1. https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
