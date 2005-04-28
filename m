From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: : Networking
Date: Thu, 28 Apr 2005 00:43:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280031110.30848-100000@iabervon.org>
References: <20050428035534.GB30308@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bram Cohen <bram@bitconjurer.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, pasky@ucw.cz,
	davem@davemloft.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR0nZ-0005Xg-I5
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVD1EoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 00:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVD1EoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 00:44:09 -0400
Received: from iabervon.org ([66.92.72.58]:30724 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261937AbVD1EoE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 00:44:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR0sY-0000f9-00; Thu, 28 Apr 2005 00:43:58 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050428035534.GB30308@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Ryan Anderson wrote:

> Now, all that history I had, with the duplicated imlementation, and
> useless code is in my tree.
> 
> The current (as I understand it) policy is, "We don't want that
> history."  This means that the developer will build a new tree (maybe),
> export his patch and reimport it into a clean tree, making a much
> simpler history graph.

I've been doing just this. I actually import it in pieces, with a commit
between each, so it's just like I applied the patch series I'm about to
send out. It actually works beautifully, and, someday, I'll have the
series up on my site so that a maintainer can just pull it.

Honestly, I'm not interested long-term in my buggy history, even
locally; I'm interested in the clean history in which I make a series of
self-contained, logical modifications and they get merged upstream.

> What Andrew is doing isn't too far from this, in concept, it's just a
> lot more complicated because he's pulling something insane, like 27
> seperate trees, plus several hundred stand alone patches.
> 
> So, there's a *deliberate* desire to drop history and move some content
> around outside of version control.

I think it's more a desire to drop history as it actually happened, and
replace it with history as it should have happened. The one thing I would
like is the ability to provide merging help to poor souls who got part of
the messy history without preserving that history. I think having the head
of the clean series have a bunch of lines: "replaces <sha1>", where people
aren't supposed to have or want that commit, but if they've merged it,
they should know that the clean series includes its content.

	-Daniel
*This .sig left intentionally blank*

