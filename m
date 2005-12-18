From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to clone-pack the HEAD?
Date: Sun, 18 Dec 2005 01:38:03 +0100
Message-ID: <20051218003803.GT22159@pasky.or.cz>
References: <20051215004440.GM22159@pasky.or.cz> <7vfyovtaub.fsf@assigned-by-dhcp.cox.net> <20051215013201.GD10680@pasky.or.cz> <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net> <7vlkynrurh.fsf@assigned-by-dhcp.cox.net> <7vpsnzq66x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 01:43:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnmZC-0007PE-9X
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 01:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVLRAiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 19:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLRAiG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 19:38:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15565 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965040AbVLRAiF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 19:38:05 -0500
Received: (qmail 9724 invoked by uid 2001); 18 Dec 2005 01:38:03 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsnzq66x.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13782>

Dear diary, on Thu, Dec 15, 2005 at 06:29:10AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Not really.  I take this back.  What you want to do I did not
> > understand well enough.
> >
> > HEAD is kinda special.  A hack I can think of is to do ls-remote
> > first and do the guess clone-pack does for full clone case, and
> > then give a specific branch name to clone.  That might work.
> 
> ... and another way would be to do this; I'll put this (with
> fixes if there is some needed) in "master" tonight.

Thanks! This makes it work very nicely and exactly the way I want, even
giving git-fetch-pack-compatible output so I can seamlessly switch
between the two commands. Very nice!

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
