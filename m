Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F06BC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A2223139
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 07:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAMHcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 02:32:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:54470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMHcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 02:32:52 -0500
Received: (qmail 21146 invoked by uid 109); 13 Jan 2021 07:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 07:32:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26798 invoked by uid 111); 13 Jan 2021 07:32:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 02:32:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 02:32:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
Message-ID: <X/6h+8UC6N1MfZ0Q@coredump.intra.peff.net>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
 <X/2JTsoUj3nAQcMi@coredump.intra.peff.net>
 <xmqqa6te3per.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6te3per.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 11:50:52AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Likewise, I'm not sure that one can reliably rot13 an output for
> > test_i18ncmp. It could contain mixed translated and untranslated bits
> > from different messages.
> 
> As long as <rot13>...</rot13> marking can be trusted (and it cannot
> be, but if we declare it is OK to punt, then by definition we can),
> I think the messages can be compared.

Good point. I should have looked at the implementation more carefully
before responding (and I agree that while not foolproof, tagging like
that would work OK in practice).

-Peff
