From: Dave Jones <davej@redhat.com>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 13:37:31 -0500
Message-ID: <20060129183731.GE19685@redhat.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 19:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3HRC-0006Rj-Me
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWA2Sh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWA2Sh4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:37:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751027AbWA2Shz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:37:55 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k0TIbaaO006754;
	Sun, 29 Jan 2006 13:37:36 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k0TIba118588;
	Sun, 29 Jan 2006 13:37:36 -0500
Received: from nwo.kernelslacker.org (vpn83-121.boston.redhat.com [172.16.83.121])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k0TIbZhe008318;
	Sun, 29 Jan 2006 13:37:35 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id k0TIbZOn010786;
	Sun, 29 Jan 2006 13:37:35 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k0TIbVvi010785;
	Sun, 29 Jan 2006 13:37:31 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15229>

On Sat, Jan 28, 2006 at 01:08:54PM -0800, Junio C Hamano wrote:
 > Can I hear experiences from other big projects that tried to use
 > git [*1*]?  I suspect there are many that have tried, and I
 > would not be surprised at all if git did not work out well for
 > them.  For projects that already run on a (free) SCM, I would be
 > very surprised if the developers find the current git 10 times
 > better than the SCM they have been using (probably with an
 > exception of CVS), unless they have very specific need, such as
 > parallel development of distributed nature like the Linux
 > kernel.

I've found switching from cvs->git even for small projects has
made me more productive.  In part because it's got me away from
the 'check in to a centralised server like sourceforge' mentality,
without the need to set up a local cvs server of my own.
Adding changesets to a small project like x86info, now takes
seconds, whereas it used to take minutes of thumb-twiddling whilst
I waited for sf.net to do its thing.   The ability to check in
changesets locally whilst I'm travelling, and then push them when
I have network connectivity again is also a massive productivity
win over cvs.

There's also another git usage that I doubt I'm alone in doing.
I regularly use git to import cvs trees from sourceforge etc for
random projects, because I now find browsing history of projects
with tools like gitk much nicer than any cvs tool I've used.
(cvs annotate is the only thing I really miss).

What would be really cool, would be a web page pointing to public
conversions of various projects cvs trees, so that everyone doesn't
have to keep hammering various repos to do the conversions themselves.
(Sort of a pseudo bkbits.net).

		Dave
