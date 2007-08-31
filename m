From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 12:03:35 -0400
Message-ID: <20070831160335.GA17761@coredump.intra.peff.net>
References: <20070830063810.GD16312@mellanox.co.il> <7v7inda5ar.fsf@gitster.siamese.dyndns.org> <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org> <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org> <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org> <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8yD-0004iK-RR
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555AbXHaQDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758551AbXHaQDi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:03:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2735 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758175AbXHaQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:03:37 -0400
Received: (qmail 30915 invoked by uid 111); 31 Aug 2007 16:03:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 31 Aug 2007 12:03:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2007 12:03:35 -0400
Content-Disposition: inline
In-Reply-To: <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57178>

On Fri, Aug 31, 2007 at 08:44:12AM -0700, Junio C Hamano wrote:

> I did not even want to apply that "empty diff --git removal"
> patch.  I certainly do _NOT_ want to suppress that replacement
> warning anywhere.
> 
> You are seriously tempting me to revert the commit
> fb13227e089f22dc31a3b1624559153821056848 (git-diff: squelch
> "empty" diffs)...

FWIW, I find the new message terribly ugly compared to the old behavior.
There have been many output changes that I didn't like at first, but for
which I held my tongue and eventually grew to like when they became more
familiar (e.g., the 'subject' line after git-commit).

But I just can't seem to find this one anything but ugly; everytime I
see it, I involuntarily cringe. Perhaps because it really looks like an
error message that accidentally got stuck in the diff output through
incompetent redirection of stdout/stderr.

I say this not to start a flame war (which is perhaps inevitable), but I
just wonder if others feel the same, now that they have had a chance to
get used to it.

-Peff
