From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to
 start
Date: Thu, 18 Oct 2007 10:21:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710181019080.19446@xanadu.home>
References: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org>
 <20071018032307.GA7313@coredump.intra.peff.net>
 <20071018044143.GA24043@midwinter.com>
 <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: koreth@midwinter.com, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiWFw-0007yu-1X
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 16:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761887AbXJROVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757757AbXJROVf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 10:21:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30968 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbXJROVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 10:21:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ400EI92JI8B90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 10:21:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61533>

On Thu, 18 Oct 2007, Brian Gernhardt wrote:

> 
> On Oct 18, 2007, at 12:41 AM, koreth@midwinter.com wrote:
> 
> > And as an added bonus, we can tell people how to turn off automatic GC
> > and how to invoke it by hand.
> 
> > +		fprintf(stderr, "Packing your repository for optimum "
> > +			"performance. If you would rather run\n"
> > +			"\"git gc\" by hand, run \"git config gc.auto 0\" "
> > +			"to disable automatic cleanup.\n");
> 
> I'm not sure telling the users how to disable it every time it shows up is a
> good idea.  gc --auto exists for the naive user, and suggesting they turn it
> off each time it happens will just result in...  people turning it off,
> leading back to the performance issues that caused the feature to be installed
> in the first place.  Perhaps a message more along the lines of "To avoid this,
> run "git gc" manually on a regular basis.  See 'git help gc' for more
> information."

This is indeed a good point.

And for those who start repacking manually then the automatic repacking 
will very rarely trigger, reducing the need for turning automatic 
repacking off anyway.


Nicolas
