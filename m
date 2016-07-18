Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854482018F
	for <e@80x24.org>; Mon, 18 Jul 2016 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcGRS4k (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:56:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:46526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751777AbcGRS4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:56:39 -0400
Received: (qmail 27294 invoked by uid 102); 18 Jul 2016 18:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 14:56:38 -0400
Received: (qmail 6074 invoked by uid 107); 18 Jul 2016 18:57:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 14:57:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2016 12:56:35 -0600
Date:	Mon, 18 Jul 2016 12:56:35 -0600
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718185634.GA24726@sigill.intra.peff.net>
References: <20160718064431.GA10819@starla>
 <20160718130405.GA19751@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607181536540.3472@virtualbox>
 <xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 11:20:19AM -0700, Junio C Hamano wrote:

> Stepping back a bit, why do we even care if "unzip -a" works on
> "../$zipfile" and converts things correctly in that check_zip() test
> in t5003 in the first place?  It looks more like a test on "unzip"
> than making sure we correctly generate a zip archive to me...

I think it is testing that we generated an archive with the correct "I
am text" flags so that an unzip implementation can do the
auto-conversion.

-Peff
