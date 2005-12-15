From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.16.2
Date: Thu, 15 Dec 2005 09:56:40 +0100
Message-ID: <20051215085640.GP22159@pasky.or.cz>
References: <20051214231019.GK22159@pasky.or.cz> <200512150657.53622.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 09:58:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emouz-0008Ij-ER
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 09:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVLOI4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 03:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVLOI4m
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 03:56:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:26533 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965181AbVLOI4m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 03:56:42 -0500
Received: (qmail 10592 invoked by uid 2001); 15 Dec 2005 09:56:40 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200512150657.53622.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13689>

Dear diary, on Thu, Dec 15, 2005 at 07:57:52AM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> On Wednesday 14 December 2005 23:10, Petr Baudis wrote:
> ...
> >   Also, Cogito is now very ineffective when cloning big-packed
> > repositories over the git protocol or over ssh, since git-fetch-pack
> > unpacks the objects on the local side, which bogs things down a lot and
> > makes the repository grow into enormous proportions - I'm not yet sure
> > if I will backport the fix to 0.16 since I want to be maximally careful
> > not to gravely break anything again and keep 0.16 as stable as possible.
> > (Hm. Call this "the Debian dilemma". ;-)
> 
> Note sure what your Debian dilemma is.

Well, I meant this in a general sense - in the stable Debian branch,
there's also this dilemma about how grave bugfixes to still merge,
without risking another bug induced by those.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
