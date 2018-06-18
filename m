Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B821C1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 04:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeFREU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 00:20:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751579AbeFREU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 00:20:56 -0400
Received: (qmail 4048 invoked by uid 109); 18 Jun 2018 04:20:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Jun 2018 04:20:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2723 invoked by uid 111); 18 Jun 2018 04:21:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Jun 2018 00:21:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jun 2018 00:20:54 -0400
Date:   Mon, 18 Jun 2018 00:20:54 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, simon@ruderich.org,
        Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Subject: Re: Doc/SubmittingPatches: re-phrashing a sentence about alternate
 solutions (was Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv")
Message-ID: <20180618042054.GB31125@sigill.intra.peff.net>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
 <20180615065805.GA15146@ruderich.org>
 <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
 <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
 <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
 <1529259933.7225.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1529259933.7225.2.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 11:55:33PM +0530, Kaartic Sivaraam wrote:

> On Sun, 2018-06-17 at 14:00 -0400, Eric Sunshine wrote:
> > Whether or not to talk about alternate solutions in the commit message
> > is a judgment call. Same for deciding what belongs in the commit
> > message proper and what belongs in the "commentary" section of a
> > patch. A patch author should strive to convey the problem succinctly
> > in the commit message, to not overload the reader with unnecessary (or
> > confusing) information, while, at the same time, not be sparing with
> > information which is genuinely needed to understand the problem and
> > solution.
> > 
> > Often, this can be done without talking about alternatives; often even
> > without spelling out the solution in detail or at all since the
> > solution may be "obvious", given a well-written problem description.
> > Complex cases, or cases in which multiple solutions may be or seem
> > valid, on the other hand, might warrant talking about those alternate
> > solutions, so we probably don't want to drop that bullet point.
> 
> Well explained, thanks. (Thinking out loud, it might be even nice to
> including the above paragraphs into Documentation/SubmittingPatches as
> I find it to be more "humane" than the terse bullets. But I refrained
> from doing so as the document is already a bit too-long ;-)

Yes, the first paragraph especially. The _most_ important thing is
writing well with consideration for your readers. All the other rules
are really guidelines to help you remember how to do that. When in
doubt follow the guidelines, but it's OK to break them if it serves the
ultimate purpose.

All IMHO, of course. :)

-Peff
