From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Add a Documentation/git-tools.txt
Date: Sun, 19 Feb 2006 11:00:31 +0100
Message-ID: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 19 11:00:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAlN0-0000RB-KA
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 11:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWBSKAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 05:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWBSKAd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 05:00:33 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:20057 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932385AbWBSKAc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 05:00:32 -0500
Received: by zproxy.gmail.com with SMTP id x7so683958nzc
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 02:00:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WVW4Lx5li8ZQD+ErASyPu/Xz8XvVkSil93Jo0Br7dosIzZ8IEyzX6sGc7RhvhGcNBhd2wvqLtKh6Ux3xlIp3GAS1m802/RwVqYFt4MEJ6Uz57iOP5QvHlfICtCkdpLgRCJ8cAVU34Gzz/vn70dLk3iSGjVLjh2c8aahJa5GH5Z4=
Received: by 10.64.210.12 with SMTP id i12mr114795qbg;
        Sun, 19 Feb 2006 02:00:31 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 19 Feb 2006 02:00:31 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16427>

A brief survey of useful git tools, including third-party
and external projects.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Please consider this more of a RFC  then a finished patch.

Where possible, for each tool, the author's description is used as a summary.
I found http://git.or.cz/ a good source.

Tools are listed alphabetically in for each section.

Feel free to add/modify comments or tool's summaries. As stated this is still a
work in progress.


  Documentation/git-tools.txt |   90 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/git-tools.txt

355a382ecca292363af2a0be4769c2b2fb2ea9e7
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
new file mode 100644
index 0000000..7e563db
--- /dev/null
+++ b/Documentation/git-tools.txt
@@ -0,0 +1,90 @@
+A short git tools survey
+========================
+
+
+Introduction
+------------
+
+Apart from git contrib/ area there are some others third-party tools
+you may want to look.
+
+This document presents a brief summary of each tool and the corresponding link.
+
+
+Alternative/Argumentative Porcelains
+------------------------------------
+
+        - *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
+
+	  Cogito is a version control system layered on top of the git tree history
+	  storage system. It aims at seamless user interface and ease of
use, providing
+	  generally smoother user experience than the "raw" Core GIT itself and indeed
+	  many other version control systems.
+
+
+        - *pg* (http://www.spearce.org/category/projects/scm/pg/)
+
+	  pg is a shell script wrapper around GIT to help the user manage a set of
+          patches to files. pg is somewhat like quilt or StGIT, but
it does have a
+          slightly different feature set.
+
+
+        - *StGit* (http://homepage.ntlworld.com/cmarinas/stgit/)
+
+	  Stacked GIT provides a quilt-like patch management functionality in the GIT
+          environment. You can easily manage your patches in the
scope of GIT until they
+          get merged upstream.
+
+
+History Viewers
+---------------
+
+	- *gitk* (shipped with git-core)
+
+            gitk is a simple TK GUI for browsing history of GIT
repositories easily.
+
+
+	- *gitview*  (contrib/)
+
+            gitview is a GTK based repository browser for git
+
+
+	- *gitweb* (ftp://ftp.kernel.org/pub/software/scm/gitweb/)
+
+            GITweb provides full-fledged web interface for GIT repositories.
+
+
+        - *qgit* (http://digilander.libero.it/mcostalba/)
+
+            QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
+            to browse history and directory tree, view annotated files, commit
+            changes cherry picking single files or applying patches.
+
+
+
+Foreign SCM interface
+---------------------
+
+        - *git-svn* (contrib/)
+
+            git-svn is a simple conduit for changesets between a
single Subversion
+            branch and git.
+
+
+        - *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
+
+            These utilities convert patch series in a quilt
repository and commit
+            series in git back and forth.
+
+
+Others
+------
+
+	- *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
+
+            Commit Tool or (h)gct is a GUI enabled commit tool for git and
+            Mercurial (hg). It allows the user to view diffs, select
which files
+            to committed (or ignored / reverted) write commit
messages and perform
+            the commit itself.
+
+
--
1.2.0.g62a4
