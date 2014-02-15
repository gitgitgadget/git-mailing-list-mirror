From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Provide a 'git help user-manual' route to the docbook
Date: Sat, 15 Feb 2014 13:51:39 +0000
Message-ID: <1392472299-3780-2-git-send-email-philipoakley@iee.org>
References: <1392472299-3780-1-git-send-email-philipoakley@iee.org>
Cc: Thomas Ackermann <th.acker@arcor.de>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Bracey <kevin@bracey.fi>,
	=?UTF-8?q?Ondrej=20B=C3=ADlka?= <neleai@seznam.cz>,
	Phil Hord <hordp@cisco.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 14:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEfex-00044x-Ta
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 14:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbaBONvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 08:51:37 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:5843 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087AbaBONv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 08:51:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmEGAORv/1JZ8YjN/2dsb2JhbABZgwbAS4ENF3SCJgEFViMQCEk5HgYTiAnJGhePAQeEOASqT4MtPA
X-IPAS-Result: AmEGAORv/1JZ8YjN/2dsb2JhbABZgwbAS4ENF3SCJgEFViMQCEk5HgYTiAnJGhePAQeEOASqT4MtPA
X-IronPort-AV: E=Sophos;i="4.95,850,1384300800"; 
   d="scan'208";a="601178034"
Received: from host-89-241-136-205.as13285.net (HELO localhost) ([89.241.136.205])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 15 Feb 2014 13:51:28 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1392472299-3780-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242193>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/Makefile           |  1 +
 Documentation/gituser-manual.txt | 34 ++++++++++++++++++++++++++++++++++
 builtin/help.c                   |  1 +
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/gituser-manual.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fc6b2cf..657523f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,6 +31,7 @@ MAN7_TXT += gitnamespaces.txt
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
