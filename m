Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD55203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbcHSBDY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:03:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57787 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754365AbcHSBCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:02:40 -0400
Received: (qmail 3101 invoked by uid 109); 18 Aug 2016 21:43:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 21:43:34 +0000
Received: (qmail 18054 invoked by uid 111); 18 Aug 2016 21:43:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 17:43:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 17:43:31 -0400
Date:   Thu, 18 Aug 2016 17:43:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160818214331.ie7idv2m3ljgjzyg@sigill.intra.peff.net>
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
 <20160818131553.22580-4-chriscool@tuxfamily.org>
 <xmqqpop56czc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpop56czc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 01:25:43PM -0700, Junio C Hamano wrote:

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 0bcb679..f5b6061 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2517,6 +2517,11 @@ receive.unpackLimit::
> >  	especially on slow filesystems.  If not set, the value of
> >  	`transfer.unpackLimit` is used instead.
> >  
> > +receive.maxsize::
> 
> Shouldn't this be maxInputSize, not just maxSize?  You are limiting
> the size of the input, not the size of the resulting pack, right?

Yeah, that is probably a better name. I don't recall why I picked
maxSize long ago.

> [...]

I agree, too, with all of the other comments you made.

-Peff
