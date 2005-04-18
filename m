From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 16:22:43 +0200
Message-ID: <20050418142243.GR1461@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 16:20:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNX5P-0007ZA-5l
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 16:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVDROWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 10:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDROWr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 10:22:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27047 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262084AbVDROWo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 10:22:44 -0400
Received: (qmail 24252 invoked by uid 2001); 18 Apr 2005 14:22:43 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 01:24:24AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sun, 17 Apr 2005, Russell King wrote:
> > 
> > I pulled it tonight into a pristine tree (which of course worked.)
> 
> Goodie.
> 
> > In doing so, I noticed that I'd messed up one of the commits - there's
> > a missing new file.  Grr.  I'll put that down to being a newbie git.
> 
> Actually, you should put that down to horribly bad interface tools.  With
> BK, we had these nice tools that pointed out that there were files that
> you might want to commit (ie "bk citool"), and made this very obvious.
> 
> Tools absolutely matter. And it will take time for us to build up that 
> kind of helper infrastructure. So being newbie might be part of it, but 
> it's the smaller part, I say. Rough interfaces is a big issue.

I just committed some simple git status, which is equivalent to svn
status or cvs update (except it does no update). So it shows all the
files not tracked by git with a question mark in front of them.

This will need some ignore rules, though (currently it just ignores *.o
and the tags file). Now it turns out that it is rather unfortunate that
git ignores hidden files, since this would be a perfect object for that
- I think it is useful to have the ignore list tracked by git. I think I
will just name it git-ignores to be found in the working directory for
now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
