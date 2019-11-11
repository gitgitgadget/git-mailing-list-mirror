Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBED01F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKJVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:21:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726768AbfKKJVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:21:45 -0500
Received: (qmail 18465 invoked by uid 109); 11 Nov 2019 09:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 09:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4432 invoked by uid 111); 11 Nov 2019 09:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 04:25:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 04:21:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] getting rid of sha1_to_hex()
Message-ID: <20191111092144.GA12607@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <xmqqmud2hj9l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmud2hj9l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 06:09:10PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I happened to be looking at the oid_to_hex() family of functions today,
> > and noticed that we can drop some of the sha1-specific ones.
> >
> > It's a minor cleanup in terms of text, but it feels like a nice
> > milestone. :)
> >
> >   [1/2]: hex: drop sha1_to_hex_r()
> >   [2/2]: hex: drop sha1_to_hex()
> 
> Nice indeed.
> 
> Thanks, Brian! ;-)  oh, and Peff, of courese ;-)

I actually worried that I might be stealing brian's thunder. But AFAICT
this cleanup has been waiting for almost a year, so I figured it was
fair game. :)

-Peff
