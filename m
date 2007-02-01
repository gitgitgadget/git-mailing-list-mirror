From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with
 ui.guide
Date: Thu, 01 Feb 2007 16:59:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011656250.3021@xanadu.home>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
 <20070131231942.GB31145@coredump.intra.peff.net>
 <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
 <20070201030030.GA1979@coredump.intra.peff.net>
 <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
 <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
 <20070201184403.GA6326@moooo.ath.cx> <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net>
 <20070201205145.GA13439@moooo.ath.cx>
 <7vabzxoaed.fsf@assigned-by-dhcp.cox.net> <87ps8ta7fx.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjyC-0007LY-Rp
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXBAV7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXBAV7s
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:59:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46102 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXBAV7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:59:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT00F4713MYFC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 16:59:46 -0500 (EST)
In-reply-to: <87ps8ta7fx.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38412>

On Thu, 1 Feb 2007, Carl Worth wrote:

> I think the problem with this is that git tells the user so little
> information, ("may lose your changes"). What changes? Is that dirty
> state?  Some commits? Hmm... have I committed anything? Why can't git
> be sure about what this operation is going to do?
> 
> I think a really useful message would be something like:
> 
> 	You are not on any branch so switching to branch 'foo'
> 	will cause the following commits to be lost:
> 
> 		ba531642 A commit headline here...
> 		b1189118 Another commit headline here...
> 
> 	Refusing to checkout 'foo'.

Please just display the last commit since this list could get long.

> If there are no commits that would become dangling, then the checkout
> should just proceed. As for the concern about losing a pointer to some
> "valuable" state that will still technically be reachable, but might
> be hard to get back, why not just print a message along the lines of:
> 
> 	Leaving commit 7b1509f4 to checkout 'foo'.
> 
> (or just depend on the HEAD reflog).

It is not fully available yet.


Nicolas
