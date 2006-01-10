From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] glossary: explain "master" and "origin"
Date: Tue, 10 Jan 2006 22:26:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102226130.649@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jan 10 22:26:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwR10-0007JK-O7
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWAJV0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWAJV0s
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:26:48 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4037 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932353AbWAJV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 16:26:47 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE824141335; Tue, 10 Jan 2006 22:26:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id D2B519C8;
	Tue, 10 Jan 2006 22:26:46 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id B183A901;
	Tue, 10 Jan 2006 22:26:46 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9EC2E141335; Tue, 10 Jan 2006 22:26:46 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14458>


If you are a long time git user/developer, you forget that to a new git
user, these words have not the same meaning as to you.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/glossary.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 2331be5..4ef7d2a 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -111,6 +111,17 @@ branch::
 	a particular revision, which is called the branch head. The
 	branch heads are stored in `$GIT_DIR/refs/heads/`.
 
+master::
+	The default branch. Whenever you create a git repository, a branch
+	named "master" is created, and becomes the active branch. In most
+	cases, this contains the local development.
+
+origin::
+	The default upstream branch. Most projects have one upstream 
+        project which is tracked, and augmented with local changes which
+        eventually get merged back. You never commit to this branch,
+	unless you are maintaining the upstream project.
+
 ref::
 	A 40-byte hex representation of a SHA1 pointing to a particular
 	object. These may be stored in `$GIT_DIR/refs/`.
