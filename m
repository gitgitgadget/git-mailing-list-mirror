From: Jeff King <peff@peff.net>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Fri, 10 Aug 2007 12:55:21 -0400
Message-ID: <20070810165521.GA19657@coredump.intra.peff.net>
References: <20070810154108.GA779@ruiner> <20070810161123.GA14875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Hetro <whee@smaertness.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:55:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXm1-00071V-TP
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938752AbXHJQz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936478AbXHJQz0
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:55:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3236 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933450AbXHJQzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:55:25 -0400
Received: (qmail 4518 invoked by uid 111); 10 Aug 2007 16:55:31 -0000
X-Spam-Status: No, hits=-1.2 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 10 Aug 2007 12:55:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2007 12:55:21 -0400
Content-Disposition: inline
In-Reply-To: <20070810161123.GA14875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55556>

On Fri, Aug 10, 2007 at 12:11:23PM -0400, Jeff King wrote:

> http://thread.gmane.org/gmane.comp.version-control.git/53126
> 
> Can you confirm that it is still a problem in 1.5.3-rc4?

I just tried to trigger the original bug (by running "gitk arch/i386" in
the linux-2.6 repo) using 1.5.3.rc4.41.g7efe, and I couldn't reproduce
it.

Can you make your test repo available?

Note that the fix _isn't_ in gitk, but rather in git itself. Is it
possible that gitk is calling another, older version of git-rev-list
that you have installed somewhere?

-Peff
