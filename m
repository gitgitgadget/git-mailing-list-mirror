From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] diff: --abbrev option
Date: Sun, 18 Dec 2005 12:45:22 +0100
Message-ID: <20051218114522.GW22159@pasky.or.cz>
References: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net> <20051218001756.GS22159@pasky.or.cz> <7vek4byuwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 12:46:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnwzL-0003oZ-CS
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 12:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVLRLpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 06:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVLRLpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 06:45:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59324 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932448AbVLRLpY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 06:45:24 -0500
Received: (qmail 11845 invoked by uid 2001); 18 Dec 2005 12:45:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek4byuwg.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13792>

Dear diary, on Sun, Dec 18, 2005 at 03:57:19AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   I was actually thinking to by default trim all the hashes Cogito show
> > to 12 or 16 characters. Seven still seems dangerously low to me, though;
> > it would be nice if the number of characters to trim would be
> > configurable (unless I've missed that).
> 
> Well, I did better than you imagined this time, for a change ;-)
> It trims and adds extra as needed without breaking alignments,
> so you could get something like this:
> 
> >       :100755 100755 0266f46... b0e54ed... M	git-branch.sh
> >       :100755 100755 f241d4b9.. 36308d2ab. M	git-checkout.sh
> 
> That is, ... is not just distraction but are part of the
> design.  Cut and paste is a byproduct.

Ok, that's nice! :-) And if I'm going to machine-process this later,
I can just trim the trailing dots anyway. And it seems that I can give
--abbrev a number argument to specify the minimal abbreviation, even
cooler! :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
