From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] Document 'git (rev-list|log) --merges'
Date: Mon, 13 Jul 2009 17:11:44 +0200
Message-ID: <0f4a962e946f68ec0d7a4c2e568fb3e5ae2a10bc.1247497864.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 17:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQNCL-0005rM-EA
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 17:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbZGMPMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbZGMPL7
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 11:11:59 -0400
Received: from francis.fzi.de ([141.21.7.5]:14664 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756093AbZGMPL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 11:11:59 -0400
Received: from [127.0.1.1] ([141.21.12.127]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 17:11:54 +0200
X-Mailer: git-send-email 1.6.4.rc0.78.g75597
X-OriginalArrivalTime: 13 Jul 2009 15:11:54.0038 (UTC) FILETIME=[417CA560:01CA03CC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123196>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index 1c9cc28..a765cfa 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	     [ \--max-age=3Dtimestamp ]
 	     [ \--min-age=3Dtimestamp ]
 	     [ \--sparse ]
+	     [ \--merges ]
 	     [ \--no-merges ]
 	     [ \--first-parent ]
 	     [ \--remove-empty ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 11eec94..bf66116 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -201,6 +201,10 @@ endif::git-rev-list[]
=20
 	Stop when a given path disappears from the tree.
=20
+--merges::
+
+	Print only merge commits.
+
 --no-merges::
=20
 	Do not print commits with more than one parent.
--=20
1.6.4.rc0.78.g75597
