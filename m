Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DB4201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965006AbdBQXyW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:54:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:57702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964929AbdBQXyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:54:21 -0500
Received: (qmail 349 invoked by uid 109); 17 Feb 2017 23:54:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:54:16 +0000
Received: (qmail 9120 invoked by uid 111); 17 Feb 2017 23:54:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:54:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:54:13 -0500
Date:   Fri, 17 Feb 2017 18:54:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217235413.zuwqabfo7jtw3lz7@sigill.intra.peff.net>
References: <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
 <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
 <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
 <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
 <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
 <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net>
 <xmqqzihkphkc.fsf@gitster.mtv.corp.google.com>
 <20170217233952.56h2z3l76orn4zht@sigill.intra.peff.net>
 <xmqqr32wnznf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr32wnznf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 03:52:36PM -0800, Junio C Hamano wrote:

> > So I think that "easy" thing falls far short of a solution, but it's at
> > least easy. I could take it or leave it at this point.
> 
> Well, I already said that earlier in this thread, and ended up
> queuing your patch on 'pu' ;-).

We're slowly converging on consensus in our apathy. ;)

-Peff
