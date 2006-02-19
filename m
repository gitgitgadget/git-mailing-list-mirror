From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Sun, 19 Feb 2006 13:04:13 +0100
Message-ID: <e5bfff550602190404i6c21a940hdcac16e66498363@mail.gmail.com>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	 <7vlkw7iphb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 13:04:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAnIg-0003Z3-30
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 13:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWBSMEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 07:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWBSMEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 07:04:16 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:59789 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932404AbWBSMEP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 07:04:15 -0500
Received: by wproxy.gmail.com with SMTP id 57so705001wri
        for <git@vger.kernel.org>; Sun, 19 Feb 2006 04:04:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iea11L03Norh5apFuUGD+rma3fgfq/kWCQDmpjMk581qiVuPh4X4MuBfU2IxBjGFIiK55WBwRNRazvhGZQEIRLhCicX5zA6P+wL/hgW5Jv1WFe7IwyCiKx01u5xsyURIrQFPJ2akCJIk5wIch2h1Hr91pFFUg6eOVIdVuiY1IPQ=
Received: by 10.64.210.12 with SMTP id i12mr148519qbg;
        Sun, 19 Feb 2006 04:04:13 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sun, 19 Feb 2006 04:04:13 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vlkw7iphb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16434>

On 2/19/06, Junio C Hamano <junkio@cox.net> wrote:
>
> Thanks for starting this.
>
> Briefly mentioning tool's strength and weakness without being
> too subjective would be very helpful to potential users.  We
> would encourage competition without making other tools sound
> inferiour on subjective terms.  So "this is similar to foobar
> tool, but runs much faster, but has these limitations" would be
> a good style, but "this draws much nicer picture than barboz"
> without substantiating why it is nicer may be suboptimal.

Ok, I resend the patch with 'encouraged competition' comments on,
guess what, qgit.
It is a little bit biased but provable. I speak only for tools I know
well. I would like each tool author writes it's own advertising ;-)

Also added the freshly new contrib/ emacs interface, called pcl-cvs,
as in revision log message.

> I am a bit afraid that the summary can become stale unless
> maintained actively.

This is unavoidable but also a useful 'watchdog' to test active maintenance.

> I am of two minds about mentioning things available from the git
> repository, but I think it makes the survey more complete and
> more useful in general to include them in the list.
>

I agree, we don't have hundreds of tools around, so list all in just
one place perhaps is
not the cleanest thing, but it is more user friendly.

--------------------------  cut ----------------------------------

From: Marco Costalba <mcostalba@gmail.com>
Date: Sun Feb 19 12:52:07 2006 +0100
Subject: [PATCH] Add a Documentation/git-tools.txt

A brief survey of useful git tools, including third-party
and external projects.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>


---

  Documentation/git-tools.txt |   97 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/git-tools.txt

ce159730f858f50046186301f2d8668c66526627
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
new file mode 100644
index 0000000..93a8d8b
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
1.2.0.g709a
