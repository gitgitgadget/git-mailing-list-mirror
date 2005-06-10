From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: [PATCH] cvs-migration.txt
Date: Fri, 10 Jun 2005 01:33:44 -0500
Message-ID: <20050610063344.GB4763@immutable.crsr.net>
References: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org> <20050610062206.GA3992@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:29:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgd1W-0000yE-I1
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 08:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVFJGd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 02:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFJGd5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 02:33:57 -0400
Received: from [65.98.21.155] ([65.98.21.155]:64781 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S262497AbVFJGdx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 02:33:53 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Dgd5M-0001K0-00; Fri, 10 Jun 2005 01:33:44 -0500
To: "Tommy M. McGuire" <mcguire@crsr.net>
Content-Disposition: inline
In-Reply-To: <20050610062206.GA3992@immutable.crsr.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The way I figure it, telling someone why cvsimport is taking so long
will improve their overall user experience.  :-)

Signed-off-by: Tommy McGuire <mcguire@crsr.net>

Slightly expand the cvsimport description, and make a couple of syntax edits.

---
commit 9a861c244e79634abf3c8436d720e77140d0e0e3
tree 32155e131933b2e48383644a3e3198f541f6d4b8
parent 2e670826cec5642a11e2e7d6adcb48e02225ba6d
author Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 02:11:14 -0500
committer Tommy M. McGuire <mcguire@crsr.net> Fri, 10 Jun 2005 02:11:14 -0500

 Documentation/cvs-migration.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -14,7 +14,7 @@ does a lot of things differently. 
 One particular suckage of CVS is very hard to work around: CVS is
 basically a tool for tracking _file_ history, while git is a tool for
 tracking _project_ history.  This sometimes causes problems if you are
-used to doign very strange things in CVS, in particular if you're doing
+used to doing very strange things in CVS, in particular if you're doing
 things like making branches of just a subset of the project.  Git can't
 track that, since git never tracks things on the level of an individual
 file, only on the whole project level. 
@@ -35,8 +35,8 @@ that you're actually working in (your wo
 working directories _are_ the repositories.  However, you can easily
 emulate the CVS model by having one special "global repository", which
 people can synchronize with.  See details later, but in the meantime
-just keep in mind that with git, every checked out working tree will be
-a full revision control of its own. 
+just keep in mind that with git, every checked out working tree will
+have a full revision control history of its own.
 
 
 Importing a CVS archive
@@ -69,10 +69,12 @@ which will do exactly what you'd think i
 archive of the named CVS module. The new archive will be created in a
 subdirectory named <module>.
 
-It can take some time to actually do the conversion for a large archive,
+It can take some time to actually do the conversion for a large archive
+since it involves checking out from CVS every revision of every file,
 and the conversion script can be reasonably chatty, but on some not very
 scientific tests it averaged about eight revisions per second, so a
-medium-sized project should not take more than a couple of minutes.
+medium-sized project should not take more than a couple of minutes.  For
+larger projects or remote repositories, the process may take longer.
 
 
 Emulating CVS behaviour



!-------------------------------------------------------------flip-


-- 
Tommy McGuire
