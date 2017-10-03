Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9F420365
	for <e@80x24.org>; Tue,  3 Oct 2017 06:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdJCGgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:36:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750720AbdJCGgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:36:08 -0400
Received: (qmail 9557 invoked by uid 109); 3 Oct 2017 06:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 06:36:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5423 invoked by uid 111); 3 Oct 2017 06:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 02:36:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 02:36:06 -0400
Date:   Tue, 3 Oct 2017 02:36:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171003063605.laenmn66swwyac6z@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002065621.ob3icxhlkefpsm4v@sigill.intra.peff.net>
 <xmqqtvzgiw9i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvzgiw9i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 03:24:41PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since that's the only thing I noticed, let's hold off on a reroll for
> > the moment to see if there are any more comments (and I won't be
> > surprised if Junio just picks it up with the tweak, but we'll see).
> >
> > Please do make sure that "make test" runs clean before posting (I
> > usually run it on each commit to catch any "oops, we broke this and then
> > refixed it" in the middle of the series, too).
> 
> OK, I think fixes for both the "flipped" and the "gettext-poison"
> breakages are solved locally in my tree already, so I guess this is
> ready to be merged to 'next'.

Yes, I think so.

Out of curiosity, do you frequently test with GETTEXT_POISON, or did you
just guess at a potential problem after reading the tests?  Proper use
of test_i18ncmp is definitely something we ought to be looking for
during review, but I confess it's something I often miss.

-Peff
