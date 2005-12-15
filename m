From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to clone-pack the HEAD?
Date: Thu, 15 Dec 2005 02:59:44 +0100
Message-ID: <20051215015944.GE10680@pasky.or.cz>
References: <20051215004440.GM22159@pasky.or.cz> <7vfyovtaub.fsf@assigned-by-dhcp.cox.net> <20051215013201.GD10680@pasky.or.cz> <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 03:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmiPN-0003Ix-NT
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVLOB7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVLOB7q
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:59:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:31941 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751110AbVLOB7q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 20:59:46 -0500
Received: (qmail 19322 invoked by uid 2001); 15 Dec 2005 02:59:44 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13674>

Dear diary, on Thu, Dec 15, 2005 at 02:45:32AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Except that I cannot do the guessing git-clone-pack does (without
> > fetching all the branches)
> 
> Exactly my point.  If you are not getting all the branches, you
> are not cloning but doing something else.

Ah, play with the words. Sure I'm cloning - however I'm not cloning
a repository but a branch. In Cogito world, that's the only thing that
makes sense to clone, in GIT world it's more complicated (you don't
always clone the whole repository there either, since git-clone-pack
lets you narrow down the refs).

> Extending git-fetch-pack would be the right approach if that is
> what you are trying to do.

I'll then try to extend git-fetch-pack instead. I'll send some fix for
git-clone-pack anyway, though. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
