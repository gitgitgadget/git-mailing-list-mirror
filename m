From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 11:33:17 -0500
Message-ID: <20090130163317.GB6963@sigill.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <7v4ozhd1wp.fsf@gitster.siamese.dyndns.org> <7vwscdbkpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901301423120.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwKL-0006Ef-K4
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZA3QdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbZA3QdV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:33:21 -0500
Received: from peff.net ([208.65.91.99]:40901 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbZA3QdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:33:20 -0500
Received: (qmail 2946 invoked by uid 107); 30 Jan 2009 16:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 30 Jan 2009 11:33:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 11:33:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301423120.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107846>

On Fri, Jan 30, 2009 at 02:24:57PM +0100, Johannes Schindelin wrote:

> Let's reap all the opinions about this issue, and then I'll do the wrap-up 
> patch.

I thought what Junio said was very reasonable (improve the message and
give it some more time to work).

But I honestly do not care that much either way. I probably would have
made the original patch default to "deny" if not for discussion
recommending to be conservative. On the other hand, I don't think we
have really given the "warning" approach enough time to see whether it
is working (and I don't necessarily disagree with your gut feeling that
it won't work; I am undecided, which leads me to want more data).

-Peff
