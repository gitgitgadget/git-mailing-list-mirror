From: Paul Mackerras <paulus@samba.org>
Subject: Re: Make "gitk" work better with dense revlists
Date: Thu, 27 Oct 2005 16:16:25 +1000
Message-ID: <17248.28857.90315.543669@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0510251253110.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 08:17:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV14T-0000Mu-HT
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 08:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVJ0GQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 02:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVJ0GQc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 02:16:32 -0400
Received: from ozlabs.org ([203.10.76.45]:20653 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932176AbVJ0GQb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 02:16:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 016D168595; Thu, 27 Oct 2005 16:16:29 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510251253110.10477@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10698>

Linus Torvalds writes:

> So this makes gitk just show the diff of _that_ commit.

Committed and pushed out, but ...

> Also, having now tested the previous "handle root commit in the 
> TREECHANGED" logic a bit more, I think it's (a) stable and (b) the right 
> thing to do. Sign me off on that one too.

What is that about?

I'm hoping to get back to gitk hacking RSN - I've been going flat out
on the ppc32/ppc64 merge.  Thanks for doing the --dense thing; I was
thinking about doing something like that inside gitk but doing it in
git-rev-list is better.  It does mean that I now want to be able to
get gitk to contract the view to just a given set of files or
directories and then expand back to the whole tree view, which means
running git-rev-list multiple times, which gitk can't do at the
moment...

Paul.
