From: Petr Baudis <pasky@suse.cz>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Tue, 27 Sep 2005 11:51:42 +0200
Message-ID: <20050927095142.GB30889@pasky.or.cz>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net> <87psqwzs3x.fsf@ualberta.net> <7v7jd4n22i.fsf@assigned-by-dhcp.cox.net> <1127765852.5735.36.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:52:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKC8G-0000yK-6u
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 11:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVI0Jvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 05:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVI0Jvp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 05:51:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63168 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964879AbVI0Jvp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 05:51:45 -0400
Received: (qmail 3811 invoked by uid 2001); 27 Sep 2005 11:51:42 +0200
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1127765852.5735.36.camel@cashmere.sps.mot.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9384>

Dear diary, on Mon, Sep 26, 2005 at 10:17:32PM CEST, I got a letter
where Jon Loeliger <jdl@freescale.com> told me that...
> Hmmm...  Would it make sense to introduce something
> like this instead:
> 
>     # When fetching, get bits from here:
>     URL: http://...../git.git
>     # When fetching, grab and map like this:
>     Fetch: master:origin maint:maint +pu:pu
>     # When merging, merge origin, maint and pu into master
>     Merge: master origin maint pu
> 
> With the intent that the "Fetch:" line effectively
> limits the fetching operation to git-fetch, and doesn't
> specify how to merge.  Then, the "Merge:" line specifies
> how to do the git-merge bits.  If you didn't want to
> merge in the maint and pu bits, this would have been
> the line instead:
> 
>     # Merge into master the just the origin bits
>     Merge: master origin
> 
> If you want the dual-step fetch+merge, the leave the "Pull:"
> line as originally written:
> 
>     # Fetch and merge
>     Pull: master:origin maint:maint +pu:pu
> 
> Syntax can be argued, of course.  My point being to
> introduce another line to the remote file that
> distinguishes the default behavior for each step
> along the way.

Yes, this is basically the idea behind my "Default" line, but arguably
nicer and more flexible. I fully agree with Junio that pulling should
merge to your current branch, but I like your idea otherwise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
