From: Jeff King <peff@peff.net>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 00:55:20 -0400
Message-ID: <20071018045520.GA10857@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.9999.0710180049450.19446@xanadu.home> <20071018045453.GA10825@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNQ3-0000kr-1s
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762505AbXJREzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762389AbXJREzY
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:55:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2113 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762258AbXJREzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:55:23 -0400
Received: (qmail 32457 invoked by uid 111); 18 Oct 2007 04:55:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 00:55:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 00:55:20 -0400
Content-Disposition: inline
In-Reply-To: <20071018045453.GA10825@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61471>

On Thu, Oct 18, 2007 at 12:54:53AM -0400, Jeff King wrote:

> > Well, you actually touched every files in the tree, and there are about 
> > 22K of them.  this, plus the tree objects leading to them, your commit 
> > certainly did create an unusual amount of loose objects.  Repacking them 
> > will inevitably take a wile.
> 
> Yes, I know. I wasn't complaining so much about the speed, but rather
> the behavior of "git-gc" running while I was in the middle of trying to
> accomplish something else (I hadn't seen it before, because I generally
> keep my repos fairly packed).

But if you are trying to say that my case is pathological, then yes.

-Peff
