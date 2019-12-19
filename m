Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DBC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 04:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6A124650
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 04:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLSEvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 23:51:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:50002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726867AbfLSEvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 23:51:25 -0500
Received: (qmail 21564 invoked by uid 109); 19 Dec 2019 04:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Dec 2019 04:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1306 invoked by uid 111); 19 Dec 2019 04:56:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2019 23:56:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Dec 2019 23:51:24 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: vcxproj target, was Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191219045124.GB89333@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
 <20191217014321.GF10734@google.com>
 <20191217052812.GB2762303@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.1912171231450.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1912171231450.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 12:35:58PM +0100, Johannes Schindelin wrote:

> On Tue, 17 Dec 2019, Jeff King wrote:
> 
> > (did you know that the vcxproj rule manually builds and git-adds
> > command-list.h? No idea what is going on there),
> 
> The idea of this is that contributors can clone the `vs/master` branch
> from Git for Windows repository, check it out, and open it in Visual
> Studio, then build.
> [...]
> That's what's going on there.

Thanks for satisfying my curiosity. Though I still think I stand by my
statement that the cost/benefit isn't really there to switch how we
handle command-list.h.

-Peff
