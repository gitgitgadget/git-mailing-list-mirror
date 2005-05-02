From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 22:31:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505012205590.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 04:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSQfw-0004DW-Ny
	for gcvg-git@gmane.org; Mon, 02 May 2005 04:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVEBCea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 22:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVEBCcX
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 22:32:23 -0400
Received: from iabervon.org ([66.92.72.58]:59654 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261988AbVEBCbn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 22:31:43 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSQib-0004X7-00; Sun, 1 May 2005 22:31:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005, Linus Torvalds wrote:

> That said, I end up still using the raw plumbing, so it's actually nice to 
> have some simple shorthand. I just don't know if the parent thing ends up 
> being all that useful.

I still prefer having get_sha1() handle just hex, refs, and files in
.git. Actually, just having it handle hex would probably be sufficient,
since the Porcelain can patch it cleanly with whatever is locally useful.

Any thoughts on my patches, which actually barely overlap with this
functionality?

	-Daniel
*This .sig left intentionally blank*

