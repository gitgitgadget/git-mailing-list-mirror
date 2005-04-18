From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] General object parsing
Date: Sun, 17 Apr 2005 22:15:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172206460.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504171807590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:12:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLjx-0000IH-S9
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDRCPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVDRCPr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:15:47 -0400
Received: from iabervon.org ([66.92.72.58]:8198 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261603AbVDRCPk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:15:40 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNLnn-0004Rl-00; Sun, 17 Apr 2005 22:15:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171807590.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Daniel Barkalow wrote:
> > 
> > Any comment on the design, or should I send my implementation?
> 
> Show the patches, and maybe I (and others) can make comments on the 
> thing.. It doesn't sound broken by design, the only question is how much 
> harder (if any) it is to use than the rather trivial "revision.h" which 
> gets us really small files.

I don't think it's much different in difficulty, plus it handles more
(parsing the objects more completely). They'll follow.

> In particular, is there some easy way to walk backwards by time? "git log"  
> definitely needs that, and merge-base clearly wants something similar. I
> also pretty much guarantee that visualization tools want that - creating a
> visual representation of the dag by time.

I think that should be easy, although I haven't written code to do it. If
you output the whole history, sorted by date, you obviously need to get 
the whole history, but I expect people will have some sort of pruning to
keep it down to a size they care about.

> But if there are simple helper functions to get the "next backwards in 
> time" case (by looking at the parent dates in a merge), then that should 
> be ok to do incrementally.

Haven't written that yet, but I can do so.

	-Daniel
*This .sig left intentionally blank*

