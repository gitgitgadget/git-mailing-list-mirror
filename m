Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E861FAF4
	for <e@80x24.org>; Wed, 15 Feb 2017 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdBOA3F (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:29:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:55471 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdBOA3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:29:05 -0500
Received: (qmail 1514 invoked by uid 109); 15 Feb 2017 00:29:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 00:29:04 +0000
Received: (qmail 9373 invoked by uid 111); 15 Feb 2017 00:29:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 19:29:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 19:29:02 -0500
Date:   Tue, 14 Feb 2017 19:29:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
Message-ID: <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
 <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
 <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
 <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 02:11:06PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thanks.  We'd need to update the tests that expects the old style
> > output, though.
> 
> The updates to the expectation look like this (already squashed).
> The --source decorations in 4202 are also shown at the end, which
> probably is in line with the way --show-decorations adds them at the
> end of the line, but was somewhat surprising from reading only the
> log message.

Hrm, that does surprise me. I'm not sure if that's desirable or not. I
do think some of the "nobody could possibly be parsing these" arguments
about decorations do not apply to --source (and also, they're harder for
humans to pick out from the end of the line as they lack punctuation and
color).

-Peff
