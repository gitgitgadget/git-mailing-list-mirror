Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD48211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 15:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfANPkX (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 10:40:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:35834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726595AbfANPkW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 10:40:22 -0500
Received: (qmail 3315 invoked by uid 109); 14 Jan 2019 15:40:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Jan 2019 15:40:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26474 invoked by uid 111); 14 Jan 2019 15:40:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 14 Jan 2019 10:40:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2019 10:40:19 -0500
Date:   Mon, 14 Jan 2019 10:40:19 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] match-trees: use hashcpy to splice trees
Message-ID: <20190114154019.GA4202@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-4-sandals@crustytoothpaste.net>
 <20190110064520.GC20497@sigill.intra.peff.net>
 <20190110235551.GM423984@genre.crustytoothpaste.net>
 <20190111145106.GB16754@sigill.intra.peff.net>
 <20190111145446.GA31518@sigill.intra.peff.net>
 <20190114013017.GP423984@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114013017.GP423984@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 01:30:17AM +0000, brian m. carlson wrote:

> > > So the "most correct" thing is probably something like this:
> > 
> > Of course, it would be nice if what I sent compiled. ;)
> > 
> > rewrite_here does double duty: it's the pointer in the tree that we need
> > to rewrite, and it's also the oid we pass down recursively. So we have
> > to handle both cases, like so:
> 
> Since I took most of the patch you wrote, may I apply your sign-off to
> the resulting patch I send out?

Yes, definitely.

-Peff
