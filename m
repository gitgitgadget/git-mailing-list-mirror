From: Nicolas Pitre <nico@cam.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 21:19:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609142115560.2627@xanadu.home>
References: <20060914142249.GK23891@pasky.or.cz>
 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
 <1158269854.5724.240.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609141742000.2627@xanadu.home>
 <1158270859.5724.244.camel@localhost.localdomain>
 <1158272651.5724.251.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 15 03:19:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO2Me-00074C-HF
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 03:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWIOBTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 21:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWIOBTG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 21:19:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33456 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751403AbWIOBTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 21:19:05 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5M004VB0ZSZM90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Sep 2006 21:19:04 -0400 (EDT)
In-reply-to: <1158272651.5724.251.camel@localhost.localdomain>
X-X-Sender: nico@xanadu.home
To: Thomas Gleixner <tglx@linutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27053>

On Fri, 15 Sep 2006, Thomas Gleixner wrote:

> On Thu, 2006-09-14 at 23:54 +0200, Thomas Gleixner wrote:
> > On Thu, 2006-09-14 at 17:42 -0400, Nicolas Pitre wrote:
> > > > git repack neither accepts --depth nor --window
> > > 
> > > Is the GIT version on kernel.org _that_ old?
> > > 
> > > What a shame...
> > 
> > [tglx@hera history.git]$ git --version
> > git version 1.4.2.1

OK that's recent enough indeed.

> I know I'm stupid
> 
> "git-repack --window=50 --depth=50 -a -f" works
> "git-repack -a -f --window=50 --depth=50" does not
> 
> Intuitive user interfaces are my favorite pitfalls.

Erm... Both incantations work fine fine here.

> -rw-rw-r-- 1 tglx ftpadmin  13600376 Sep 14 22:16 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.idx
> -rw-rw-r-- 1 tglx ftpadmin 158679705 Sep 14 22:16 pack-4d27038611fe7755938efd4a2745d5d5d35de1c1.pack

And I get the same result as well.


Nicolas
