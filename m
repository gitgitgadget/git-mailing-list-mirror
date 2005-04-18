From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] General object parsing
Date: Sun, 17 Apr 2005 23:51:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172337380.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172206460.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 05:47:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNNEm-0006rk-Kq
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 05:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDRDvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 23:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVDRDvk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 23:51:40 -0400
Received: from iabervon.org ([66.92.72.58]:6663 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261636AbVDRDvj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 23:51:39 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNNIa-0007i0-00; Sun, 17 Apr 2005 23:51:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172206460.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Daniel Barkalow wrote:

> > But if there are simple helper functions to get the "next backwards in 
> > time" case (by looking at the parent dates in a merge), then that should 
> > be ok to do incrementally.
> 
> Haven't written that yet, but I can do so.

Okay, I wrote this. I now have a merge-base that will find the most recent
ancestor while never looking at any parents of any commit older than the
answer. (But I'll let the previous stuff get reviewed first)

	-Daniel
*This .sig left intentionally blank*

