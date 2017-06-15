Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7D920401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbdFONMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:12:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:40641 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbdFONMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:12:52 -0400
Received: (qmail 26845 invoked by uid 109); 15 Jun 2017 13:12:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:12:47 +0000
Received: (qmail 23060 invoked by uid 111); 15 Jun 2017 13:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:12:45 -0400
Date:   Thu, 15 Jun 2017 09:12:45 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170615131245.zh5nuipmaadcfpdx@sigill.intra.peff.net>
References: <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
 <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
 <1497255003.1718.1.camel@gmail.com>
 <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
 <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
 <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
 <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
 <1497514760.2394.6.camel@gmail.com>
 <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
 <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 07:43:17AM -0400, Samuel Lijin wrote:

> > Saying just "staged changes" is definitely accurate. I don't know if
> > some users would find that too terse, too. The phrase "not staged for
> > commit" gives more information if you don't know what "staged" means in
> > the Git world.

Oops, I meant to say "too terse, though". But it sounds like you got my
meaning.

> Perhaps there should be a message pointing people at documentation
> explaining the index and staging terminology?

Maybe. I wouldn't want this message to get too verbose. People see it a
lot. There advice.statusHints message is already pretty verbose (though
I turned it off myself years ago).

> Offhand, this is something I was wondering about the other day - has
> there ever been a discussion of what level of proficiency Git expects
> of its users?

There have been lots of discussions, but none that I can think of as
definitive.

I think the general strategy these days is to try to give hints via
advise() for confusing situations, and to make it possible for expert
users to turn those off.

In general, I think using words from "git help glossary" is OK, but when
we can use plainer language without loss of precision, that seems like a
good idea. That's just my personal opinion, though.

-Peff
