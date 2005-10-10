From: Christian Meder <chris@absolutegiganten.org>
Subject: [PATCH] The synopsis of the manpages should use the hyphenated
	version
Date: Mon, 10 Oct 2005 23:27:59 +0200
Message-ID: <1128979679.7097.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 10 23:31:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5Cy-00009a-Ul
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVJJV3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVJJV3A
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:29:00 -0400
Received: from a15181680.alturo-server.de ([217.160.108.75]:8659 "EHLO
	a15181680.alturo-server.de") by vger.kernel.org with ESMTP
	id S1751259AbVJJV27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:28:59 -0400
Received: from p54a21cce.dip0.t-ipconnect.de ([84.162.28.206] helo=localhost)
	by a15181680.alturo-server.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.52)
	id 1EP5Cc-00066t-Ss
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:28:59 +0200
Received: from chris by localhost with local (Exim 4.52)
	id 1EP5Bg-00028U-0j
	for git@vger.kernel.org; Mon, 10 Oct 2005 23:28:00 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9942>

The synopsis of the manpages should use the hyphenated version of the git
commands. Adapt the remaining offenders.

Signed-off-by: Christian Meder <chris@absolutegiganten.org>

---

 Documentation/git-clone.txt       |    2 +-
 Documentation/git-commit.txt      |    2 +-
 Documentation/git-log.txt         |    2 +-
 Documentation/git-resolve.txt     |    2 +-
 Documentation/git-shortlog.txt    |    2 +-
 Documentation/git-show-branch.txt |    2 +-
 Documentation/git-status.txt      |    2 +-
 Documentation/git-whatchanged.txt |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

77acd127869d3d2dbab69b85c6cf2e501af8d13f
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -8,7 +8,7 @@ git-clone - Clones a repository.
 
 SYNOPSIS
 --------
-'git clone' [-l [-s]] [-q] [-n] [-u <upload-pack>] <repository> <directory>
+'git-clone' [-l [-s]] [-q] [-n] [-u <upload-pack>] <repository> <directory>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -7,7 +7,7 @@ git-commit - Record your changes
 
 SYNOPSIS
 --------
-'git commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>] [-e] <file>...
+'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>] [-e] <file>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -8,7 +8,7 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
-'git log' <option>...
+'git-log' <option>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
--- a/Documentation/git-resolve.txt
+++ b/Documentation/git-resolve.txt
@@ -8,7 +8,7 @@ git-resolve - Merge two commits
 
 SYNOPSIS
 --------
-'git resolve' <current> <merged> <message>
+'git-resolve' <current> <merged> <message>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,7 +8,7 @@ git-shortlog - Summarize 'git log' outpu
 
 SYNOPSIS
 --------
-'git log --pretty=short | git shortlog'
+'git-log --pretty=short | git shortlog'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -7,7 +7,7 @@ git-show-branch - Show branches and thei
 
 SYNOPSIS
 --------
-'git show-branch [--all] [--heads] [--tags] [--more=<n> | --list | --independent | --merge-base] <reference>...'
+'git-show-branch [--all] [--heads] [--tags] [--more=<n> | --list | --independent | --merge-base] <reference>...'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -8,7 +8,7 @@ git-status - Show working tree status.
 
 SYNOPSIS
 --------
-'git status'
+'git-status'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -8,7 +8,7 @@ git-whatchanged - Show logs with differe
 
 SYNOPSIS
 --------
-'git whatchanged' <option>...
+'git-whatchanged' <option>...
 
 DESCRIPTION
 -----------
