From: Petr Baudis <pasky@ucw.cz>
Subject: Re: manpage name conflict
Date: Thu, 19 May 2005 17:58:05 +0200
Message-ID: <20050519155804.GB4513@pasky.ji.cz>
References: <E1DYmy8-0003YB-JW@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 17:59:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYnP2-0001nK-Ly
	for gcvg-git@gmane.org; Thu, 19 May 2005 17:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVESP6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 11:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVESP6O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 11:58:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11166 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262540AbVESP6H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 11:58:07 -0400
Received: (qmail 5620 invoked by uid 2001); 19 May 2005 15:58:05 -0000
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1DYmy8-0003YB-JW@highlab.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 19, 2005 at 05:29:52PM CEST, I got a letter
where Sebastian Kuzminsky <seb@highlab.com> told me that...
> Hi folks, I maintain a Debian package for Cogito (it just went into "Sid"
> aka "unstable"), and I just got a bug report from a user that I'd like
> your input on.
> 
> 
> The problem is that Cogito wants to install a git(1) manpage, and so does
> the GNU Interactive Tools.  The GNU Interactive Tools actually have a
> program called "git", so it seems only fair that they get to call their
> manpage by the same name.  The GIT-as-in-Cogito git(1) manpage gives
> an overview of the GIT-as-in-Cogito core, so maybe we could install it
> as git-core(1)?

Does this manpage actually belong to man1? What about git(7) or
something? It's not an actual command.


Not directly related to this problem, but just FYI - git isn't staying
as part of Cogito forever, actually I think its time in Cogito
distribution is running over soon (now that I've pushed all the interesting
local changes to git-pb, consequently to git-linus).

So you will have to either bundle it manually in the distribution
packages, or provide a separate git package for cogito to depend on
(when the unbundling really happens).  Either way, this is git issue,
not cogito. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
