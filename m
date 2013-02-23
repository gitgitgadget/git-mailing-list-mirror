From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Sat, 23 Feb 2013 23:06:00 +0000
Message-ID: <1361660761-1932-13-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OAs-0004LJ-11
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759309Ab3BWXGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:06:08 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:53174 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758983Ab3BWXGH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:06:07 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAJhKKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBVYzCEk5HgYTiBe+fo8Vg0ADpyKDBw
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="420142128"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:06:06 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216932>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 62dbd9a..dc759a2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,11 +23,13 @@ MAN7_TXT += gitcore-tutorial.txt
 MAN7_TXT += gitcredentials.txt
 MAN7_TXT += gitcvs-migration.txt
 MAN7_TXT += gitdiffcore.txt
+MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
+MAN7_TXT += gituser-manual.txt
 MAN7_TXT += gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
@@ -35,6 +37,8 @@ MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 OBSOLETE_HTML = git-remote-helpers.html
+OBSOLETE_HTML = everyday.html
+OBSOLETE_HTML = user-manual.html
 DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES = howto-index
-- 
1.8.1.msysgit.1
