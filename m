From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system
 is referred to #1
Date: Tue, 22 Jan 2013 16:19:35 -0800
Message-ID: <7vfw1slpig.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vsj5slqz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txo4Q-0003ad-5z
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 01:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab3AWATk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 19:19:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab3AWATj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 19:19:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3A2B55E;
	Tue, 22 Jan 2013 19:19:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BLb6ogK1J/aHaCgaAnDp4Ltmljg=; b=SlTyHl
	1igQmdl983hmOpM7l3Bk5yPLQ3AGJJmSohQPl6KohjVB2iBYLB4w1UINRAHz8kIG
	xRIrVfgDkUqi1A4oF8tzzpFtKA4/p/zxj+9Fyx1d6PVzfEHltdgjGPuteoqVwi9p
	oCWnW7N1OVCaC35Hv9IW/2yy5RVeAL8cT5dXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hyBJbPRpLBTrHot5/vs0SYqBQSo8cwBr
	nm0U7X+Bosc94tiCMecutvwHU3gNU9LyezcBHusU5YHVvcazERfeawow8QGb07D0
	MEOwez2PVArvk5jON+AjoRzi7+doaoBzcxmAKNsZYBw2sXHHgicvsZwXSGOTb0lt
	tCVkaG0HQlY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD2F5B55D;
	Tue, 22 Jan 2013 19:19:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00F9FB55A; Tue, 22 Jan 2013
 19:19:37 -0500 (EST)
In-Reply-To: <7vsj5slqz1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jan 2013 15:48:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92ABA4F0-64F2-11E2-BCEB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214266>

This is the summary of the review comments in a patch form.


Subject: [PATCH] fixup! Change 'git' to 'Git' whenever the whole system is referred to #1

---
 Documentation/Makefile              | 4 ++--
 Documentation/git-clean.txt         | 2 +-
 Documentation/git-clone.txt         | 2 +-
 Documentation/git-filter-branch.txt | 2 +-
 Documentation/git-help.txt          | 2 +-
 Documentation/git-init.txt          | 2 +-
 Documentation/git-rm.txt            | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a7a4f75..c2d3ec1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -346,8 +346,8 @@ $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 install-webdoc : html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
 
-# You must have a clone of git-htmldocs and git-manpages repositories
-# next to the Git repository itself for the following to work.
+# You must have a clone of 'git-htmldocs' and 'git-manpages' repositories
+# next to the 'git' repository itself for the following to work.
 
 quick-install: quick-install-man
 
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 14bdbbb..bdc3ab8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -27,7 +27,7 @@ OPTIONS
 -------
 -d::
 	Remove untracked directories in addition to untracked files.
-	If an untracked directory is managed by a different git
+	If an untracked directory is managed by a different Git
 	repository, it is not removed by default.  Use -f option twice
 	if you really want to remove such a directory.
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 47d9880..5c16e31 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -213,7 +213,7 @@ objects from the source repository into a pack in the cloned repository.
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
-	then make a filesytem-agnostic git symbolic link to there.
+	then make a filesytem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
 
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index c07ad61..dfd12c9 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Lets you rewrite git revision history by rewriting the branches mentioned
+Lets you rewrite Git revision history by rewriting the branches mentioned
 in the <rev-list options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
 a perl rewrite on all files) or information about each commit.
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 071e947..835fba0 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -20,7 +20,7 @@ on the standard output.
 If the option '--all' or '-a' is given, then all available commands are
 printed on the standard output.
 
-If a git command is named, a manual page for that command is brought
+If a Git subcommand is named, a manual page for that subcommand is brought
 up. The 'man' program is used by default for this purpose, but this
 can be overridden by other options or configuration variables.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 2571f56..afd721e 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -59,7 +59,7 @@ DIRECTORY" section below.)
 
 Instead of initializing the repository where it is supposed to be,
 place a filesytem-agnostic Git symbolic link there, pointing to the
-specified Git path, and initialize a Git repository at the path. The
+specified path, and initialize a Git repository at the path. The
 result is Git repository can be separated from working tree. If this
 is reinitialization, the repository will be moved to the specified
 path.
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 1e5ef3b..92bac27 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -75,7 +75,7 @@ DISCUSSION
 The <file> list given to the command can be exact pathnames,
 file glob patterns, or leading directory names.  The command
 removes only the paths that are known to Git.  Giving the name of
-a file that you have not told git about does not remove that file.
+a file that you have not told Git about does not remove that file.
 
 File globbing matches across directory boundaries.  Thus, given
 two directories `d` and `d2`, there is a difference between
-- 
1.8.1.1.507.g1754052
