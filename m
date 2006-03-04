From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Sat, 4 Mar 2006 07:42:09 +0100
Message-ID: <e5bfff550603032242v55f88c5fvd385e17f210eb7dc@mail.gmail.com>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	 <tnxwtfq8gok.fsf@arm.com>
	 <e5bfff550602260022jde1fe2n4ec117c609a5d22d@mail.gmail.com>
	 <7vslq57mzn.fsf@assigned-by-dhcp.cox.net>
	 <87psl9i4as.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Alexandre Julliard" <julliard@winehq.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 07:42:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFQT2-0001aK-Lm
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 07:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWCDGmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 01:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWCDGmL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 01:42:11 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:35769 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751387AbWCDGmK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 01:42:10 -0500
Received: by zproxy.gmail.com with SMTP id 16so370117nzp
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 22:42:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JP+UrN3g/upA8Q1tfNP0hqw32FIpWWxUWOhexb8M/rG6ySzYF4hQ2rwYe070heY6H0p3S5qJ6tF+fcy511GHYjFrd7y73999obMDo9PaXO3bBiZNQToglUIahSqR9HWEQIQczedSuRcMTwxSTXa0/NaqUcKujCae2WXFMnvclRo=
Received: by 10.64.193.7 with SMTP id q7mr709407qbf;
        Fri, 03 Mar 2006 22:42:09 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Fri, 3 Mar 2006 22:42:09 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <87psl9i4as.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17176>

A brief survey of useful git tools, including third-party
and external projects.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

 Documentation/git-tools.txt |   97 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-tools.txt

5e8c2ec9d08dce7f333b0963d7911c3096ab6588
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
new file mode 100644
index 0000000..00e57a6
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
+This document presents a brief summary of each tool and the corresponding
+link.
+
+
+Alternative/Augmentative Procelains
+-----------------------------------
+
+   - *Cogito* (http://www.kernel.org/pub/software/scm/cogito/)
+
+   Cogito is a version control system layered on top of the git tree history
+   storage system. It aims at seamless user interface and ease of use,
+   providing generally smoother user experience than the "raw" Core GIT
+   itself and indeed many other version control systems.
+
+
+   - *pg* (http://www.spearce.org/category/projects/scm/pg/)
+
+   pg is a shell script wrapper around GIT to help the user manage a set of
+   patches to files. pg is somewhat like quilt or StGIT, but it does have a
+   slightly different feature set.
+
+
+   - *StGit* (http://www.procode.org/stgit/)
+
+   Stacked GIT provides a quilt-like patch management functionality in the
+    GIT environment. You can easily manage your patches in the scope of GIT
+   until they get merged upstream.
+
+
+History Viewers
+---------------
+
+   - *gitk* (shipped with git-core)
+
+   gitk is a simple TK GUI for browsing history of GIT repositories easily.
+
+
+   - *gitview*  (contrib/)
+
+   gitview is a GTK based repository browser for git
+
+
+   - *gitweb* (ftp://ftp.kernel.org/pub/software/scm/gitweb/)
+
+   GITweb provides full-fledged web interface for GIT repositories.
+
+
+   - *qgit* (http://digilander.libero.it/mcostalba/)
+
+   QGit is a git/StGIT GUI viewer built on Qt/C++. QGit could be used
+   to browse history and directory tree, view annotated files, commit
+   changes cherry picking single files or applying patches.
+   Currently it is the fastest and most feature rich among the git
+   viewers and commit tools.
+
+
+
+Foreign SCM interface
+---------------------
+
+   - *git-svn* (contrib/)
+
+   git-svn is a simple conduit for changesets between a single Subversion
+   branch and git.
+
+
+   - *quilt2git / git2quilt* (http://home-tj.org/wiki/index.php/Misc)
+
+   These utilities convert patch series in a quilt repository and commit
+   series in git back and forth.
+
+
+Others
+------
+
+   - *(h)gct* (http://www.cyd.liu.se/users/~freku045/gct/)
+
+   Commit Tool or (h)gct is a GUI enabled commit tool for git and
+   Mercurial (hg). It allows the user to view diffs, select which files
+   to committed (or ignored / reverted) write commit messages and
+   perform the commit itself.
+
+   - *git.el* (contrib/)
+
+   This is an Emacs interface for git. The user interface is modeled on
+   pcl-cvs. It has been developed on Emacs 21 and will probably need some
+   tweaking to work on XEmacs.
--
1.2.2.gce4c
