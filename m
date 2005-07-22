From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 01:50:36 +0200
Message-ID: <20050722235035.GR11916@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722204120.GD11916@pasky.ji.cz> <7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net> <20050722212725.GJ11916@pasky.ji.cz> <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:50:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7I4-0005XT-SI
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVGVXun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVGVXun
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:50:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26378 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262241AbVGVXuj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:50:39 -0400
Received: (qmail 24899 invoked by uid 2001); 22 Jul 2005 23:50:36 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 01:24:35AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Cogito shows '[NMD] filename' in place of @FILELIST@.
> 
> Sounds sensible.  Does it parse it to limit the files to be
> committed?

Yes.

> > This brings me to another subject, M and N are pretty hard to
> > distinguish visually without close inspection of the output. What about
> > switching to use A instead of N everywhere?
> 
> Although I admit that is minor, I've had the same problem, and
> this sounds like a good idea.
> 
> However, I'd like to see what the extent of damage would be even
> if everybody agrees this is a good change.  Any one of core
> barebone Porcelain, Linus git-tools, gitk, gitweb, Cogito, and
> StGIT would have a veto over this kind of change, or at least we
> should wait until everybody catches up.

I don't think the situation is so bad. At least in Cogito, there is only
one use of 'N' (and cg-status, but that goes directly to the user), and
it's likely useless and things would work even with that changing to 'A'
(nevertheless, I just updated Cogito to accept 'A' at that place as
well).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
