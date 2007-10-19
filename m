From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
	objects'
Date: Thu, 18 Oct 2007 22:59:13 -0400
Message-ID: <20071019025913.GA9227@coredump.intra.peff.net>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182238470.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:59:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iii5F-0005AT-7U
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760500AbXJSC7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763907AbXJSC7R
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:59:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2601 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763880AbXJSC7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:59:16 -0400
Received: (qmail 8110 invoked by uid 111); 19 Oct 2007 02:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:59:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:59:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182238470.19446@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61619>

On Thu, Oct 18, 2007 at 10:45:31PM -0400, Nicolas Pitre wrote:

> Yet that progress display isn't solely about "delta compressing".  It 
> also includes the search for best object match in order to keep the 
> smallest delta possible.

In fact, isn't that progress meter _solely_ about finding the best
matches? The actual deltification (that is, the creation of the deltas
and writing of them to the packfile happens during the writing phase --
unless, of course, we've cached the deltas during the search phase).

Perhaps one of:

  Finding deltas
  Finding delta candidates
  Matching objects

or something similar (though I don't especially like any of them, I
think you get the idea).

-Peff
