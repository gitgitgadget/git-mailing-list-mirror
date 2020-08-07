Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC91EC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1032074D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHGTUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:20:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGTUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:20:03 -0400
Received: (qmail 1515 invoked by uid 109); 7 Aug 2020 19:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 19:20:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16763 invoked by uid 111); 7 Aug 2020 19:20:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 15:20:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 15:20:01 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200807192001.GA1308960@coredump.intra.peff.net>
References: <20200804212201.GA2020725@coredump.intra.peff.net>
 <xmqq3652rs84.fsf@gitster.c.googlers.com>
 <878seuxdz8.fsf@osv.gnss.ru>
 <20200804221440.GC2022650@coredump.intra.peff.net>
 <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
 <20200807082643.GA34012@coredump.intra.peff.net>
 <xmqqlfiqgxn7.fsf@gitster.c.googlers.com>
 <87364ymji7.fsf@osv.gnss.ru>
 <xmqqh7tegu0m.fsf@gitster.c.googlers.com>
 <87tuxel17m.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuxel17m.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 10:12:29PM +0300, Sergey Organov wrote:

> I thought it's just a -c, -cc, and -m in better wording. No any
> matrix:
> 
> -c  = --diff-merges=combined
> -cc = --diff-merges=dense
> -m  = --diff-merges=split
> 
> Just separate mutually exclusive options assembled into one multi-value
> option, so it's explicit they are mutually exclusive. I don't see any
> matrix here.

FWIW, those names make sense to me. Coupled with "none" or "off" for
disabling all of them.

-Peff
