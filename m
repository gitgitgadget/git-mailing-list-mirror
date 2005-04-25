From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: unseeking?
Date: Mon, 25 Apr 2005 15:28:33 -0700
Message-ID: <20050425222833.GA21107@tumblerings.org>
References: <20050425161854.GE11094@tumblerings.org> <Pine.LNX.4.21.0504251236400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 00:26:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQC24-0001xJ-RM
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDYWbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDYWbR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:31:17 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:13796 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261263AbVDYWaL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 18:30:11 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DQC49-0006ae-QS; Mon, 25 Apr 2005 15:28:33 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504251236400.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 25, 2005 at 01:27:16PM -0400, Daniel Barkalow wrote:
> On Mon, 25 Apr 2005, Zack Brown wrote:
> > So moving on, I now have this mycogito tree. But I don't do any edits yet. I
> > just poke around for awhile, reading files. Finally I realize that there have
> > probably been updates to the upstream sources, and I want to pull those in
> > before I start my work. So, as I would do in the cogito directory, I give the
> > command
> > 
> > git pull pasky; git pull linus
> > 
> > this works fine. There are no new updates to be had, and git tells me my tree is
> > uptodate.
> > 
> > so now I start work. I run aspell on the README file, and it catches some
> > typos.  I fix them and save the file but don't yet commit it. Now mycogito
> > has some changes that I would ultimately like to push up to Pasky.
> > 
> > Now I'm unclear what comes next. Do I just do a 'git diff' from the mycogito
> > directory and post the results to the git list?
> 
> Now you commit in your directory. This gives you a new head for
> mycogito. You can then do "git patch pasky" (or something of the sort,
> check the help for the details)

OK, so it's actually:

git patch pasky:this

> to get a patch for the your changes. You
> can also do multiple commits and generate either a single patch or patches
> corresponding to each commit.

By replacing 'this' or 'pasky' in the above command with the appropriate
7de71a831508e51e0985cea173f3f7a7012c82b7 thingy, right?

So, I did 'git patch pasky:this', and got the following. Is this an appropriate
way to submit a patch? BTW, the 'truckload' fix I tried to change back by
editing the README again, and committing the change; but the git patch command
still shows the change.


spelling fixes

---
commit 8626d99da60a0cbb8e901df2da0f503959517bb8
tree a1c075cf00f03843de7200c2c341f1aeeb260a7f
parent 0d38182b234f5bb89e53ec31951e8d5d0ebdf69a
author <zbrown@tumblerings.org> 1114466199 -0700
committer <zbrown@tumblerings.org> 1114466199 -0700

Index: README
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/README  (mode:100644 sha1:bc52eb0f2e4fe17157635dca34a5073944153c15)
+++ a1c075cf00f03843de7200c2c341f1aeeb260a7f/README  (mode:100644 sha1:140eefe0b740b2e7f4ee1644ec18f23855dc1af4)
@@ -9,7 +9,7 @@
    dictionary of slang.
  - "global information tracker": you're in a good mood, and it actually
    works for you. Angels sing, and a light suddenly fills the room. 
- - "goddamn idiotic truckload of sh*t": when it breaks
+ - "goddamn idiotic truck-load of sh*t": when it breaks
 
 GIT comes in two layers. The bottom layer is merely an extremely fast and
 flexible filesystem-based database designed to store directory trees with
@@ -245,7 +245,7 @@
 	In particular, since the blob is entirely defined by its data,
 	if two files in a directory tree (or in multiple different
 	versions of the repository) have the same contents, they will
-	share the same blob object. The object is toally independent
+	share the same blob object. The object is totally independent
 	of it's location in the directory tree, and renaming a file does
 	not change the object that file is associated with in any way.
 
@@ -300,7 +300,7 @@
 	actually have any relationship with the result, for example. 
 
 	Note on changesets: unlike real SCM's, changesets do not contain
-	rename information or file mode chane information.  All of that
+	rename information or file mode change information.  All of that
 	is implicit in the trees involved (the result tree, and the
 	result trees of the parents), and describing that makes no sense
 	in this idiotic file manager. 
@@ -468,7 +468,7 @@
 	changes in your working directory (ie "update-cache").
 
 	However, if you decide to jump to a new version, or check out
-	somebody elses version, or just restore a previous tree, you'd
+	somebody else's version, or just restore a previous tree, you'd
 	populate your index file with read-tree, and then you need to
 	check out the result with
 



!-------------------------------------------------------------flip-


undid a bogus fix

---
commit a2e1bea63e3ed44321f560b892660ea4613f74f6
tree c28936b6a10b436f7b6027e396bf340e54ecb48c
parent 8626d99da60a0cbb8e901df2da0f503959517bb8
author <zbrown@tumblerings.org> 1114467935 -0700
committer <zbrown@tumblerings.org> 1114467935 -0700

Index: README
===================================================================
--- a1c075cf00f03843de7200c2c341f1aeeb260a7f/README  (mode:100644 sha1:140eefe0b740b2e7f4ee1644ec18f23855dc1af4)
+++ c28936b6a10b436f7b6027e396bf340e54ecb48c/README  (mode:100644 sha1:0c1630a83614acb3a2e577da64797c1512bf0cf3)
@@ -9,7 +9,7 @@
    dictionary of slang.
  - "global information tracker": you're in a good mood, and it actually
    works for you. Angels sing, and a light suddenly fills the room. 
- - "goddamn idiotic truck-load of sh*t": when it breaks
+ - "goddamn idiotic truckload of sh*t": when it breaks
 
 GIT comes in two layers. The bottom layer is merely an extremely fast and
 flexible filesystem-based database designed to store directory trees with



!-------------------------------------------------------------flip-




> 
> > Suppose I want to keep working, changing more stuff in mycogito, but I
> > also want to make sure that mycogito tracks the upstream sources.
> > 
> > git merge pasky; git merge linus
> > 
> > and give that command to bring the upstream changes into mycogito?
> 
> In general, you want to use "merge" when you've got local commits. You
> also want to commit before doing this, so that you have a known state
> for your version to revert to if you mess up merging.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 

-- 
Zack Brown
