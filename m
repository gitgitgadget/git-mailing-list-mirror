From: Petr Baudis <pasky@ucw.cz>
Subject: Re: missing: git api, reference, user manual and mission statement
Date: Tue, 19 Apr 2005 18:58:09 +0200
Message-ID: <20050419165809.GE12757@pasky.ji.cz>
References: <20050419123631.GD3739@xdt04.mpe-garching.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 18:55:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNvzz-0007kK-L7
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDSQ6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 12:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDSQ6u
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 12:58:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23234 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261627AbVDSQ6N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 12:58:13 -0400
Received: (qmail 32312 invoked by uid 2001); 19 Apr 2005 16:58:09 -0000
To: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Content-Disposition: inline
In-Reply-To: <20050419123631.GD3739@xdt04.mpe-garching.mpg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 02:36:32PM CEST, I got a letter
where Klaus Robert Suetterlin <robert@mpe.mpg.de> told me that...
> 1) There is no clear (e.g. by name) distinction between ``git as done
> by Linus'', which is a kind of content addressable database with added
> semantics, and ``git as done by the rest of You'', which is a kind of
> SCM on top of Linuses stuff.

There is git and git-pasky (git-pasky is superset; therefore various
patches floating around either get to git-pasky or to both). I'm not
sure what else do you mean.

> 2) For Linuses stuff I dare to say that it is an evil hack from
> hell.  A prototype come alive.  This is not meant as an insult;  I
> guess Linus agrees.

I don't think it's evil at all. Why should it?

> I do think there should be a well defined API or UI so that the
> backend could be replaced / changed / improved as need dictates.

It's stabilizing. Mind you, it's 2 weeks old.

> 3) As of the gitSCM stuff, I really miss any kind of description
> how it works.  That is it completely lacks any concept, except for
> ``we will use gitLinus as backend''.

Have you read the README? If you have any questions, go ahead and ask.
_Write_ the description if you miss it.

> 4) Concerning usability on systems other than Linux...  I guess
> this one can be ignored by most.
> 
> The source still uses st->st_mtim.tv_nsec which should be ->st_mtimensec, I guess.

Patches welcome.

> git is implemented as mostly sh shell scripts.
> gitdiff-do and gitlog.sh rely on bash, more precisely on /bin/bash.
> git pull uses rsync
> ...
> 
> The list of dependencies is long and growing.  So if the intent of
> doing gitSCM with shell scripts was to make it portable: that goal was missed.

I think the way to go now that it's working and we are to add some sweet
cream on it is to rewrite it in Perl. I have some parts in progress
already.

> 5) gitLinus as library.
> 
> First I have to say that between what I saw in git-0.04 and the
> current stuff from git-pasky there has been quite a lot of work to
> get further away from the evil prototype.
> 
> Still gitLinus lacks a clear definition of its interface, so I
> guess no one will be able to tell if it works correct.  How could You
> do a test case without knowing
> a) what the software should do and
> b) how You should tell it?

You couldn't. UTSL now and write the docs and the testcases, or wait a
while.

> And of course there are still memory leaks.  The obvious
> --- i.e. malloc and (missing) free in the same function --- I found
> while reading the git-0.04 source yesterday are gone.  Still I found
> one of the ``malloc in called function no free in caller'' leaks
> in git-pasky as pulled NOW.  And all I did was `grep malloc *'.
> Someone should sit down and read all the source top to bottom.  And
> the software should either check its resource usage or someone
> should use a good tool on it.

"Someone"?

Again, patches welcome. The patches are likely usually no big deal now,
though. I'm by all means for fixing them, especially when git will start
to head towards libgit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
