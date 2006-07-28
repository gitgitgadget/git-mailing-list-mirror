From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 16:51:30 +0200
Message-ID: <20060728145130.GO13776@pasky.or.cz>
References: <20060728054341.15864.35862.stgit@machine> <Pine.LNX.4.63.0607281045430.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060728140058.GM13776@pasky.or.cz> <Pine.LNX.4.63.0607281608520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 16:51:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Tge-0003nE-8t
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 16:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWG1Ovd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWG1Ovd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 10:51:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27297 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751992AbWG1Ovc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 10:51:32 -0400
Received: (qmail 28666 invoked by uid 2001); 28 Jul 2006 16:51:30 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607281608520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24389>

Hi!

Dear diary, on Fri, Jul 28, 2006 at 04:13:28PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> You misunderstood me: I was talking about a (hidden) local multiplexer.

Yes; I just wanted to cover another obvious alternative.  :-)

> But in the scenario you painted, wouldn't it be practical to have one 
> consolidated repo _in addition_ to the small ones? Of course, the refs in 
> the consolidated one would have to be prefixed with the name of the repo 
> they come from.

You still have problems with tags, for example, and pushing may get
tricky. It's also non-intuitive for users (I'm seeing some repositories
in gitweb but fetching from something completely different, and look at
those weird things I have to do with the branches, or git will clone
_all_ the xorg projects at once for me, eeek).

Of course you could hide all that elaborately in the porcelain but I
think this turns to be eventually much less-impact solution which is
significantly easier to maintain for the repository admins, intuitive
for users and also simpler for porcelains supporting at least
light-weight subprojects.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
