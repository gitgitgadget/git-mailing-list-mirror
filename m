Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DED2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbcFXRWB (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 13:22:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:59811 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbcFXRWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 13:22:00 -0400
Received: (qmail 25288 invoked by uid 102); 24 Jun 2016 17:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 13:22:00 -0400
Received: (qmail 20954 invoked by uid 107); 24 Jun 2016 17:22:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 13:22:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 13:21:58 -0400
Date:	Fri, 24 Jun 2016 13:21:58 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: Short-term plans for the post 2.9 cycle
Message-ID: <20160624172157.GB3273@sigill.intra.peff.net>
References: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
 <20160624154800.GB2448@sigill.intra.peff.net>
 <xmqqd1n6h6iq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1n6h6iq.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 09:54:21AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ...  It's
> > not a flag day for either, of course; we'll build in all of the usual
> > backwards-compatibility flags. But it's convenient for users to remember
> > that "3.0" is the minimum to support a new slate of
> > backwards-incompatible features.
> >
> > So my inclination is that the next version is simply v2.10. And maybe
> > you thought of all of this already, and that's why you didn't even
> > bother mentioning it. :) I'm just curious to hear any thoughts on the
> > matter.
> 
> You traced my thought very precisely.  If you take the "It is for
> compatibility breaking release" and "We plan such a release well in
> advance with transition period" together, a natural consequence is
> that by the time we tag one release (e.g. v2.9), it is expected that
> the release notes for it and a few previous releases would all have
> said "in v3.0, this and that things need to be adjusted, but the
> past few releases should have prepared all of you for that change".
> 
> So, no. I do not think the next one can sensibly be v3.0.
> 
> During this cycle what can happen at most is that harbingers of
> compatibility breakers conceived, transition plans for them laid
> out, and the first step for these compatibility breakers included.
> That will still not qualify for a version bump.  The follow-up steps
> for these compatibility breakers may start cooking in 'next', and
> during the next cycle the list may agree they are ready for the
> upcoming release.  At that point, before tagging the last release in
> v2.x series, we already know that the cycle after that will be v3.0
> to include these compatibility breakers.

Thanks, that spells out much better my "we are not ready" thoughts, and
I am in complete agreement.

-Peff
