From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull fails
Date: Wed, 29 Mar 2006 02:57:00 +0200
Message-ID: <20060329005700.GC27631@pasky.or.cz>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com> <20060328141140.GC3113@linux-mips.org> <20060328173827.3d64d91e.tihirvon@gmail.com> <200603281700.17233.astralstorm@o2.pl> <20060328224807.GC27689@pasky.or.cz> <20060329031136.e0389c00.tihirvon@gmail.com> <20060329002415.GG27689@pasky.or.cz> <7vu09igk1t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:57:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOza-0004Mu-Fx
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWC2A44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWC2A4z
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:56:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:31681 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750730AbWC2A4z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 19:56:55 -0500
Received: (qmail 11708 invoked by uid 2001); 29 Mar 2006 02:57:00 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu09igk1t.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18152>

Dear diary, on Wed, Mar 29, 2006 at 02:40:30AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > If your current branch would really be a remote branch and you simply
> > git-fetched, your HEAD would change but not your working tree, and at
> > that moment things would become very confusing. Cogito would start
> > showing nonsensical stuff for cg-status and cg-diff (as well as
> > git-diff-tree HEAD output), but your index would at least still be
> > correct so I'm not sure how much attention do tools like git-diff pay to
> > it, the level of messup would be proportional to that.
> 
> People want to leave tracking branches checked out, especially
> when they are not developers but are "update to the latest and
> compile the bleeding edge" types.  Support for that mode of
> operation was invented long time ago and git-pull knows about
> it, and the idea was ported to git-cvsimport recently.

Why can't such people just have two branches, _especially_ if they are
the "update to the latest and compile the bleeding edge" types?
(Therefore well not likely to be familiar with the Git branching model
at all.)

I mean, sure, it's Core Git so the extra flexibility is nice. But I now
wonder, can you think of any plausible workflow where having one branch
instead of two would be an advantage?

Waah, cg-log git-fetch.sh, /update-head just showed me the change in
git-fetch-script from last August, with no extra work for me. The big
rename barrier annoyances finally gone forever!

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
