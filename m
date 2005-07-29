From: Petr Baudis <pasky@suse.cz>
Subject: Re: Last mile to 1.0?
Date: Sat, 30 Jul 2005 00:41:48 +0200
Message-ID: <20050729224148.GB22530@pasky.ji.cz>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 00:46:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DydcC-0001ey-EU
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 00:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVG2WpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 18:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVG2WnS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 18:43:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8456 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262904AbVG2Wlv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 18:41:51 -0400
Received: (qmail 1671 invoked by uid 2001); 29 Jul 2005 22:41:48 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 16, 2005 at 07:46:00PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I do not know what release plan Linus has in mind, and also
> expect things to be quieter next week during OLS and kernel
> summit, but I think we are getting really really close.
> 
> Here are the things I think we would want to see before we hit
> 1.0:
> 
>  - Remaining feature enhancements and fixes.
> 
>    - Anonymous pull from packed archives on remote sites via
>      non-rsync, non-ssh transport.  Many people are behind
>      corporate firewalls that do not pass anything but outgoing
>      http(s) and some do not even pass outgoing ssh.  The recent
>      addition of git-daemon by Linus would greatly alleviate the
>      situation, but we may also end up wanting something HTTP
>      reachable.

I hope to get to it tomorrow but it now occurred to me that I don't know
when do you actually want to release 1.0 and I think it's crucial for it
to support some sensible HTTP transport - I saw some scripts going in
etc, but what's its current state? Is it usable?

Note that I really _loved_ the Daniel's tools while they lasted. What I
loved most about them was that they really only pulled objects I needed
and not a single worthless one. Does the current HTTP transport share
this property?

>  - Publicity.  I would be very happy to see somebody with good
>    writing and summarizing skills to prepare an article to be
>    published on LWN.NET to coincide with the 1.0 release.  An
>    update to GIT traffic would also be nice.

Note that I also want to setup a simple "proof-of-concept" GIT homepage
tomorrow. Well, write it, where it should be hosted can be worked out
later and I have places for it to reside at for now. (Suggestions for
final hosting welcome. In reality, how nice (and persistent) the URL
gets is probably the only thing that really matters. My attempt will
live at http://git.or.cz/.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
