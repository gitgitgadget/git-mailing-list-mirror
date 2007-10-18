From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to
	start
Date: Thu, 18 Oct 2007 14:08:44 -0400
Message-ID: <20071018180843.GA11624@sigill.intra.peff.net>
References: <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com> <47176AB9.7010409@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 20:09:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiZnj-0002z1-Bk
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbXJRSIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758312AbXJRSIo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:08:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1734 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388AbXJRSIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:08:44 -0400
Received: (qmail 4135 invoked by uid 111); 18 Oct 2007 18:08:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 18 Oct 2007 14:08:42 -0400
Received: (qmail 11659 invoked by uid 1000); 18 Oct 2007 18:08:44 -0000
Content-Disposition: inline
In-Reply-To: <47176AB9.7010409@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61552>

On Thu, Oct 18, 2007 at 07:16:25AM -0700, Steven Grimm wrote:

>> installed in the first place.  Perhaps a message more along the lines of 
>> "To avoid this, run "git gc" manually on a regular basis.  See 'git help 
>> gc' for more information."
>
> That's a good point. Jeff / Shawn, do you agree with that? I'll come up with 
> an alternate patch if so.

Yes, that seems reasonable. I think the most important thing is that
they realize that "git-gc" is responsible for what is happening.  That
should allow them to find more information in the documentation if they
want (and Brian's suggestion points directly to the documentation, which
is great).

-Peff
