From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 22:24:51 +0200
Message-ID: <20050414202451.GD22699@pasky.ji.cz>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <20050414222326.E2442@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:22:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMAqL-0008AS-0U
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDNUZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVDNUZA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 16:25:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54730 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261520AbVDNUYx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 16:24:53 -0400
Received: (qmail 388 invoked by uid 2001); 14 Apr 2005 20:24:51 -0000
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Content-Disposition: inline
In-Reply-To: <20050414222326.E2442@banaan.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 10:23:26PM CEST, I got a letter
where Erik van Konijnenburg <ekonijn@xs4all.nl> told me that...
> On Thu, Apr 14, 2005 at 09:35:07PM +0200, Petr Baudis wrote:
> > Hmm. I actually don't like this naming. I think it's not too consistent,
> > is irregular, therefore parsing it would be ugly. What I propose:
> > 
> > 12c\tname <- legend
> >           <- original file
> > D         <- tree #1 removed file
> >  D        <- tree #2 removed file
> > DD        <- both trees removed file
> > M         <- tree #1 modified file
> >  M
> > DM*       <- conflict, tree #1 removed file, tree #2 modified file
> > MD*
> > MM        <- exact same modification
> > MM*       <- different modifications, merging
> > 
> > This is generic, theoretically scales well even to more trees, is easy
> > to parse trivially, still is human readable (actually the asterisk in
> > the 'conflict' column is there basically only for the humans), is
> > completely regular and consistent.
> 
> Detail: perhaps use underscore instead of space, to avoid space/tab typos
> that are invisible on paper and user friendly mail clients?

I'd go for dots in that case. Looks less intrusive. :^)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
