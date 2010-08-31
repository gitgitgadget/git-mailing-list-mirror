From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD PATCH] Documentation: remove git-tools
Date: Tue, 31 Aug 2010 21:40:16 +0200
Message-ID: <ef9f5918c0c5254460c7ca51bd9c130ece23f4ab.1283283511.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 21:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWgy-0000hp-DR
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab0HaTkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:40:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53314 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753345Ab0HaTkP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:40:15 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AB8082EF
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:40:14 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 31 Aug 2010 15:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=5jjmLtrskAyL82Htp7Nxopeq8Pk=; b=pWiUP/uerDXS4jkRDphRjOxr1ShZxk7gl8UAuKFETodUD+w0/M1m7kTFy3jG658+iV+g0chAwjOYNTBRBi8FM6o/ldy3EnaVrqYuTCK5ow0a+neIjuJs/H9JpL0X62PkbAIuudh/21OjCRXMEc9T+H9k89jsV5kKTr7mH08DhyI=
X-Sasl-enc: LAU3MhYpDRIsnpGGsLovrEIt9eAkA1TBWLeB5081auwM 1283283613
Received: from localhost (p54859079.dip0.t-ipconnect.de [84.133.144.121])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D303D5E68D5;
	Tue, 31 Aug 2010 15:40:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.2.398.g5af70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154976>

git-tools.txt is outdated, it has been touched last in 2007, and it is
superceded by the online wiki. So, remove it from the tree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
It's never too late for spring cleaning...

I don't think historic documents are bad but this one is simply outdated.

 Documentation/Makefile      |    1 -
 Documentation/git-tools.txt |  118 -------------------------------------------
 Makefile                    |    1 -
 3 files changed, 0 insertions(+), 120 deletions(-)
 delete mode 100644 Documentation/git-tools.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..876f214 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -16,7 +16,6 @@ DOC_HTML=$(MAN_HTML)
 
 ARTICLES = howto-index
 ARTICLES += everyday
-ARTICLES += git-tools
 ARTICLES += git-bisect-lk2009
 # with their own formatting rules.
 SP_ARTICLES = howto/revert-branch-rebase howto/using-merge-subtree user-manual
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
deleted file mode 100644
index a96403c..0000000
--- a/Documentation/git-tools.txt
+++ /dev/null
@@ -1,118 +0,0 @@
-A short git tools survey
-========================
-
-
-Introduction
-------------
-
-Apart from git contrib/ area there are some others third-party tools
-you may want to look.
-
-This document presents a brief summary of each tool and the corresponding
-link.
-
-
-Alternative/Augmentative Porcelains
------------------------------------
-
-   - *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
-
-   Cogito is a version control system layered on top of the git tree history
-   storage system. It aims at seamless user interface and ease of use,
-   providing generally smoother user experience than the "raw" Core GIT
-   itself and indeed many other version control systems.
-
-   Cogito is no longer maintained as most of its functionality
-   is now in core GIT.
-
-
-   - *pg* (http://www.spearce.org/category/projects/scm/pg/)
-
-   pg is a shell script wrapper around GIT to help the user manage a set of
-   patches to files. pg is somewhat like quilt or StGIT, but it does have a
-   slightly different feature set.
-
-
-   - *StGit* (http://www.procode.org/stgit/)
-
-   Stacked GIT provides a quilt-like patch management functionality in the
-   GIT environment. You can easily manage your patches in the scope of GIT
-   until they get merged upstream.
-
-
-History Viewers
----------------
-
-   - *gitk* (shipped with git-core)
-
-   gitk is a simple Tk GUI for browsing history of GIT repositories easily.
-
-
-   - *gitview*  (contrib/)
-
-   gitview is a GTK based repository browser for git
-
-
-   - *gitweb* (shipped with git-core)
-
-   GITweb provides full-fledged web interface for GIT repositories.
-
-
-   - *qgit* (http://digilander.libero.it/mcostalba/)
-
-   QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
-   to browse history and directory tree, view annotated files, commit
-   changes cherry picking single files or applying patches.
-   Currently it is the fastest and most feature rich among the git
-   viewers and commit tools.
-
-   - *tig* (http://jonas.nitro.dk/tig/)
-
-   tig by Jonas Fonseca is a simple git repository browser
-   written using ncurses. Basically, it just acts as a front-end
-   for git-log and git-show/git-diff. Additionally, you can also
-   use it as a pager for git commands.
-
-
-Foreign SCM interface
----------------------
-
-   - *git-svn* (shipped with git-core)
-
-   git-svn is a simple conduit for changesets between a single Subversion
-   branch and git.
-
-
-   - *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
-
-   These utilities convert patch series in a quilt repository and commit
-   series in git back and forth.
-
-
-   - *hg-to-git* (contrib/)
-
-   hg-to-git converts a Mercurial repository into a git one, and
-   preserves the full branch history in the process. hg-to-git can
-   also be used in an incremental way to keep the git repository
-   in sync with the master Mercurial repository.
-
-
-Others
-------
-
-   - *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
-
-   Commit Tool or (h)gct is a GUI enabled commit tool for git and
-   Mercurial (hg). It allows the user to view diffs, select which files
-   to committed (or ignored / reverted) write commit messages and
-   perform the commit itself.
-
-   - *git.el* (contrib/)
-
-   This is an Emacs interface for git. The user interface is modeled on
-   pcl-cvs. It has been developed on Emacs 21 and will probably need some
-   tweaking to work on XEmacs.
-
-
-http://git.or.cz/gitwiki/InterfacesFrontendsAndTools has more
-comprehensive list.
diff --git a/Makefile b/Makefile
index 62d526a..77bf57f 100644
--- a/Makefile
+++ b/Makefile
@@ -2359,7 +2359,6 @@ check-docs::
 		documented,gitignore | \
 		documented,gitmodules | \
 		documented,gitcli | \
-		documented,git-tools | \
 		documented,gitcore-tutorial | \
 		documented,gitcvs-migration | \
 		documented,gitdiffcore | \
-- 
1.7.2.2.398.g5af70
