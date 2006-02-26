From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Sun, 26 Feb 2006 09:22:17 +0100
Message-ID: <e5bfff550602260022jde1fe2n4ec117c609a5d22d@mail.gmail.com>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	 <tnxwtfq8gok.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 09:22:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDHAk-0007Nf-3C
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 09:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBZIWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 03:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBZIWT
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 03:22:19 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:43090 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbWBZIWT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 03:22:19 -0500
Received: by wproxy.gmail.com with SMTP id i4so921086wra
        for <git@vger.kernel.org>; Sun, 26 Feb 2006 00:22:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqPEzdK3vYFfhTbcsjdGRkUjWoi24kSQST6D3LppDPLHzHWTTwBsHP4fG2+b9HXvUoljWpXN1/o5auv6iFY+cs6cebDCa4v2nxSpk8MxsPKXjIrr8fGcaxGjedFGzh1Kn/aFKxk2sHlKbd6kXU0r6WJyG9fNQ4ljQXvZ591r/fQ=
Received: by 10.64.21.20 with SMTP id 20mr4292329qbu;
        Sun, 26 Feb 2006 00:22:17 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 26 Feb 2006 00:22:17 -0800 (PST)
To: junkio@cox.net
In-Reply-To: <tnxwtfq8gok.fsf@arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16776>

A brief survey of useful git tools, including third-party
and external projects.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Suggestions/corrections from the list has been collected during the
past week, so I resend
the updated patch.

Please consider for apply.

One note. The suggestion of Jonas (  -*gitview*    ->  *gitview* :: )
has not been applied because
the output had no indent on project name. I played a little with
asciidoc to get an indent but without
success, so I revert to original indented format.

  Documentation/git-tools.txt |   97 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/git-tools.txt

8f41794257a6efe46f44e056710dfadcfbf362d7
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
new file mode 100644
index 0000000..7854972
--- /dev/null
+++ b/Documentation/git-tools.txt
@@ -0,0 +1,97 @@
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
+Alternative/Augmentative Porcelains
+-----------------------------------
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
+        - *StGit* (http://www.procode.org/stgit/)
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
+            Currently it is the fastest and most feature rich among
the git viewers
+            and commit tools.
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
+        - *pcl-cvs* (contrib/)
+
+            This is an Emacs interface for git. The user interface is
modeled on
+            pcl-cvs. It has been developed on Emacs 21 and will
probably need some
+            tweaking to work on XEmacs.
+
--
1.2.2.g8fcf1
