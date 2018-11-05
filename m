Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802131F453
	for <e@80x24.org>; Mon,  5 Nov 2018 08:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKERvV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 12:51:21 -0500
Received: from 0x63.nu ([109.74.10.199]:39884 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKERvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 12:51:21 -0500
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJaJT-0008OS-Lj; Mon, 05 Nov 2018 09:32:47 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu> <20181104152232.20671-5-anders@0x63.nu> <xmqqtvkwjn1k.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 4/5] pretty: extract fundamental placeholders to separate function
In-reply-to: <xmqqtvkwjn1k.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 05 Nov 2018 09:32:47 +0100
Message-ID: <8736sflya8.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:
> I do not think "fundamental" is the best name for this, but I agree
> that it would be useful to split the helpers into one that is
> "constant across commits" and the other one that is "per commit".

Any suggestions for a better name?

standalone? simple? invariant? free?

