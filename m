From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 15:17:24 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601291438251.25300@iabervon.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060129183731.GE19685@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxA-0000Mc-VD
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWA2UPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWA2UPN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:13 -0500
Received: from iabervon.org ([66.92.72.58]:49677 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751151AbWA2UPM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 15:15:12 -0500
Received: (qmail 20021 invoked by uid 1000); 29 Jan 2006 15:17:24 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2006 15:17:24 -0500
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060129183731.GE19685@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15238>

On Sun, 29 Jan 2006, Dave Jones wrote:

> On Sat, Jan 28, 2006 at 01:08:54PM -0800, Junio C Hamano wrote:
>  > Can I hear experiences from other big projects that tried to use
>  > git [*1*]?  I suspect there are many that have tried, and I
>  > would not be surprised at all if git did not work out well for
>  > them.  For projects that already run on a (free) SCM, I would be
>  > very surprised if the developers find the current git 10 times
>  > better than the SCM they have been using (probably with an
>  > exception of CVS), unless they have very specific need, such as
>  > parallel development of distributed nature like the Linux
>  > kernel.
> 
> I've found switching from cvs->git even for small projects has
> made me more productive.  In part because it's got me away from
> the 'check in to a centralised server like sourceforge' mentality,
> without the need to set up a local cvs server of my own.
> Adding changesets to a small project like x86info, now takes
> seconds, whereas it used to take minutes of thumb-twiddling whilst
> I waited for sf.net to do its thing.   The ability to check in
> changesets locally whilst I'm travelling, and then push them when
> I have network connectivity again is also a massive productivity
> win over cvs.
> 
> There's also another git usage that I doubt I'm alone in doing.
> I regularly use git to import cvs trees from sourceforge etc for
> random projects, because I now find browsing history of projects
> with tools like gitk much nicer than any cvs tool I've used.
> (cvs annotate is the only thing I really miss).

I think this is the real driving factor for git adoption: it doesn't have 
to be 10x better for people to use it, because individuals can use it for 
interacting with CVS projects without causing anybody else any pain. It 
doesn't just enable distributed development, it enables a distributed 
choice of SCM, which means a much lower activation energy threshold. I 
think we'll see a lot more adoption when we have a CVS daemon interface 
(so projects can stop having a CVS repository, and support both sorts of 
users with a git repository and have better metadata), and also if someone 
sets up a place for putting git imports of CVS projects, so people will 
know that other people are using git.

	-Daniel
*This .sig left intentionally blank*
