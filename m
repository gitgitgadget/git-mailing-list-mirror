From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Tue, 27 Sep 2005 12:13:06 +0200
Message-ID: <20050927101306.GC30889@pasky.or.cz>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net> <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net> <1127765852.5735.36.camel@cashmere.sps.mot.com> <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 12:14:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKCSo-0001Xa-Co
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 12:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVI0KNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 06:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVI0KNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 06:13:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6112 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964884AbVI0KNI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 06:13:08 -0400
Received: (qmail 5634 invoked by uid 2001); 27 Sep 2005 12:13:06 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9387>

Dear diary, on Tue, Sep 27, 2005 at 12:03:47AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>  - if the merge is not to happen in the current branch, then
>    use a temporary index file and a temporary working directory
>    to do the merge -- when manual conflict resolution is needed,
>    ask the user to go to that temporary working directory and
>    resolve conflicts there and make commits there.  The
>    temporary working directory is actually cheap because we do
>    not have to checkout all the paths -- only the paths involved
>    in the merge.

By the way, this is how Cogito did merging for some (rather short) time
period (actually, there's perhaps still some remnant of this, I think
Cogito still by default ignores ,,merge* which was the subdirectory
where the merge happenned). I removed it because IIRC the people weren't
eventually all that excited about it after all and Linus changed his
mind too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
