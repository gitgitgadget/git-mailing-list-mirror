From: Nicolas Pitre <nico@cam.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 17:23:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
References: <20060914142249.GK23891@pasky.or.cz>
 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:24:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNygi-0005DE-4y
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWINVX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWINVX4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:23:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29091 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751193AbWINVX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 17:23:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J5L0013LQ3KX6K0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Sep 2006 17:23:45 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27041>

On Thu, 14 Sep 2006, Linus Torvalds wrote:

> For better packing, I think I used a larger depth, ie try something like
> 
> 	git repack -a -f --depth=50
> 
> to get more improvement. For a historical archive that you don't much use, 
> doign the deeper depth is definitely worth it.

Using a larger window helps too.  It of course has a direct impact on 
the processing to perform a full repack, but it has no runtime costs 
when the pack is used.  So I'd suggest adding --window=50 to the above.

[ I made those suggestions in person to Thomas at OLS to which 
  he replied he'd do it when he'd get back home.   ;-) ]


Nicolas
