From: Jeff King <peff@peff.net>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 13:41:57 -0400
Message-ID: <20080624174157.GB9500@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCXg-0005Vk-A7
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYFXRmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYFXRmA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:42:00 -0400
Received: from peff.net ([208.65.91.99]:4649 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYFXRl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:41:59 -0400
Received: (qmail 5285 invoked by uid 111); 24 Jun 2008 17:41:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 13:41:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 13:41:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806241808400.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86096>

On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin wrote:

> 	And this is my first attempt at a proper patch for it.
> 
> 	Now with documentation, and hopefully all places where the
> 	user is being told about a "bad" commit.

This looks reasonably sane to me. The only thing I can think of that
we're missing is that "git bisect visualize" will still show the refs as
"bisect/bad" and "bisect/good".

To fix that, you'd have to ask people to start the bisect by saying "I
am bisecting to find a fix, not a breakage." And then you could change
the refnames and all of the messages as appropriate.

-Peff
