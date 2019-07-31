Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4FC1F462
	for <e@80x24.org>; Wed, 31 Jul 2019 01:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGaBG1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 21:06:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:56206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727136AbfGaBG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 21:06:26 -0400
Received: (qmail 10060 invoked by uid 109); 31 Jul 2019 01:06:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 01:06:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12410 invoked by uid 111); 31 Jul 2019 01:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2019 21:08:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jul 2019 21:06:25 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Vagin <avagin@openvz.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dmitry Safonov <dima@arista.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
Message-ID: <20190731010625.GB9610@sigill.intra.peff.net>
References: <20190730203327.30958-1-dima@arista.com>
 <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
 <CANaxB-yygbxt=-sP+cyhR9WhcyEck+Wy=453huwfVNC9+So0BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANaxB-yygbxt=-sP+cyhR9WhcyEck+Wy=453huwfVNC9+So0BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 03:56:43PM -0700, Andrey Vagin wrote:

> On Tue, Jul 30, 2019 at 3:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Dmitry Safonov <dima@arista.com> writes:
> >
> > > I was almost certain that git won't let me send the same patch twice,
> >
> > Why?  And more importantly, does it matter to readers of this
> > message what you thought?
> 
> Sounds rude. What matter to readers except author's thoughts? I guess you want
> to say that the comment should be in more neutral technical form without
> personal pronouns.

IMHO it's OK to use personal pronouns, but it's good to stick to the
facts. It's easy to go off on a tangent about what led you to the patch
that ends up making it harder for somebody reading the patch later to
get to the point.

In this case, you did the leg-work to advance the story from "I'm
confused about it should do..." to "it definitely does X now, and it
would be better if it did Y". That's probably the best place for a later
reader of the commit message to pick it up.

-Peff

PS I agree that what Junio wrote does sound a bit rude, but I don't
   think that was his intent. It's easy to accidentally be a little too
   curt during reviews (and I'm sure I've done it myself many times).
   Hopefully we can all take this as a reminder to be careful. :)
