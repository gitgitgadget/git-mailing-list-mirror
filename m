From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Provide a 'git help user-manual' route to the docbook
Date: Wed, 15 Jan 2014 23:10:52 +0000
Message-ID: <1389827452-3896-2-git-send-email-philipoakley@iee.org>
References: <1389827452-3896-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 00:10:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ZbY-0008Lt-K2
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbaAOXKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:10:30 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:54051 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752768AbaAOXK0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 18:10:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjIQAM0U11ICYJQD/2dsb2JhbABZgwtIA4JvuF8LgQYXdIImAQVWMwhJOR4GE4gIwzIXjwYuhAkEqjWDLTw
X-IPAS-Result: AjIQAM0U11ICYJQD/2dsb2JhbABZgwtIA4JvuF8LgQYXdIImAQVWMwhJOR4GE4gIwzIXjwYuhAkEqjWDLTw
X-IronPort-AV: E=Sophos;i="4.95,665,1384300800"; 
   d="scan'208";a="452300167"
Received: from host-2-96-148-3.as13285.net (HELO localhost) ([2.96.148.3])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 15 Jan 2014 23:10:24 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1389827452-3896-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240487>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/Makefile           |  1 +
 Documentation/gituser-manual.txt | 34 ++++++++++++++++++++++++++++++++++
 builtin/help.c                   |  1 +
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/gituser-manual.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36c58fc..3793e4c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,7 @@ MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
+MAN7_TXT += gituser-manual.txt
 MAN7_TXT += gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
diff --git a/Documentation/gituser-manual.txt b/Documentation/gituser-manual.txt
new file mode 100644
index 0000000..9fd4744
--- /dev/null
+++ b/Documentation/gituser-manual.txt
@@ -0,0 +1,34 @@
+gituser-manual(7)
+=================
+
+NAME
+----
+gituser-manual - a link to the user-manual docbook
+
+
+SYNOPSIS
+--------
+[verse]
+'git help user-manual'
+
+link:user-manual.html[Git User's Manual]
+
+DESCRIPTION
+-----------
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
+
+The link:user-manual.html[Git User's Manual] provides an
+in-depth introduction to Git.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7],
+linkgit:giteveryday[7],
+linkgit:gitcli[7],
+linkgit:gitworkflows[7]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin/help.c b/builtin/help.c
index 1fdefeb..be7c39d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -427,6 +427,7 @@ static struct {
 	{ "modules", N_("Defining submodule properties") },
 	{ "revisions", N_("Specifying revisions and ranges for Git") },
 	{ "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 or newer)") },
+	{ "user-manual", N_("A link to the user-manual docbook") },
 	{ "workflows", N_("An overview of recommended workflows with Git") },
 };
 
-- 
1.8.3.msysgit.0
