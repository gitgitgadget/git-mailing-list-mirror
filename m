From: Petr Baudis <pasky@suse.cz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 09:54:31 +0200
Message-ID: <20051024075431.GY30889@pasky.or.cz>
References: <4352F4C9.1040703@catalyst.net.nz> <20051021005145.GB30889@pasky.or.cz> <200510202137.22311.dtor_core@ameritech.net> <4358597A.6000306@catalyst.net.nz> <7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 09:56:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETxAC-0001Vp-Jk
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJXHye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 03:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVJXHye
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 03:54:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28039 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750770AbVJXHyd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 03:54:33 -0400
Received: (qmail 24864 invoked by uid 2001); 24 Oct 2005 09:54:31 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10534>

Dear diary, on Mon, Oct 24, 2005 at 03:35:43AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Oh, the git merge is about a million times better than any silly weave 
> merge with extra BonusPoints and MagicCapitalizedNames.
> 
> Why? Because if you want to be slow and careful, you can always just 
> create the weave after-the-fact and do a weave merge.

This doesn't make sense. Those silly weave merges only describe what to
do with the weave to do the merge, not how you got the weave in the
first place.

> So we should spend time on making it easy to see what the clash was, and 
> on tools to help resolve them. Some random merge-strategy-of-the-day is 
> just bling-bling. 

The *primary* reason for new merge strategies is not reducing number
of conflicts, but actually being able to force a conflict at places
where it isn't crystal-clear what the resolution should be (but not
conflicting where it should be clear), and especially at places where
the three-way merge *silently* gets it *wrong* without throwing any
conflicts. And weren't it you who wanted a conservative merge strategy
which wouldn't ever do that?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
