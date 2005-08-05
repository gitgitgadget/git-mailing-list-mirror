From: barkalow@iabervon.org
Subject: Re: Terminology
Date: Fri, 5 Aug 2005 15:53:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508051531400.23721@iabervon.org>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 21:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E18D7-0003kH-Uw
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 21:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVHETuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVHETuS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 15:50:18 -0400
Received: from iabervon.org ([66.92.72.58]:43536 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262823AbVHETuP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 15:50:15 -0400
Received: (qmail 24644 invoked by uid 1000); 5 Aug 2005 15:53:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2005 15:53:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508051104510.3258@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Aug 2005, Linus Torvalds wrote:

> On Fri, 5 Aug 2005, Johannes Schindelin wrote:
> 
> >   - The files under $GIT_DIR/refs record object names, and are
> >     called "refs".  What is under refs/heads/ are called "heads",
> >     refs/tags/ "tags".  Typically, they are either object names
> >     of commit objects or tag objects that resolve to commit
> >     objects, but a tag can point at any object.
> > 
> > The tutorial never calls them "refs", but instead "references".
> 
> It might be worth saying explicitly that a reference is nothing but the 
> same thing as a "object name" aka "sha1".

Well, it's an object name stored in a file. This adds a layer of 
indirection and a meaningful name.

> So I'd vote for making the suggested definition official: "fetch" means
> fetching the data, and "pull" means "fetch + merge". 

So what's the converse of "fetch" (to rename git-ssh-push to)? 
Maybe "ship"?

	-Daniel
*This .sig left intentionally blank*
