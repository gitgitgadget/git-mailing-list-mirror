From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FILE] Docs update
Date: Sun, 24 Apr 2005 21:34:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504242112190.30848-100000@iabervon.org>
References: <426BF790.9070406@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 03:30:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsQV-0004dp-9P
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVDYBfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVDYBfH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:35:07 -0400
Received: from iabervon.org ([66.92.72.58]:38919 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262425AbVDYBe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 21:34:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPsUw-0004KT-00; Sun, 24 Apr 2005 21:34:54 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <426BF790.9070406@dgreaves.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current merge-base finds the common ancestor with the most recent
date. The old algorithm was giving some surprising results, where it
didn't always take advantage of a straight line from one side to the
other. At some point, I'm going to try to have it find the ancestor with
the shortest shorter path, which I think should work best of all.

In any case, I think your documentation should just say it finds as good a
common ancestor as possible, since that's what it's really for, regardless
of the details of how it decides. Also, it shouldn't be depended on to
decide in any particular way.

	-Daniel
*This .sig left intentionally blank*

