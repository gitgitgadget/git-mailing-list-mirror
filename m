From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] Documentation: Clean up links in GIT Glossary
Date: Sat, 26 May 2007 00:37:38 +0200
Message-ID: <11801326601014-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 00:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HriL9-0006ZS-2K
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbXEYWcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXEYWcn
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:32:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:4313 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbXEYWcm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:32:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1222475ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 15:32:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=O/8nSzJT0F+VRVJAYefPpyifTTWhttsHDN+e3GEoNrOyvxIwh3kRMT025mksOGdsEuzFLtqlFO2EQ6eygLQyissAekArFwRagVZVcYHMxdir4elRt34NCpEXgxSN46htYQp3f3loKocu3ak3i3CmoDduafHFksjT/Or5KMMLUjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=E7jMyMTd60gImjDvyhmZy4yVg1u+wLSpfIDImJUy/3F2QNMwpVOhONSOtroepbsz6IjkBsFlNlrLpAEK4HyPNgtsxNbt+e4AmvoUqknPMGHmSOvdapVDshdsuw7yUW/ewwvhD+E/NC8OXLz899915F7kr9Wpg4VsBTXPyalWRzY=
Received: by 10.67.93.2 with SMTP id v2mr3205879ugl.1180132360487;
        Fri, 25 May 2007 15:32:40 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm15617496mug.2007.05.25.15.32.37;
        Fri, 25 May 2007 15:32:38 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4PMbfAU015334;
	Sat, 26 May 2007 00:37:42 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4PMbei7015332;
	Sat, 26 May 2007 00:37:40 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48429>

Ensure that the same link is not repeated in single glossary entry,
and that there is no self-link i.e. link to current entry.

Add links to other definitions in git glossary.

Remove inappropriate (nonsense) links, or change link to link to
correct definition (to correct term).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
While updating http://git.or.cz/gitwiki/GitGlossary to modern
Documentation/glossary.txt version, I have noticed few places
where GIT Glossary can be improved.

 Documentation/glossary.txt |   58 ++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 489c3e9..ba52618 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -10,7 +10,7 @@ GIT Glossary
 	A bare repository is normally an appropriately
 	named <<def_directory,directory>> with a `.git` suffix that does not
 	have a locally checked-out copy of any of the files under
-	<<def_revision,revision>> control. That is, all of the `git`
+	revision control. That is, all of the `git`
 	administrative and control files that would normally be present in the
 	hidden `.git` sub-directory are directly present in the
 	`repository.git` directory instead,
@@ -37,7 +37,7 @@ GIT Glossary
 [[def_chain]]chain::
 	A list of objects, where each <<def_object,object>> in the list contains
 	a reference to its successor (for example, the successor of a
-	<<def_commit,commit>> could be one of its parents).
+	<<def_commit,commit>> could be one of its <<def_parent,parents>>).
 
 [[def_changeset]]changeset::
 	BitKeeper/cvsps speak for "<<def_commit,commit>>". Since git does not
@@ -77,10 +77,10 @@ to point at the new commit.
 
 [[def_commit_object]]commit object::
 	An <<def_object,object>> which contains the information about a
-	particular <<def_revision,revision>>, such as parents, committer,
+	particular <<def_revision,revision>>, such as <<def_parent,parents>>, committer,
 	author, date and the <<def_tree_object,tree object>> which corresponds
 	to the top <<def_directory,directory>> of the stored
-	<<def_revision,revision>>.
+	revision.
 
 [[def_core_git]]core git::
 	Fundamental data structures and utilities of git. Exposes only limited
@@ -101,19 +101,19 @@ to point at the new commit.
 
 [[def_detached_HEAD]]detached HEAD::
 	Normally the <<def_HEAD,HEAD>> stores the name of a
-	<<def_branch,branch>>.  However, git also allows you to check
-	out an arbitrary commit that isn't necessarily the tip of any
+	<<def_branch,branch>>.  However, git also allows you to <<def_checkout,check out>>
+	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
 	particular branch.  In this case HEAD is said to be "detached".
 
 [[def_dircache]]dircache::
-	You are *waaaaay* behind.
+	You are *waaaaay* behind. See <<def_index,index>>.
 
 [[def_directory]]directory::
 	The list you get with "ls" :-)
 
 [[def_dirty]]dirty::
 	A <<def_working_tree,working tree>> is said to be "dirty" if
-	it contains modifications which have not been committed to the current
+	it contains modifications which have not been <<def_commit,committed>> to the current
 	<<def_branch,branch>>.
 
 [[def_ent]]ent::
@@ -149,7 +149,7 @@ to point at the new commit.
 [[def_grafts]]grafts::
 	Grafts enables two otherwise different lines of development to be joined
 	together by recording fake ancestry information for commits. This way
-	you can make git pretend the set of parents a <<def_commit,commit>> has
+	you can make git pretend the set of <<def_parent,parents>> a <<def_commit,commit>> has
 	is different from what was recorded when the commit was
 	created. Configured via the `.git/info/grafts` file.
 
@@ -157,13 +157,13 @@ to point at the new commit.
 	In git's context, synonym to <<def_object_name,object name>>.
 
 [[def_head]]head::
-	A named reference to the <<def_commit,commit>> at the tip of a
+	A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of a
 	<<def_branch,branch>>.  Heads are stored in
 	`$GIT_DIR/refs/heads/`, except when using packed refs. (See
 	gitlink:git-pack-refs[1].)
 
 [[def_HEAD]]HEAD::
-	The current branch.  In more detail: Your <<def_working_tree,
+	The current <<def_branch,branch>>.  In more detail: Your <<def_working_tree,
 	working tree>> is normally derived from the state of the tree
 	referred to by HEAD.  HEAD is a reference to one of the
 	<<def_head,heads>> in your repository, except when using a
@@ -179,15 +179,15 @@ to point at the new commit.
 	checking. Typically, the hooks allow for a command to be pre-verified
 	and potentially aborted, and allow for a post-notification after the
 	operation is done. The hook scripts are found in the
-	`$GIT_DIR/hooks/` <<def_directory,directory>>, and are enabled by simply
+	`$GIT_DIR/hooks/` directory, and are enabled by simply
 	making them executable.
 
 [[def_index]]index::
 	A collection of files with stat information, whose contents are stored
-	as objects. The index is a stored version of your working
-	<<def_tree,tree>>. Truth be told, it can also contain a second, and even
-	a third version of a <<def_working_tree,working tree>>, which are used
-	when merging.
+	as objects. The index is a stored version of your
+	<<def_working_tree,working tree>>. Truth be told, it can also contain a second, and even
+	a third version of a working tree, which are used
+	when <<def_merge,merging>>.
 
 [[def_index_entry]]index entry::
 	The information regarding a particular file, stored in the
@@ -249,16 +249,16 @@ This commit is referred to as a "merge commit", or sometimes just a
 	describing the type of an <<def_object,object>>.
 
 [[def_octopus]]octopus::
-	To <<def_merge,merge>> more than two branches. Also denotes an
+	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
 	intelligent predator.
 
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
 	'origin' is used for that purpose. New upstream updates
-	will be fetched into remote tracking branches named
+	will be fetched into remote <<def_tracking_branch,tracking branches>> named
 	origin/name-of-upstream-branch, which you can see using
-	"git <<def_branch,branch>> -r".
+	"`git branch -r`".
 
 [[def_pack]]pack::
 	A set of objects which have been compressed into one file (to save space
@@ -327,7 +327,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	`$GIT_DIR/refs/`.
 
 [[def_refspec]]refspec::
-	A <<def_refspec,refspec>> is used by <<def_fetch,fetch>> and
+	A "refspec" is used by <<def_fetch,fetch>> and
 	<<def_push,push>> to describe the mapping between remote
 	<<def_ref,ref>> and local ref. They are combined with a colon in
 	the format <src>:<dst>, preceded by an optional plus sign, +.
@@ -340,11 +340,12 @@ This commit is referred to as a "merge commit", or sometimes just a
 	gitlink:git-push[1]
 
 [[def_repository]]repository::
-	A collection of refs together with an
+	A collection of <<def_ref,refs>> together with an
 	<<def_object_database,object database>> containing all objects
 	which are <<def_reachable,reachable>> from the refs, possibly
-	accompanied by meta data from one or more porcelains. A
-	repository can share an object database with other repositories.
+	accompanied by meta data from one or more <<def_porcelain,porcelains>>. A
+	repository can share an object database with other repositories
+	via <<def_alternate_object_database,alternates mechanism>>.
 
 [[def_resolve]]resolve::
 	The action of fixing up manually what a failed automatic
@@ -366,8 +367,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 	Synonym for <<def_object_name,object name>>.
 
 [[def_shallow_repository]]shallow repository::
-	A shallow repository has an incomplete
-	history some of whose commits have parents cauterized away (in other
+	A shallow <<def_repository,repository>> has an incomplete
+	history some of whose <<def_commit,commits>> have <<def_parent,parents>> cauterized away (in other
 	words, git is told to pretend that these commits do not have the
 	parents, even though they are recorded in the <<def_commit_object,commit
 	object>>). This is sometimes useful when you are interested only in the
@@ -385,7 +386,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	command.
 
 [[def_tag]]tag::
-	A <<def_ref,ref>> pointing to a tag or
+	A <<def_ref,ref>> pointing to a <<def_tag_object,tag>> or
 	<<def_commit_object,commit object>>. In contrast to a <<def_head,head>>,
 	a tag is not changed by a <<def_commit,commit>>. Tags (not
 	<<def_tag_object,tag objects>>) are stored in `$GIT_DIR/refs/tags/`. A
@@ -398,8 +399,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	An <<def_object,object>> containing a <<def_ref,ref>> pointing to
 	another object, which can contain a message just like a
 	<<def_commit_object,commit object>>. It can also contain a (PGP)
-	signature, in which case it is called a "signed <<def_tag_object,tag
-	object>>".
+	signature, in which case it is called a "signed tag object".
 
 [[def_topic_branch]]topic branch::
 	A regular git <<def_branch,branch>> that is used by a developer to
@@ -418,7 +418,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 
 [[def_tree]]tree::
 	Either a <<def_working_tree,working tree>>, or a <<def_tree_object,tree
-	object>> together with the dependent blob and tree objects
+	object>> together with the dependent <<def_blob_object,blob>> and tree objects
 	(i.e. a stored representation of a working tree).
 
 [[def_tree_object]]tree object::
-- 
1.5.2
