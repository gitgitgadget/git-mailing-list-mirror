Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0881F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeKLWxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:53:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:35454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729201AbeKLWxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:53:19 -0500
Received: (qmail 25146 invoked by uid 109); 12 Nov 2018 13:00:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 13:00:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10398 invoked by uid 111); 12 Nov 2018 12:59:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:59:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 08:00:07 -0500
Date:   Mon, 12 Nov 2018 08:00:07 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/10] fast export and import fixes and features
Message-ID: <20181112130007.GJ3956@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111072716.GK30850@sigill.intra.peff.net>
 <CABPp-BGzqpxF_+ubp2cft9dQ-03pgcCxJEP13VOUv5WADHDjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGzqpxF_+ubp2cft9dQ-03pgcCxJEP13VOUv5WADHDjnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 12:44:47AM -0800, Elijah Newren wrote:

> > > These patches were driven by the needs of git-repo-filter[1], but most
> > > if not all of them should be independently useful.
> >
> > I left lots of comments. Some of the earlier ones may just be showing my
> > confusion about fast-export works (some of which was cleared up by your
> > later patches). But I like the overall direction for sure.
> 
> Thanks for taking the time to read over the series and providing lots
> of feedback!  And, whoops, looks like it's gotten kinda late, so I'll
> check any further feedback on Monday.

Thank you for your patience with my sometimes-confused responses. :)

Overall it makes more sense to me now (and everything seems like a good
direction), with the exception that I'm still a bit confused about patch
10.

-Peff
