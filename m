Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334EE1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300AbcHCUFE (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:05:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54101 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758083AbcHCUFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:05:02 -0400
Received: (qmail 15048 invoked by uid 102); 3 Aug 2016 20:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 16:05:02 -0400
Received: (qmail 5025 invoked by uid 107); 3 Aug 2016 20:05:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 16:05:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 16:04:59 -0400
Date:	Wed, 3 Aug 2016 16:04:59 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
Message-ID: <20160803200459.hosgwqbgxnfc2jlz@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de>
 <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
 <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
 <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
 <CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com>
 <20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net>
 <CAGZ79kYonA8pYfW68SC6YaZ84Gz2Eo_qXDxQJ14_62abcd8-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYonA8pYfW68SC6YaZ84Gz2Eo_qXDxQJ14_62abcd8-Og@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 12:59:34PM -0700, Stefan Beller wrote:

> I think I'd find calloc intuitive as a typical textbook question, "I
> want to have space for "foos", which each cost 5 memory, go figure out
> how much I need and hand it back to me".

I think it is more a language question than a math one, though. Is it "5
instances, costing 30 each" or "30-cost instances, 5 times". They are
the same semantically (there is no "30 instances of a 5-cost thing",
which does not map to the problem space), but just with a different
order.

-Peff
