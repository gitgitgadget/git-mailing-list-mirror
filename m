From: Junio C Hamano <junkio@cox.net>
Subject: [Census] So who uses git?
Date: Sat, 28 Jan 2006 13:08:54 -0800
Message-ID: <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 28 22:09:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2xJi-0007pW-2F
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 22:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWA1VI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWA1VI5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 16:08:57 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48357 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbWA1VI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 16:08:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060128210647.ULZU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 Jan 2006 16:06:47 -0500
To: Keith Packard <keithp@keithp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15200>

Keith Packard <keithp@keithp.com> writes:

> Once we're happy with the import, I'm pretty sure we'll just switch
> cairo over to git and dump the CVS bits. X.org is a harder case, for
> that I suspect we'll migrate individual modules over one at a time,
> perhaps starting with the core X server pieces so that I can get my work
> done, have it published in the main repository and not have it also
> break everyone else's X server.

Wow.......  You are switching Cairo and X.org from CVS to git?

It could be that anything is better than CVS these days, but I
have to admit that my jaw dropped after reading this, primarily
because I've have never touched anything as big as X.

Awestruck, dumbstruck,... Xstruck.  Yeah, I know I should have
more faith in git.  Earlier I heard Wine folks are running git
in parallel with CVS as their dual primary SCM now, and of
course git is the primary SCM for the Linux kernel project.

For things like the source code management, it takes a new
software to be at least 10 times as good as the one that has
been used, because switching _is_ a pain no matter how well tool
helps the transition.  You have to transition not just the
repository, but people who interact with it.

When the Linux kernel switched, it was not that hard to be
infinitely better than the previous one.  Because the previous
one was no longer available to the kernel community; git did not
have to be 10 times better on technical merits alone when the
transition happened.

Can I hear experiences from other big projects that tried to use
git [*1*]?  I suspect there are many that have tried, and I
would not be surprised at all if git did not work out well for
them.  For projects that already run on a (free) SCM, I would be
very surprised if the developers find the current git 10 times
better than the SCM they have been using (probably with an
exception of CVS), unless they have very specific need, such as
parallel development of distributed nature like the Linux
kernel.

I do not do mailing list search as often as I would like to be
doing, but I have seen some projects tried and went back to CVS.
We would learn much from our failures to support them -- what
those people found lacking.


[Foornote]

*1* Please limit yourselves to reasonably well-known "it is
surprising you haven't heard of this project" kind...
