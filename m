From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Further clarify clean.requireForce changes
Date: Mon, 19 Nov 2007 09:06:31 +0100
Message-ID: <1195459591-7929-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 09:07:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1ej-0000PG-G3
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 09:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXKSIGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 03:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbXKSIGk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 03:06:40 -0500
Received: from wincent.com ([72.3.236.74]:48435 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbXKSIGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 03:06:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAJ86VYp011426;
	Mon, 19 Nov 2007 02:06:33 -0600
X-Mailer: git-send-email 1.5.3.5.737.gdee1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65412>

Mention the -f switch in the release notes for clean.requireForce to avoid
possible misunderstandings.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/RelNotes-1.5.4.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index 96ec55e..a4a2a7f 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -33,8 +33,9 @@ Updates since v1.5.3
    too many loose objects.
 
  * You need to explicitly set clean.requireForce to "false" to allow
-   git-clean to do any damage (lack of the configuration variable
-   used to mean "do not require", but we now use the safer default).
+   git-clean without -f to do any damage (lack of the configuration
+   variable used to mean "do not require", but we now use the safer
+   default).
 
  * git-push has been rewritten in C.
 
-- 
1.5.3.5.737.gdee1b
