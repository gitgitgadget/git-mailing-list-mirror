Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AD12018A
	for <e@80x24.org>; Fri, 24 Jun 2016 15:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbcFXPsG (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 11:48:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:59744 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbcFXPsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 11:48:04 -0400
Received: (qmail 21295 invoked by uid 102); 24 Jun 2016 15:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:48:03 -0400
Received: (qmail 20248 invoked by uid 107); 24 Jun 2016 15:48:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 11:48:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 11:48:01 -0400
Date:	Fri, 24 Jun 2016 11:48:01 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: Short-term plans for the post 2.9 cycle
Message-ID: <20160624154800.GB2448@sigill.intra.peff.net>
References: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 03:52:04PM -0700, Junio C Hamano wrote:

> Here are the list of topics that are in the "private edition" I use
> for every day work, grouped by where they sit in the the near-term
> plan of merging them up to 'next' and then to 'master'.

By the way, I wondered if you had thoughts on the number of the upcoming
version. We are looking at v2.10 in the current scheme. It was at the
v1.9/v1.10 boundary that we jumped to v2.0 last time.

Certainly it is nice to avoid bumping into double digits (if only to
prevent bugs created by lexical sorting). But it feels rather quick to
be jumping to v3.0. And indeed it is much quicker, as the v1.x series
had an extra level of versioning which meant that the second-biggest
number advanced ten times more slowly.

I know some people's opinion is that versions do not matter, are just
numbers, etc, but I am not sure I agree. If you have dots in your
version number, then bumping the one before the first dot seems like a
bigger change than usual, and I think we should reserve it for a moment
where we have bigger changes in the code.

And I am not at all sure that we have given much thought to what such
changes would be, or that such things would be ready in this cycle. Off
the top of my head, the repository-format bump for pluggable ref
backends, and protocol v2 support seem like possible candidates.  It's
not a flag day for either, of course; we'll build in all of the usual
backwards-compatibility flags. But it's convenient for users to remember
that "3.0" is the minimum to support a new slate of
backwards-incompatible features.

So my inclination is that the next version is simply v2.10. And maybe
you thought of all of this already, and that's why you didn't even
bother mentioning it. :) I'm just curious to hear any thoughts on the
matter.

-Peff
