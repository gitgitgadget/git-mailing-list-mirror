From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git.txt: Fix asciidoc syntax of --*-pathspecs
Date: Mon, 23 Sep 2013 20:54:35 +0200
Message-ID: <1379962475-6880-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBHg-000267-Am
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab3IWSy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:54:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:60105 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab3IWSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:54:55 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id r8NIsp6Z007384;
	Mon, 23 Sep 2013 20:54:51 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id r8NIsp3q007380;
	Mon, 23 Sep 2013 20:54:51 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
X-Miltered: at mailer.zib.de with ID 52408E7B.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 52408E7B.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 52408E7B.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235233>

Labeled lists require a double colon.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5d68d33..4c2757e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -475,19 +475,19 @@ example the following invocations are equivalent:
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
 
---glob-pathspecs:
+--glob-pathspecs::
 	Add "glob" magic to all pathspec. This is equivalent to setting
 	the `GIT_GLOB_PATHSPECS` environment variable to `1`. Disabling
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(literal)"
 
---noglob-pathspecs:
+--noglob-pathspecs::
 	Add "literal" magic to all pathspec. This is equivalent to setting
 	the `GIT_NOGLOB_PATHSPECS` environment variable to `1`. Enabling
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(glob)"
 
---icase-pathspecs:
+--icase-pathspecs::
 	Add "icase" magic to all pathspec. This is equivalent to setting
 	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
 
-- 
1.8.4.477.gfa286b2
