From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] gitattributes.txt: Be more to the point in the filter driver description.
Date: Tue, 25 Sep 2007 15:05:29 +0200
Message-ID: <1190725529394-git-send-email-johannes.sixt@telecom.at>
References: <11907255291239-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 25 15:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaAkP-0004D9-Vr
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 15:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbXIYNqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 09:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbXIYNqh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 09:46:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3394 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXIYNqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 09:46:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaA6U-0006J4-GZ; Tue, 25 Sep 2007 15:05:30 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EDCE8C6C3; Tue, 25 Sep 2007 15:05:29 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 89E1BFA43; Tue, 25 Sep 2007 15:05:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.gcc9e
In-Reply-To: <11907255291239-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59120>

The description was meant to emphasizes that the project should remain
usable even if the filter driver was not used. This makes it more explicit
and removes the "here is rope to hang yourself" paraphrase.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/gitattributes.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 168a598..20cf8ff 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -164,11 +164,10 @@ but makes the filter a no-op passthru.
 The content filtering is done to massage the content into a
 shape that is more convenient for the platform, filesystem, and
 the user to use.  The keyword here is "more convenient" and not
-"turning something unusable into usable".  In other words, it is
-"hanging yourself because we gave you a long rope" if your
-project uses filtering mechanism in such a way that it makes
-your project unusable unless the checkout is done with a
-specific filter in effect.
+"turning something unusable into usable".  In other words, the
+intent is that if someone unsets the filter driver definition,
+or does not have the appropriate filter program, the project
+should still be usable.
 
 
 Interaction between checkin/checkout attributes
-- 
1.5.3.3.gcc9e
