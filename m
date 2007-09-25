From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] gitattributes.txt: Remove a duplicated paragraph about 'ident' and 'crlf' interaction.
Date: Tue, 25 Sep 2007 15:05:28 +0200
Message-ID: <11907255291239-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 15:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaArR-00073Z-8m
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 15:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbXIYNxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 09:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXIYNxz
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 09:53:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50673 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbXIYNxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 09:53:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaA6U-0006UJ-GP; Tue, 25 Sep 2007 15:05:30 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB3D2546; Tue, 25 Sep 2007 15:05:29 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 5D697FA46; Tue, 25 Sep 2007 15:05:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.gcc9e
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59122>

The order in which 'ident' and 'crlf' are carried out is documented a few paragraphs
later again, after 'filter' was introduced.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	I don't have the tools to check whether the formatting is still correct.

	-- Hannes

 Documentation/gitattributes.txt |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d0e951e..168a598 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -145,17 +145,6 @@ sign `$` upon checkout.  Any byte sequence that begins with
 with `$Id$` upon check-in.
 
 
-Interaction between checkin/checkout attributes
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-In the check-in codepath, the worktree file is first converted
-with `ident` (if specified), and then with `crlf` (again, if
-specified and applicable).
-
-In the check-out codepath, the blob content is first converted
-with `crlf`, and then `ident`.
-
-
 `filter`
 ^^^^^^^^
 
-- 
1.5.3.3.gcc9e
