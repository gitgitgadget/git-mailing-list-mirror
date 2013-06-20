From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] send-email: Fix documentation of --signed-off-by-cc option
Date: Thu, 20 Jun 2013 17:26:51 +0900
Message-ID: <1371716811-12043-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	Namhyung Kim <namhyung.kim@lge.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaDP-0000ao-Op
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab3FTI1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:27:30 -0400
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:62670 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab3FTI1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 04:27:18 -0400
X-AuditID: 9c930179-b7c30ae0000047e1-43-51c2bce4bf2e
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id 8E.70.18401.4ECB2C15; Thu, 20 Jun 2013 17:27:16 +0900 (KST)
X-Mailer: git-send-email 1.7.11.7
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228449>

From: Namhyung Kim <namhyung.kim@lge.com>

The man page says it'll control the Cc: lines being added also,
but this is not true.

Reported-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 Documentation/git-send-email.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 40a9a9a..5694d98 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -238,7 +238,7 @@ Automating
 	the value of 'sendemail.identity'.
 
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
+	If this is set, add emails found in Signed-off-by: lines to the
 	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
-- 
1.7.11.7
