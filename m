From: jdl@freescale.com
Subject: [PATCH] Fix typos and minor format issues.
Date: Tue, 29 Nov 2005 08:59:56 -0600
Message-ID: <E1Eh6xY-0007ul-NI@jdl.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 16:13:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh6xo-0003xP-KC
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 16:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVK2PAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 10:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVK2PAI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 10:00:08 -0500
Received: from mail.jdl.com ([66.118.10.122]:18108 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751371AbVK2PAH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 10:00:07 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1Eh6xY-0007ul-NI
	for git@vger.kernel.org; Tue, 29 Nov 2005 08:59:57 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12944>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 Documentation/pull-fetch-param.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

applies-to: 116ec987c167ce1489acbe8c1b6161e9e19344f1
6c335b09a1b8348eb750be4a86f1172e1f6d28ac
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 6413d52..b5b9792 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -15,10 +15,10 @@
 - ssh://host.xz/~/path/to/repo.git
 ===============================================================
 +
-	SSH Is the default transport protocol and also supports an
-	scp-like syntax.  Both syntaxes support username expansion,
-	as does the native git protocol. The following three are
-	identical to the last three above, respectively:
+SSH Is the default transport protocol and also supports an
+scp-like syntax.  Both syntaxes support username expansion,
+as does the native git protocol. The following three are
+identical to the last three above, respectively:
 +
 ===============================================================
 - host.xz:/path/to/repo.git/
@@ -26,8 +26,8 @@
 - host.xz:path/to/repo.git
 ===============================================================
 +
-       To sync with a local directory, use:
-
+To sync with a local directory, use:
++
 ===============================================================
 - /path/to/repo.git/
 ===============================================================
@@ -113,7 +113,7 @@ on the remote branch, merge it into your
 `git pull . remote-B`, while you are on `my-B` branch.
 The common `Pull: master:origin` mapping of a remote `master`
 branch to a local `origin` branch, which is then merged to a
-ocal development branch, again typically named `master`, is made
+local development branch, again typically named `master`, is made
 when you run `git clone` for you to follow this pattern.
 +
 [NOTE]
---
0.99.9j
