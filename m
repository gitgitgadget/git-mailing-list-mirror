From: Petr Baudis <pasky@suse.cz>
Subject: Re: Quick merge status updates.
Date: Sun, 2 Jul 2006 23:49:31 +0200
Message-ID: <20060702214931.GJ29115@pasky.or.cz>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net> <1151471040.4940.17.camel@dv> <7v7j3164xd.fsf@assigned-by-dhcp.cox.net> <1151489103.28036.6.camel@dv> <20060702204906.GG29115@pasky.or.cz> <7v64if3d50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 23:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9ou-0002yv-8L
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWGBVtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWGBVtd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:49:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38575 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750825AbWGBVtd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 17:49:33 -0400
Received: (qmail 10815 invoked by uid 2001); 2 Jul 2006 23:49:31 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64if3d50.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23127>

Dear diary, on Sun, Jul 02, 2006 at 11:33:47PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I tried this:
> 
>  0. check out the branch that has the Perly git ("pu").  build
>     and install normally to have a perfectly working version
>     accessible on your usual $PATH.
> 
>  1. apply the patch [1] below to make it use "use lib" instead of
>     "unshift".
> 
>  2. break perl/Git.pm being built to pretend we introduced a bug
>     in the work in progress by applying the patch [2] below.
> 
>  3. without installing the broken Git.pm, run "make test", and
>     see a test that uses "git pull" and needs to create a true
>     merge succeed.  It tells me that everything including
>     perl/Git.pm is GOOD, and I'd find the breakage only after
>     installing and running the test again.

So, just to clarify and make sure we understand each other perfectly,
you claim that when skipping (1), (3) _does_ FAIL for you? Because it
really doesn't for me and I can't see how could it ever fail without
installing the broken version first.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
