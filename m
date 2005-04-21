From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Linux 2.6.12-rc3
Date: Thu, 21 Apr 2005 23:41:19 +0200
Message-ID: <20050421214119.GO7443@pasky.ji.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421190009.GC475@openzaurus.ucw.cz> <20050421190956.GA7443@pasky.ji.cz> <20050421213811.GA31207@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 23:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjMF-0000zk-Gc
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVDUVle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDUVle
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:41:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8841 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261183AbVDUVlY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 17:41:24 -0400
Received: (qmail 5530 invoked by uid 2001); 21 Apr 2005 21:41:19 -0000
To: Pavel Machek <pavel@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050421213811.GA31207@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 11:38:11PM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> Hi!
> 
> It seems that someone should write "Kernel hacker's guide to
> git"... Documentation/git.txt seems like good place. I guess I'll do
> it.

I've also started writing some tutorial-like guide to Cogito on my
notebook, but I have time for that only during lectures. :^)

> > I'm not yet sure if we should have some Cogito interface for doing this
> > and what its semantics should be.
> 
> What is Cogito, BTW?

New name for git-pasky. Everyone will surely rejoice as the usage will
change significantly. But better let's clean it up now.

(For more details, check git@ archives for git-pasky-0.6 announcement.)

> > > I see quite a lot of problems with fsck-tree. Is that normal?
> > > (I ran out of disk space few times during different operations...)
> > 
> > Actually, in case your tree is older than about two days, I hope you did
> > the convert-cache magic or fetched a fresh tree?
> 
> No, I did not anything like that. I guess it is rm -rf time, then...

That's the root of all your problems then.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
