From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/5] Documentation/diff-config: fix description of diff.renames
Date: Tue, 23 Feb 2016 18:44:54 +0100
Message-ID: <1456249498-3232-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1Q-0000wx-W1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbcBWRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:12 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47023 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636AbcBWRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:09 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj49R021468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:04 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MU012979;
	Tue, 23 Feb 2016 18:45:06 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 18:45:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj49R021468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854305.63824@JntaWwFQ0HwKiuH7+XOi6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287092>

The description was misleading, since "set to any boolean value" include
"set to false", and diff.renames=false does not enable basic detection,
but actually disables it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-config.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa452..1acd203 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -108,9 +108,10 @@ diff.renameLimit::
 	detection; equivalent to the 'git diff' option '-l'.
 
 diff.renames::
-	Tells Git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enable.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to false.
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
-- 
2.7.2.334.g35ed2ae.dirty
