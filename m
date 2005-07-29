From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 11:40:46 +0200
Message-ID: <20050729094046.GO24895@pasky.ji.cz>
References: <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net> <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 11:43:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyRNd-0001Jy-IN
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 11:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVG2Jlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 05:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVG2Jlj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:41:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25613 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261911AbVG2Jkt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 05:40:49 -0400
Received: (qmail 13868 invoked by uid 2001); 29 Jul 2005 09:40:46 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 10:54:07AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I however still suspect that you might be spreading chaos under the
> name of more flexibility.

I'm such a villain! ;-))

> The fact that you can push into it by definition means you have some
> control over the other end, and obviously you are in total control on
> your end.  I do not see why you cannot rename branches where needed so
> that whatever you are pushing match.  That would also be one less
> thing to keep track of for yourself [*1*].

You might get the push access rather lately in the process (this "lazy
development privileges granting" is one of the point of distributed
VCSes), at point where other people are used to pull from you and
renaming your branch locally might mean some trouble.

> Yes, I am aware that you brought up the example of pushing to
> two separate places, but does it happen in practice that you can
> push to two places, and at the same time neither of them
> cooperates with you to make it easier for you to work on these
> three machines by having the same head names?

Yes, they may have incompatible but strict head naming conventions. And
wouldn't it be easier to just have different head names rather than
forcing to increase administrative load 'n stuff?

> [Footnote]
> 
> *1* In a hypothetical situation ``I use branch "b00" in this
> repository to do XYZ work but I use branch "b24" in the other
> repository for the same XYZ work'', Porcelain can keep track of
> mapping between b00:b24 for you, but you still need to keep
> track of b00:XYZ and b24:XYZ mapping in your head.

I think 95% of the cases will be "master locally, non-master remotely".
That's not really that difficult at all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
