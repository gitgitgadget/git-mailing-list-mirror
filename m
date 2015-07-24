From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/6] Documentation/git-tools: fix item text formatting
Date: Fri, 24 Jul 2015 00:00:56 -0400
Message-ID: <1437710457-38592-6-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB9-0004MA-EN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbbGXEBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:44 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38813 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbGXEBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:38 -0400
Received: by iggf3 with SMTP id f3so7264404igg.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T2WIYRLzLoPsiJmrk84r/QF1XxArcNdAzuLVcGOaJR8=;
        b=YWMqqglce8CP8Me0GHPArCD/AVibmocwHr64EgbfyUigdIRT4OKYbcbEG9aL9fwQFJ
         VUXa24Afb/4eguIpzvizXE2LrCQY/5MDhO1p1AVdGnHzJUibASP0XQXgDrdr/cawm9UL
         EnMGJEAv5F5eUBUw3i+zRwZH1pVUuC/fRMFjNC/rNg0u5kzNftWJtB630cCEWo2yuhzc
         AvIuIdSiyGALOuaWXxf0524Gtlby+wJ0wF2sTAX8bhdSaMAZavBkXayygfTHEY5c3E0n
         TNH5Oi6EJqA+Gk0gEs376vcTZqRjL1rzitm+dnZLilVjxuo7X8DCQCupfGnAzIWI9W7+
         KxrA==
X-Received: by 10.50.72.6 with SMTP id z6mr1049536igu.65.1437710497760;
        Thu, 23 Jul 2015 21:01:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274543>

Descriptive text for each tool item is incorrectly formatted using a
fixed width font. Fix formatting to use a variable width font by
unindenting the item text.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-tools.txt | 134 ++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 129b8c0..ab4aab9 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -16,100 +16,100 @@ http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
 Alternative/Augmentative Porcelains
 -----------------------------------
 
-   - *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
+- *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
++
+Cogito is a version control system layered on top of the Git tree history
+storage system. It aims at seamless user interface and ease of use,
+providing generally smoother user experience than the "raw" Core Git
+itself and indeed many other version control systems.
++
+Cogito is no longer maintained as most of its functionality
+is now in core Git.
 
-   Cogito is a version control system layered on top of the Git tree history
-   storage system. It aims at seamless user interface and ease of use,
-   providing generally smoother user experience than the "raw" Core Git
-   itself and indeed many other version control systems.
 
-   Cogito is no longer maintained as most of its functionality
-   is now in core Git.
+- *pg* (http://www.spearce.org/category/projects/scm/pg/)
++
+pg is a shell script wrapper around Git to help the user manage a set of
+patches to files. pg is somewhat like quilt or StGit, but it does have a
+slightly different feature set.
 
 
-   - *pg* (http://www.spearce.org/category/projects/scm/pg/)
-
-   pg is a shell script wrapper around Git to help the user manage a set of
-   patches to files. pg is somewhat like quilt or StGit, but it does have a
-   slightly different feature set.
-
-
-   - *StGit* (http://www.procode.org/stgit/)
-
-   Stacked Git provides a quilt-like patch management functionality in the
-   Git environment. You can easily manage your patches in the scope of Git
-   until they get merged upstream.
+- *StGit* (http://www.procode.org/stgit/)
++
+Stacked Git provides a quilt-like patch management functionality in the
+Git environment. You can easily manage your patches in the scope of Git
+until they get merged upstream.
 
 
 History Viewers
 ---------------
 
-   - *gitk* (shipped with git-core)
-
-   gitk is a simple Tk GUI for browsing history of Git repositories easily.
-
-
-   - *gitview*  (contrib/)
-
-   gitview is a GTK based repository browser for Git
+- *gitk* (shipped with git-core)
++
+gitk is a simple Tk GUI for browsing history of Git repositories easily.
 
 
-   - *gitweb* (shipped with git-core)
+- *gitview*  (contrib/)
++
+gitview is a GTK based repository browser for Git
 
-   Gitweb provides full-fledged web interface for Git repositories.
 
+- *gitweb* (shipped with git-core)
++
+Gitweb provides full-fledged web interface for Git repositories.
 
-   - *qgit* (http://digilander.libero.it/mcostalba/)
 
-   QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
-   to browse history and directory tree, view annotated files, commit
-   changes cherry picking single files or applying patches.
-   Currently it is the fastest and most feature rich among the Git
-   viewers and commit tools.
+- *qgit* (http://digilander.libero.it/mcostalba/)
++
+QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
+to browse history and directory tree, view annotated files, commit
+changes cherry picking single files or applying patches.
+Currently it is the fastest and most feature rich among the Git
+viewers and commit tools.
 
-   - *tig* (http://jonas.nitro.dk/tig/)
-
-   tig by Jonas Fonseca is a simple Git repository browser
-   written using ncurses. Basically, it just acts as a front-end
-   for git-log and git-show/git-diff. Additionally, you can also
-   use it as a pager for Git commands.
+- *tig* (http://jonas.nitro.dk/tig/)
++
+tig by Jonas Fonseca is a simple Git repository browser
+written using ncurses. Basically, it just acts as a front-end
+for git-log and git-show/git-diff. Additionally, you can also
+use it as a pager for Git commands.
 
 
 Foreign SCM interface
 ---------------------
 
-   - *git-svn* (shipped with git-core)
-
-   git-svn is a simple conduit for changesets between a single Subversion
-   branch and Git.
-
-
-   - *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
+- *git-svn* (shipped with git-core)
++
+git-svn is a simple conduit for changesets between a single Subversion
+branch and Git.
 
-   These utilities convert patch series in a quilt repository and commit
-   series in Git back and forth.
 
+- *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
++
+These utilities convert patch series in a quilt repository and commit
+series in Git back and forth.
 
-   - *hg-to-git* (contrib/)
 
-   hg-to-git converts a Mercurial repository into a Git one, and
-   preserves the full branch history in the process. hg-to-git can
-   also be used in an incremental way to keep the Git repository
-   in sync with the master Mercurial repository.
+- *hg-to-git* (contrib/)
++
+hg-to-git converts a Mercurial repository into a Git one, and
+preserves the full branch history in the process. hg-to-git can
+also be used in an incremental way to keep the Git repository
+in sync with the master Mercurial repository.
 
 
 Others
 ------
 
-   - *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
-
-   Commit Tool or (h)gct is a GUI enabled commit tool for Git and
-   Mercurial (hg). It allows the user to view diffs, select which files
-   to committed (or ignored / reverted) write commit messages and
-   perform the commit itself.
-
-   - *git.el* (contrib/)
-
-   This is an Emacs interface for Git. The user interface is modelled on
-   pcl-cvs. It has been developed on Emacs 21 and will probably need some
-   tweaking to work on XEmacs.
+- *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
++
+Commit Tool or (h)gct is a GUI enabled commit tool for Git and
+Mercurial (hg). It allows the user to view diffs, select which files
+to committed (or ignored / reverted) write commit messages and
+perform the commit itself.
+
+- *git.el* (contrib/)
++
+This is an Emacs interface for Git. The user interface is modelled on
+pcl-cvs. It has been developed on Emacs 21 and will probably need some
+tweaking to work on XEmacs.
-- 
2.5.0.rc3.407.g68aafd0
