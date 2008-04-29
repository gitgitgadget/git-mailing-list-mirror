From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 19:02:37 -0400
Message-ID: <20080429230237.GA22598@sigill.intra.peff.net>
References: <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home> <48179625.3050704@gnu.org> <alpine.DEB.1.00.0804292324040.13650@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, Alex Riesen <raa.lkml@gmail.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, srb@cuci.nl
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:03:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqyr7-0002Oe-HS
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbYD2XCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYD2XCi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:02:38 -0400
Received: from peff.net ([208.65.91.99]:1948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbYD2XCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:02:38 -0400
Received: (qmail 22622 invoked by uid 111); 29 Apr 2008 23:02:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 19:02:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 19:02:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804292324040.13650@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80763>

On Tue, Apr 29, 2008 at 11:26:46PM +0100, Johannes Schindelin wrote:

> I wonder why you need to make such a big change, which _is_ incompatible, 
> and not do the obvious thing, namely introduce a subcommand to "git 
> remote" which does the "push" equivalent of "git remote update"...
> 
> Do you really think that it is a good idea to push down a huge change like 
> this down everybody else's throat, just because you do not want to type 
> "git remote ..." but "git fetch ..." in your workflow?

I wonder this a bit, too, and I am even somebody who _likes_ the new
behavior. But there is a difference between "should have been designed
this way in the first place" and "is currently designed some other way,
and will cause pain to switch it to this way."

So it might simply not be worth the trouble to change. OTOH, I think
this is how we end up with many commands to do slightly different
things, which can end up confusing new users. I'm not sure what the
right answer is.

-Peff
