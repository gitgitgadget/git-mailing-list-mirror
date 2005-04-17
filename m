From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [0/5] Patch set for various things
Date: Sun, 17 Apr 2005 11:20:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
References: <20050417144947.GG1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:16:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBVc-0002q1-Gj
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDQPUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDQPUO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:20:14 -0400
Received: from iabervon.org ([66.92.72.58]:54535 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261328AbVDQPUI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:20:08 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBZT-00063Z-00; Sun, 17 Apr 2005 11:20:27 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417144947.GG1487@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here are a bunch of patches which I made first against linus, that I've
rebased against pasky because they're mostly more version-control-like.

 1: Add a parsing function to revision.h
 2: Add merge-base
 3: Add http-pull
 4: Add option to make a hardlinkable cache of extracted options
 5: Add commit id to version info

This also served as a test of cleaning up a patch series with git; I took
my current working directory, diffed it against its common ancestor with
pasky (no longer current), split the patch into logical pieces, and 
applied them in sequence against the current pasky, committing after each
one. This gives a history as if I'd actually written the code just like I
would have had I known what I was doing in advance and done it very
quickly this morning. I think this should work in the future as a way to
avoid having the global revision control keeping developers' local 
mistakes while keeping history the way the mainline saw the development.

A thought for future work: it would be nice if I could identify commits
that were used in creating a commit, but which should not be tracked down
unless you were unfortunate enough to have been exposed to them (in which
case you'd like know to deal with them).

	-Daniel
*This .sig left intentionally blank*

