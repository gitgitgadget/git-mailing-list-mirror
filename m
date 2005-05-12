From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 22:14:06 +0200
Message-ID: <20050512201406.GJ324@pasky.ji.cz>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz> <20050512201116.GC5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:07:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJxY-0003sn-IC
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVELUOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVELUO1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:14:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28122 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262082AbVELUOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 16:14:09 -0400
Received: (qmail 16737 invoked by uid 2001); 12 May 2005 20:14:06 -0000
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050512201116.GC5914@waste.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 10:11:16PM CEST, I got a letter
where Matt Mackall <mpm@selenic.com> told me that...
> On Thu, May 12, 2005 at 08:23:41PM +0200, Petr Baudis wrote:
> > Dear diary, on Thu, May 12, 2005 at 11:44:06AM CEST, I got a letter
> > where Matt Mackall <mpm@selenic.com> told me that...
> > > Mercurial is more than 10 times as bandwidth efficient and
> > > considerably more I/O efficient. On the server side, rsync uses about
> > > twice as much CPU time as the Mercurial server and has about 10 times
> > > the I/O and pagecache footprint as well.
> > > 
> > > Mercurial is also much smarter than rsync at determining what
> > > outstanding changesets exist. Here's an empty pull as a demonstration:
> > > 
> > >  $ time hg merge hg://selenic.com/linux-hg/
> > >  retrieving changegroup
> > > 
> > >  real    0m0.363s
> > >  user    0m0.083s
> > >  sys     0m0.007s
> > > 
> > > That's a single http request and a one line response.
> > 
> > So, what about comparing it with something comparable, say git pull over
> > HTTP? :-)
> 
> ..because I get a headache every time I try to figure out how to use git? :-P
> 
> Seriously, have a pointer to how this works?

Either you use cogito and just pass cg-clone an HTTP URL (to the git
repository as in the case of rsync -
http://www.kernel.org/pub/scm/cogito/cogito.git should work), or you
invoke git-http-pull directly (passing it desired commit ID of the
remote HEAD you want to fetch, and the URL; see
Documentation/git-http-pull.txt).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
