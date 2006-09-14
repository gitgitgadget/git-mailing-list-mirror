From: Nicolas Pitre <nico@cam.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 17:42:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609141742000.2627@xanadu.home>
References: <20060914142249.GK23891@pasky.or.cz>
 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
 <1158269854.5724.240.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:43:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNyyw-0008G3-Be
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWINVmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWINVmq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:42:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41190 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751151AbWINVmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 17:42:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5L001TMQZ9X7L0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Sep 2006 17:42:45 -0400 (EDT)
In-reply-to: <1158269854.5724.240.camel@localhost.localdomain>
X-X-Sender: nico@xanadu.home
To: Thomas Gleixner <tglx@linutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27045>

On Thu, 14 Sep 2006, Thomas Gleixner wrote:

> On Thu, 2006-09-14 at 17:23 -0400, Nicolas Pitre wrote:
> > On Thu, 14 Sep 2006, Linus Torvalds wrote:
> > 
> > > For better packing, I think I used a larger depth, ie try something like
> > > 
> > > 	git repack -a -f --depth=50
> > > 
> > when the pack is used.  So I'd suggest adding --window=50 to the above.
> 
> Great advise !
> 
> git repack neither accepts --depth nor --window

Is the GIT version on kernel.org _that_ old?

What a shame...


Nicolas
