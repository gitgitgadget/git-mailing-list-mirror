From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: unseeking?
Date: Tue, 26 Apr 2005 14:48:19 -0700
Message-ID: <20050426214819.GA14899@tumblerings.org>
References: <20050425161854.GE11094@tumblerings.org> <Pine.LNX.4.21.0504251236400.30848-100000@iabervon.org> <20050425222833.GA21107@tumblerings.org> <20050426202805.GL13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:46:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXsC-000669-28
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVDZVuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVDZVuR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:50:17 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:32902 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261808AbVDZVuF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 17:50:05 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DQXul-0003sk-Bz; Tue, 26 Apr 2005 14:48:19 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050426202805.GL13224@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 10:28:05PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 26, 2005 at 12:28:33AM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > So, I did 'git patch pasky:this', and got the following. Is this an appropriate
> > way to submit a patch? BTW, the 'truckload' fix I tried to change back by
> > editing the README again, and committing the change; but the git patch command
> > still shows the change.
> 
> Because it just exports individual patches. Use git diff (cg-diff) if
> you want to get the cummulative diff.
> 
> Could you please sign off your patch?

Spelling fixes.

Signed-off-by: Zack Brown <zbrown@tumblerings.org>

Index: README
===================================================================
--- 6159f313b10f0cfcdfedd63d6fb044029fe46aaa/README  (mode:100644
sha1:ae3c78a0f1927b9d92d788a0cd0b75d5fc3fc338)
+++ dbfe56b949992411184480136defe850a9f135cd/README  (mode:100644
sha1:bbf1920e29cc74dccec1271d57628244c87c6fb8)
@@ -233,7 +233,7 @@
        In particular, since the blob is entirely defined by its data,
        if two files in a directory tree (or in multiple different
        versions of the repository) have the same contents, they will
-       share the same blob object. The object is toally independent
+       share the same blob object. The object is totally independent
        of it's location in the directory tree, and renaming a file does
        not change the object that file is associated with in any way.
 
@@ -288,7 +288,7 @@
        actually have any relationship with the result, for example. 
 
        Note on changesets: unlike real SCM's, changesets do not contain
-       rename information or file mode chane information.  All of that
+       rename information or file mode change information.  All of that
        is implicit in the trees involved (the result tree, and the
        result trees of the parents), and describing that makes no sense
        in this idiotic file manager. 
@@ -456,7 +456,7 @@
        changes in your working directory (ie "update-cache").
 
        However, if you decide to jump to a new version, or check out
-       somebody elses version, or just restore a previous tree, you'd
+       somebody else's version, or just restore a previous tree, you'd
        populate your index file with read-tree, and then you need to
        check out the result with

-- 
Zack Brown
