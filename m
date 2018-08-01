Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ADF1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeHAVqA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:46:00 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38261 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeHAVqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:46:00 -0400
Received: by mail-yb0-f196.google.com with SMTP id i9-v6so8033523ybo.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYHuy1rRrJoy/8BB1jIG2PeX6fDY/fIpaRCGFot1WS4=;
        b=WZArPHeg5eZRipFafRz0Yz2AE+bGnlTHswi8MDumh2WpTtyFIyxwSJ53ATQzCnaarj
         gjrma7o+S670dAk+dI940iZ+TB35v4AtWjUOPYFIdIVJlKaFIqBrna+w/xEpNVlDzANs
         iRIXkE34UI2c9YRlYtSua2F2JDM0xIBV5AK7f+rj2F5vHqfjTW0XLywRTeE/taqYkQDU
         E9r4Nwmjn9Rfgf4DH24i6dREVViJyJ/6GapWM2fVP5tL6k7nf9Db5VTZ8kV/nV3/YEnN
         e7t82M65KyOOvLMia0j2DzmvPYu2JR5/lXc6VwHK8vApTj320uGX2tZ8e+dmJw4oQDSK
         LIZw==
X-Gm-Message-State: AOUpUlHjGldPPvkIlEnlUgZQRE1MNnTKX+md9Uvh1ba0p1tIdBuL+0uD
        MgB/4trwXTG0QsWp2P7fLY9LTIsWgb9S/Upl23Y=
X-Google-Smtp-Source: AAOMgpeY9tQ5y6UBvEy8H1HwA9cWKn3wH8jQZlgCZr6pKLZV++bsXcgPRu/TJB9zLleBK1RC16rcGMejEBVCWnmpcGk=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr14132832ybf.287.1533153515829;
 Wed, 01 Aug 2018 12:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com> <20180801193413.146994-1-sbeller@google.com>
In-Reply-To: <20180801193413.146994-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Aug 2018 15:58:24 -0400
Message-ID: <CAPig+cSrD4WthFSGH4YETyFtKwZve9qitz8Da-OVVOS4yJps_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] sb/config-write-fix done without robbing Peter
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        peff@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 3:34 PM Stefan Beller <sbeller@google.com> wrote:
> The first patch stands as is unchanged, and the second and third patch
> are different enough that range-diff doesn't want to show a diff.

For future reference, range-diff's --creation-factor tweak may help
here. Depending upon just how heavily changed they are, you may be
able to use it to coerce range-diff into doing what you want.

(Also, interdiff may be a valid alternative.)
