From: Paul Mackerras <paulus@samba.org>
Subject: Re: Joining cg-*-id
Date: Wed, 21 Sep 2005 20:35:05 +1000
Message-ID: <17201.14169.150101.991868@cargo.ozlabs.ibm.com>
References: <1127166049.26772.26.camel@dv>
	<20050919215608.GA13845@pasky.or.cz>
	<Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
	<20050919225422.GG18320@pasky.or.cz>
	<Pine.LNX.4.58.0509191746130.2553@g5.osdl.org>
	<20050920135735.GC1884@pasky.or.cz>
	<Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
	<20050920150719.GB1836@pasky.or.cz>
	<Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
	<Pine.LNX.4.58.0509201224360.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>, fonseca@diku.dk,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 12:38:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI1xp-0002Ly-IM
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIUKfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIUKfF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:35:05 -0400
Received: from ozlabs.org ([203.10.76.45]:18356 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750777AbVIUKfE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 06:35:04 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4CFF768384; Wed, 21 Sep 2005 20:35:02 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509201224360.2553@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9040>

Linus Torvalds writes:

> On Tue, 20 Sep 2005, Linus Torvalds wrote:
> > 
> > (Side note: the "gitk" thing works really badly. gitk doesn't quote its 
> > arguments to "git-rev-list", so something like
> > 
> > 	gitk --since="1 month ago"
> > 
> > does NOT work, while "--since=yesterday" does, because it has no spaces. 
> > Gaah. "Obi-Paul Mackerras, you're our only hope")

<scratches head> It works for me - with your rev-list.c and
rev-parse.c patches, an unmodified gitk (as in current git.git) works
just fine; both gitk --since=yesterday and gitk --since="1 day ago"
give the same set of commits (two merges and an NTFS change, plus
"Linux v2.6.14-rc2" and a SCSI zfcp patch shown with open circles).

> There is 'eval' magic with pure lists. I'm getting convinced that tcl is 
> evil after all - that's just _confusing_. A real language shouldn't have 
> semantic differences from this change, but it clearly does.

I can't see any semantic difference...

Can you still replicate the problem with an unmodified gitk?

Paul.
