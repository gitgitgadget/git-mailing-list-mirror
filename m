Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D793201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdBUBIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:08:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:59001 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdBUBIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:08:39 -0500
Received: (qmail 20569 invoked by uid 109); 21 Feb 2017 01:08:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 01:08:38 +0000
Received: (qmail 1701 invoked by uid 111); 21 Feb 2017 01:08:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 20:08:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 20:08:36 -0500
Date:   Mon, 20 Feb 2017 20:08:36 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170221010836.nuv6uvyzatql2yyu@sigill.intra.peff.net>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
 <20170220001031.559931-4-sandals@crustytoothpaste.net>
 <20170220080902.vkexezd5solnhrhb@sigill.intra.peff.net>
 <20170221002519.55d4mlljia3mposi@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170221002519.55d4mlljia3mposi@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 12:25:19AM +0000, brian m. carlson wrote:

> On Mon, Feb 20, 2017 at 03:09:02AM -0500, Jeff King wrote:
> > It's a little disturbing that we do not seem to have even a basic test
> > of:
> > 
> >   git rev-list --parents HEAD | git diff-tree --stdin
> > 
> > which would exercise this code.
> 
> I'm unsure, so I'll add a test.  The only way to know if it works is to
> test it.

Not to spoil the ending, but I did test and it does not work. :)

-Peff
