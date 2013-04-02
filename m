From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 1/3] Remove outdated/missleading/irrelevant entries from
 glossary-content.txt
Date: Tue, 2 Apr 2013 11:26:57 +0200 (CEST)
Message-ID: <1051288663.727673.1364894817858.JavaMail.ngmail@webmail14.arcor-online.net>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 11:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMxV6-0001bu-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 11:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215Ab3DBJ1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 05:27:02 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:55392 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754982Ab3DBJ07 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 05:26:59 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id EB2E6A9CEA
	for <git@vger.kernel.org>; Tue,  2 Apr 2013 11:26:57 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id D94783F83D8;
	Tue,  2 Apr 2013 11:26:57 +0200 (CEST)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id CF44635A2B0;
	Tue,  2 Apr 2013 11:26:57 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net CF44635A2B0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1364894817; bh=bbYeLYC2qDQf3RU6zJEi9xfDLHw4YhN48i3d+j9NOc0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=AfiU2MaC5eXk17pcHH3xYa2iXV6QlMwCRMMoMEgXKie6Ub3enxhrY3KHv5HPb+IGv
	 EJmLU4wKpSQ4gsAaHB1leBbkP2wCTYbmqTe3RwFcHNmpbGc3QKdnJGUycu9dPbtRRG
	 osGLKNkV34KGnTsYxSjelLUTNLFcPpM8zS+/EW8A=
Received: from [94.217.19.243] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Tue, 2 Apr 2013 11:26:57 +0200 (CEST)
In-Reply-To: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.19.243
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219757>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/glossary-content.txt | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index eb7ba84..ab02238 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -5,7 +5,7 @@
 
 [[def_bare_repository]]bare repository::
 	A bare repository is normally an appropriately
-	named <<def_directory,directory>> with a `.git` suffix that does not
+	named directory with a `.git` suffix that does not
 	have a locally checked-out copy of any of the files under
 	revision control. That is, all of the Git
 	administrative and control files that would normally be present in the
@@ -79,7 +79,7 @@ to point at the new commit.
 	An <<def_object,object>> which contains the information about a
 	particular <<def_revision,revision>>, such as <<def_parent,parents>>, committer,
 	author, date and the <<def_tree_object,tree object>> which corresponds
-	to the top <<def_directory,directory>> of the stored
+	to the top directory of the stored
 	revision.
 
 [[def_core_git]]core Git::
@@ -104,26 +104,11 @@ to point at the new commit.
 	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
 	particular branch.  In this case HEAD is said to be "detached".
 
-[[def_dircache]]dircache::
-	You are *waaaaay* behind. See <<def_index,index>>.
-
-[[def_directory]]directory::
-	The list you get with "ls" :-)
-
 [[def_dirty]]dirty::
 	A <<def_working_tree,working tree>> is said to be "dirty" if
 	it contains modifications which have not been <<def_commit,committed>> to the current
 	<<def_branch,branch>>.
 
-[[def_ent]]ent::
-	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. See
-	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
-	explanation. Avoid this term, not to confuse people.
-
-[[def_evil_merge]]evil merge::
-	An evil merge is a <<def_merge,merge>> that introduces changes that
-	do not appear in any <<def_parent,parent>>.
-
 [[def_fast_forward]]fast-forward::
 	A fast-forward is a special type of <<def_merge,merge>> where you have a
 	<<def_revision,revision>> and you are "merging" another
@@ -257,8 +242,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	<<def_object,object>>.
 
 [[def_octopus]]octopus::
-	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
-	intelligent predator.
+	To <<def_merge,merge>> more than two <<def_branch,branches>>.
 
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
@@ -468,9 +452,7 @@ should not be combined with other pathspec.
 	object of an arbitrary type (typically a tag points to either a
 	<<def_tag_object,tag>> or a <<def_commit_object,commit object>>).
 	In contrast to a <<def_head,head>>, a tag is not updated by
-	the `commit` command. A Git tag has nothing to do with a Lisp
-	tag (which would be called an <<def_object_type,object type>>
-	in Git's context). A tag is most typically used to mark a particular
+	the `commit` command. A tag is most typically used to mark a particular
 	point in the commit ancestry <<def_chain,chain>>.
 
 [[def_tag_object]]tag object::
@@ -494,7 +476,7 @@ should not be combined with other pathspec.
 [[def_tree_object]]tree object::
 	An <<def_object,object>> containing a list of file names and modes along
 	with refs to the associated blob and/or tree objects. A
-	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
+	<<def_tree,tree>> is equivalent to a directory.
 
 [[def_tree-ish]]tree-ish::
 	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
-- 
1.8.1.msysgit.1


---
Thomas
