From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 4/5] Documentation update for user-relative paths.
Date: Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Message-ID: <20051117193714.3E2CE5C7F7@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZR-0000hg-Jp
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVKQThS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKQThR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:37:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37082 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964810AbVKQThP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:15 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 8F5DB6BD16
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3E2CE5C7F7; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12145>


Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/pull-fetch-param.txt |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

applies-to: bf9b22933b23acc5301a1e1adce47f70dd5f4ede
96781c24c886e2a563b5fb95bc9ec1073f92cb97
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ddd5823..a7628aa 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -5,11 +5,30 @@
 	to name the remote repository:
 +
 ===============================================================
-- Rsync URL:		rsync://remote.machine/path/to/repo.git/
-- HTTP(s) URL:		http://remote.machine/path/to/repo.git/
-- git URL:		git://remote.machine/path/to/repo.git/
-- ssh URL:		remote.machine:/path/to/repo.git/
-- Local directory:	/path/to/repo.git/
+- rsync://host.xz/path/to/repo.git/
+- http://host.xz/path/to/repo.git/
+- https://host.xz/path/to/repo.git/
+- git://host.xz/path/to/repo.git/
+- ssh://host.xz/path/to/repo.git/
+- ssh://host.xz/~user/path/to/repo.git/
+- ssh://host.xz/~/path/to/repo.git
+===============================================================
++
+	SSH Is the default transport protocol and also supports an
+	scp-like syntax.  Both syntaxes support username expansion.
+	The following three are identical to the last three above,
+	respectively:
++
+===============================================================
+- host.xz:/path/to/repo.git/
+- host.xz:~user/path/to/repo.git/
+- host.xz:path/to/repo.git
+===============================================================
++
+       To sync with a local directory, use:
+
+===============================================================
+- /path/to/repo.git/
 ===============================================================
 +
 In addition to the above, as a short-hand, the name of a
---
0.99.9.GIT
