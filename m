Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAFD21F453
	for <e@80x24.org>; Mon,  5 Nov 2018 07:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeKEQ1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:27:45 -0500
Received: from 0x63.nu ([109.74.10.199]:39684 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbeKEQ1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:27:45 -0500
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJZ0n-0008A4-Iw; Mon, 05 Nov 2018 08:09:25 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu> <CAPig+cSfwUJ8thYW+dq1qjT8X_f78DzAzfb_Xd3CMxO=9juz=w@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 0/5] %(trailers) improvements in pretty format
Message-ID: <878t28knld.fsf@0x63.nu>
In-reply-to: <CAPig+cSfwUJ8thYW+dq1qjT8X_f78DzAzfb_Xd3CMxO=9juz=w@mail.gmail.com>
Date:   Mon, 05 Nov 2018 08:09:25 +0100
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:
> If "key" is for including particular trailers, intuition might lead
> people to think that "nokey" is for excluding certain trailers.
> Perhaps a different name for "nokey", such as "valueonly" or
> "stripkey", would be better.

Good point. I guess "valueonly" would be preferred as it says what it
shows, not what it hides.
