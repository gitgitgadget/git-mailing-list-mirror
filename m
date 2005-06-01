From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One Git To Rule Them All - Prep 1
Date: Wed, 1 Jun 2005 01:59:49 -0400
Message-ID: <20050601055949.GA15813@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 07:57:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdME3-0001RN-GD
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 07:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFAF74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 01:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFAF74
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 01:59:56 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:14792
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261282AbVFAF7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 01:59:50 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id D61054001; Wed,  1 Jun 2005 01:59:49 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

one-git prep patch 1/2

Add some missing documentation for git-* commands

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-apply.txt
@@ -0,0 +1,36 @@
+git-apply(1)
+============
+v0.1, May 2005
+
+NAME
+----
+git-apply - Apply a patch against the current index cache/working directory
+
+
+SYNOPSIS
+--------
+'git-apply' [--check] [--stat] [--show-file] <patch>
+
+DESCRIPTION
+-----------
+This applies patches on top of some (arbitrary) version of the SCM.
+
+NOTE! It does all its work in the index file, and only cares about
+the files in the working directory if you tell it to "merge" the
+patch apply.
+
+Even when merging it always takes the source from the index, and
+uses the working tree as a "branch" for a 3-way merge.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -0,0 +1,29 @@
+git-get-tar-commit-id(1)
+========================
+v0.1, May 2005
+
+NAME
+----
+git-get-tar-commit-id - Show the commit ID embedded in a git-tar-tree file.
+
+
+SYNOPSIS
+--------
+'git-get-tar-commit-id' <tar-file.tar>
+
+DESCRIPTION
+-----------
+This shows the commit ID embedded in a git-tar-tree generated file.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-stripspace.txt
@@ -0,0 +1,31 @@
+git-stripspace(1)
+=================
+v0.1, May 2005
+
+NAME
+----
+git-stripspace - Strip space from stdin
+
+
+SYNOPSIS
+--------
+'git-stripspace' <stream
+
+DESCRIPTION
+-----------
+Remove empty lines from the beginning and end.
+
+Turn multiple consecutive empty lines into just one empty line.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+

