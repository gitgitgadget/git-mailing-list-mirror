Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521D61F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 19:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190AbcHCTuj (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:50:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:54075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755340AbcHCTuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:50:37 -0400
Received: (qmail 14344 invoked by uid 102); 3 Aug 2016 19:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:49:17 -0400
Received: (qmail 4724 invoked by uid 107); 3 Aug 2016 19:49:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 15:49:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 15:49:13 -0400
Date:	Wed, 3 Aug 2016 15:49:13 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
Message-ID: <20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de>
 <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
 <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
 <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
 <CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 12:41:30PM -0700, Junio C Hamano wrote:

> On Wed, Aug 3, 2016 at 12:13 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:
> >
> > I think in my head I rewrite any multiplication like "N of M" as having
> > "N" as the smaller number. I.e., it is conceptually simpler to me to
> > count five 30's, then 30 five's (even though I do not implement it in my
> > head as a sequence of additions, of course; I'd probably do that
> > particular case as "half of ten 30's").
> >
> > I have no idea if that's cultural or not, though.
> 
> Now, when you say "count five 30's", which one do you have
> in mind? 5x30, or 30x5?
> 
> If you meant the former, I think that _is_ cultural. I am pretty
> sure that I was taught in school(s) to read 5x30 as adding 5
> thirty times.

I think I would say "30x5" in that case. But I'm not sure where that
comes from, and I'm not even 100% sure that I would say that (after
thinking about it, it's hard for me to figure out what I would have done
if I _hadn't_ just thought about it).

-Peff
