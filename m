From: Nicolas Pitre <nico@cam.org>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 00:52:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710180049450.19446@xanadu.home>
References: <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena>
 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNNf-0000UO-Lf
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbXJRExB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbXJRExB
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:53:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55034 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbXJRExA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:53:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ300CCFC8B1D60@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 00:52:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071018024553.GA5186@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61468>

On Wed, 17 Oct 2007, Jeff King wrote:

> As an aside, that commit was enough to trigger a "git-gc --auto", which
> was my first experience with it. It's actually kind of annoying
> (especially since I was about to repack -a -d).

Well, you actually touched every files in the tree, and there are about 
22K of them.  this, plus the tree objects leading to them, your commit 
certainly did create an unusual amount of loose objects.  Repacking them 
will inevitably take a wile.


Nicolas
