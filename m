Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32BA20987
	for <e@80x24.org>; Tue,  4 Oct 2016 12:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbcJDMSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:18:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:51899 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753742AbcJDMST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:18:19 -0400
Received: (qmail 15843 invoked by uid 109); 4 Oct 2016 12:18:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 12:18:19 +0000
Received: (qmail 3785 invoked by uid 111); 4 Oct 2016 12:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 08:18:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 08:18:16 -0400
Date:   Tue, 4 Oct 2016 08:18:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
Message-ID: <20161004121816.yjvxymv46cgmnf5p@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com>
 <20161001001937.10884-4-gitster@pobox.com>
 <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
 <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
 <20161003224028.ksvwaplxe7a3vtwv@sigill.intra.peff.net>
 <xmqqoa313v0j.fsf@gitster.mtv.corp.google.com>
 <20161003234728.s5sadekukxoppcmw@sigill.intra.peff.net>
 <xmqqbmz051yp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmz051yp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 06:37:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> OK, as Linus's "count at the point of use" is already in 'next',
> >> could you make it incremental with a log message?
> >
> > Sure. I wasn't sure if you actually liked my direction or not, so I was
> > mostly just showing off what the completed one would look like.
> 
> To be quite honest, I am not just unsure if I liked your direction;
> rather I am not sure if I actually understood what you perceived as
> a difference that matters between the two approaches.  I wanted to
> hear you explain the difference in terms of "Linus's does this, but
> it is bad in X and Y way, so let's avoid it and do it like Z
> instead".  One effective way to extract that out of you was to force
> you to justify the "incremental" update.
> 
> And it seems that I succeeded ;-).
> 
> I am still not sure if I 100% agree with your first paragraph, but
> at least now I think I see where you are coming from.

For the record, I am OK with Linus's patch as-is. It's mostly "that's
not how I would have done it, and the flow seems confusing to me". But
that's subjective; I don't think there are any functional flaws in it.

> You probably will hear from Ramsay about extern-ness of msb().

Heh. I seem to have a real problem with that lately.

-Peff
