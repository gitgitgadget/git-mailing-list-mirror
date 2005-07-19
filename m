From: Petr Baudis <pasky@suse.cz>
Subject: Re: Is cogito really this inefficient
Date: Wed, 20 Jul 2005 01:54:52 +0200
Message-ID: <20050719235452.GE2255@pasky.ji.cz>
References: <20050713135052.C6791@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507140813150.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 01:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv1vQ-00075W-Oj
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 01:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGSXyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 19:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGSXyz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 19:54:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12293 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261421AbVGSXyy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 19:54:54 -0400
Received: (qmail 7839 invoked by uid 2001); 19 Jul 2005 23:54:52 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507140813150.19183@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 14, 2005 at 05:26:07PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> It's quite possible that some path in cg-update ends up not updating the 
> index properly. For example, I notice that the "fast-forward" uses 
> "git-checkout-cache -f -a", which can do so (lack of "-u" fila), but then 
> it does do a "git-update-cache --refresh" later, so that doesn't seem to 
> be it either.

Just a side note for casual readers, Cogito could use a cleanup here -
from large part it ignores things like git-checkout-cache -u simply
because there was no such option at the time that part of Cogito was
written. I myself am not even too familiar about those gazillions of
funny new options, and as long as it works, I prefer not to touch that
code, but if someone is bored and wants to get familiar with core git
usage as well as Cogito internals...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
