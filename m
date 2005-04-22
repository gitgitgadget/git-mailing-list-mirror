From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Sat, 23 Apr 2005 01:05:51 +0200
Message-ID: <20050422230551.GI21204@pasky.ji.cz>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422064936.GA10854@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP79f-00044D-8K
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDVXGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDVXGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:06:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20642 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261279AbVDVXFx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:05:53 -0400
Received: (qmail 28494 invoked by uid 2001); 22 Apr 2005 23:05:51 -0000
To: Greg KH <greg@kroah.com>
Content-Disposition: inline
In-Reply-To: <20050422064936.GA10854@kroah.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 08:49:37AM CEST, I got a letter
where Greg KH <greg@kroah.com> told me that...
> On Fri, Apr 22, 2005 at 05:09:31AM +0200, Petr Baudis wrote:
> >   Hello,
> > 
> >   FYI, I've released git-pasky-0.6.3 earlier in the night.
> 
> Hm, fun thing to try:
> 	go into a kernel git tree.
> 	rm Makefile
> 	git diff
> 
> Watch it as it thinks that every Makefile in the kernel tree is now
> gone...

Just FYI, this is bug in core git's diff-cache; also, when you update
the cache properly (either do

	git rm Makefile

or

	update-cache --remove Makefile

), it works fine. diff-cache should still not fail so horribly, though.

Unfortunately, I don't have time to debug it now. I will look at it
tomorrow if noone will fix it before. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
