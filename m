From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] [PATCH] Provide a release-notes man page / guide
Date: Sat, 15 Feb 2014 10:29:39 +0000
Message-ID: <1392460179-776-2-git-send-email-philipoakley@iee.org>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=Stefan Nwe <stefan.naewe@atlas-elektronik.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 11:29:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEcVE-0005f6-5s
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 11:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaBOK3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 05:29:35 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:49042 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447AbaBOK3c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 05:29:32 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmIGAIhA/1JZ8YjN/2dsb2JhbABZgwY4wBKBDRd0giYBBVYjEAhJOR4GE4gJCchkEwSPAQeEOASqT4MtPA
X-IPAS-Result: AmIGAIhA/1JZ8YjN/2dsb2JhbABZgwY4wBKBDRd0giYBBVYjEAhJOR4GE4gJCchkEwSPAQeEOASqT4MtPA
X-IronPort-AV: E=Sophos;i="4.95,850,1384300800"; 
   d="scan'208";a="444905309"
Received: from host-89-241-136-205.as13285.net (HELO localhost) ([89.241.136.205])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 15 Feb 2014 10:29:31 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
In-Reply-To: <1392460179-776-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242184>

Use the symlinked RelNote file as a list-block to
act as the core of the release-notes man page.

The mantainers work load should not be affected.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

The included lines are inset 11 spaces by the man page
asciidoc formatting so some are more than 80 characters long.
No negative indent mechanism for the list block was found -
suggestions welcomed.

The use of the stalenotes section from git(1) was rejected.

The stalenotes, with over two hundred links, has greater than
2 digits allowed in the trailing link list on the man page,
so would miss the hundreds digit.

Also the html links for the "documentation for release x.y.z"
(at kerenel.org) are to html files that are not actually made
by the makefile.
---
 Documentation/Makefile             |  1 +
 Documentation/gitrelease-notes.txt | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/gitrelease-notes.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fc6b2cf..b599b1f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -29,6 +29,7 @@ MAN7_TXT += gitdiffcore.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
+MAN7_TXT += gitrelease-notes.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
diff --git a/Documentation/gitrelease-notes.txt b/Documentation/gitrelease-notes.txt
new file mode 100644
index 0000000..29d9b1b
--- /dev/null
+++ b/Documentation/gitrelease-notes.txt
@@ -0,0 +1,37 @@
+gitrelease-notes(7)
+===================
+
+NAME
+----
+gitrelease-notes - the onward progress of the stupid content tracker
+
+
+SYNOPSIS
+--------
+[verse]
+'git help release-notes'
+
+DESCRIPTION
+-----------
+
+Provide the release notes for the latest (possibly
+unreleased) version of Git, that is available from 'master'
+branch of the `git.git` repository.
+
+RELEASE NOTES
+-------------
+
+----
+include::../RelNotes[]
+----
+
+OLDER RELEASE NOTES
+-------------------
+
+Release notes for older versions are available in the Git source
+Documentation/RelNotes/ folder. This is currently available at
+https://code.google.com/p/git-core/source/browse/
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.8.3.msysgit.0
