Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEBF61F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025AbcHCTO0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:14:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:54046 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758066AbcHCTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:14:25 -0400
Received: (qmail 12810 invoked by uid 102); 3 Aug 2016 19:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:13:38 -0400
Received: (qmail 4398 invoked by uid 107); 3 Aug 2016 19:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:14:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 15:13:34 -0400
Date:	Wed, 3 Aug 2016 15:13:34 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
Message-ID: <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de>
 <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
 <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> *1* I have a slight suspicion that this is cultural, i.e. how
> >> arithmetic is taught in grade schools.  When an apple costs 30 yen
> >> and I have 5 of them, I was taught to multiply 30x5 to arrive at
> >> 150, not 5x30=150, and I am guessing that is because the former
> >> matches the natural order of these two numbers (cost, quantity) in
> >> the language I was taught.
> >
> > You might be right. I was trying to figure out what is "natural" for me
> > in these cases, but after thinking about it for 2 minutes, I'm pretty
> > sure anything resembling "natural" is lost as I try to out-think myself. :)
> 
> Do native English speakers (or more in general Europeans) think of
> the apple example more like "5 apples, 30 cents each", and do 5x30?

I think in my head I rewrite any multiplication like "N of M" as having
"N" as the smaller number. I.e., it is conceptually simpler to me to
count five 30's, then 30 five's (even though I do not implement it in my
head as a sequence of additions, of course; I'd probably do that
particular case as "half of ten 30's").

I have no idea if that's cultural or not, though. I'm pretty sure "half
of ten 30's" was not taught in schools. All I remember of grade school
multiplication is them insisting we write down all of our steps, no
matter how trivial the problem would be to do in our heads. :)

-Peff
