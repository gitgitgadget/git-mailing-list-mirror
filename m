From: bfields@fieldses.org
Subject: [PATCH 4/5] Documentation: rewrite the core-tutorial introduction
Date: Mon, 29 May 2006 19:31:35 -0400
Message-ID: <11489454963586-git-send-email-bfields@fieldses.org>
References: <11489454963995-git-send-email-bfields@fieldses.org>
Reply-To: bfields@fieldses.org
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 01:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkrDe-0001en-5z
	for gcvg-git@gmane.org; Tue, 30 May 2006 01:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWE2XcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 19:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWE2XcK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 19:32:10 -0400
Received: from c-68-40-201-198.hsd1.mi.comcast.net ([68.40.201.198]:19114 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751303AbWE2XcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 19:32:09 -0400
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FkrCy-0005L0-SG; Mon, 29 May 2006 19:31:36 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g2506
In-Reply-To: <11489454963995-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20995>

From: J. Bruce Fields <bfields@citi.umich.edu>

Revise for conciseness, clarify the intended audience.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

3bb93812a96e602729e52ab1ac5a555f453470be
 Documentation/core-tutorial.txt |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

3bb93812a96e602729e52ab1ac5a555f453470be
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5a831ad..3ab3317 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -4,35 +4,23 @@ A git core tutorial for developers
 Introduction
 ------------
 
-This is trying to be a short tutorial on setting up and using a git
-repository, mainly because being hands-on and using explicit examples is
-often the best way of explaining what is going on.
+If you primarily interested in using git to manage your own projects,
+see link:tutorial.txt[A tutorial introduction to git] before reading
+this.
 
-In normal life, most people wouldn't use the "core" git programs
-directly, but rather script around them to make them more palatable. 
-Understanding the core git stuff may help some people get those scripts
-done, though, and it may also be instructive in helping people
-understand what it is that the higher-level helper scripts are actually
-doing. 
+However, git also provides commands that provide low-level access to
+git internals.  These "core" git commands will be useful to advanced
+users, to git hackers, and to anyone developing software on top of
+the git core.
 
 The core git is often called "plumbing", with the prettier user
 interfaces on top of it called "porcelain". You may not want to use the
 plumbing directly very often, but it can be good to know what the
 plumbing does for when the porcelain isn't flushing.
 
-The material presented here often goes deep describing how things
-work internally.  If you are mostly interested in using git as a
-SCM, you can skip them during your first pass.
-
-[NOTE]
-And those "too deep" descriptions are often marked as Note.
-
 [NOTE]
-If you are already familiar with another version control system,
-like CVS, you may want to take a look at
-link:everyday.html[Everyday GIT in 20 commands or so] first
-before reading this.
-
+Notes like this mark descriptions of deep git internals that can
+be skipped on a first reading.
 
 Creating a git repository
 -------------------------
-- 
1.3.3.gff62
