From: Petr Baudis <pasky@suse.cz>
Subject: Re: git on HP-UX
Date: Mon, 10 Jul 2006 00:23:38 +0200
Message-ID: <20060709222338.GV29115@pasky.or.cz>
References: <200607060950.34558.michal.rokos@nextsoft.cz> <1152197629.7720.10.camel@dv> <7vfyhe465i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzhgm-0004fw-2s
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWGIWXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWGIWXl
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:23:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56968 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161191AbWGIWXk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:23:40 -0400
Received: (qmail 22033 invoked by uid 2001); 10 Jul 2006 00:23:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyhe465i.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23572>

Dear diary, on Fri, Jul 07, 2006 at 02:20:41AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> > I hope the Autoconf based configure is on its way to git, but I don't
> > see in in the "pu" branch yet.  I'm not very keen about reinventing
> > Autoconf and hacking a hand-made configure script.
> 
> OK, you half-convinced me.  The other half came from a recent
> series of patches to try using 'which' to detect executables,
> which is another common mistake handcrafted configure script
> makes, which autoconf people have solved for us long time ago.

Good! In fact, I have been a moderate autoconf fan and originally I have
meant the hand-crafted ./configure script partially just as a tease and
a nominal competitor for the autoconf one, so that we would for sure got
_some_ autoconfiguration mechanism (which is what I care about).

I have to admit that I have grown somewhat attached to my script over
time and I like it a lot more than the autoconf thing personally, but
then again I had no idea that we actually want to support such systems
like those with broken which...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
