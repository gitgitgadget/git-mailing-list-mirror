From: sgala@marlow.memojo.com
Subject: [PATCH] gitk: One \t missing in the help file (for <Return>)
Date: Mon, 24 Mar 2008 09:16:53 +0100
Message-ID: <1206346613-29382-1-git-send-email-sgala@apache.org>
Cc: Santiago Gala <sgala@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 09:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdhsO-0006Zf-TI
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 09:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYCXIQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 04:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbYCXIQ7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 04:16:59 -0400
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233]:2736
	"EHLO mail.hisitech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751816AbYCXIQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 04:16:58 -0400
Received: by mail.hisitech.com (Postfix, from userid 65534)
	id 0286115CC71; Mon, 24 Mar 2008 09:16:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	webserver2.intranet.hisitech.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	NO_REAL_NAME autolearn=ham version=3.1.9
Received: from marlow.memojo.com (unknown [172.27.70.188])
	by mail.hisitech.com (Postfix) with SMTP id 55EAB15CC39;
	Mon, 24 Mar 2008 09:16:51 +0100 (CET)
Received: by marlow.memojo.com (sSMTP sendmail emulation); Mon, 24 Mar 2008 09:16:53 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78009>

Add it in the source and the Italian translation,
the German translation does not have the string. The
Spanish translation already contains it. Without it
the formatting of the help page is not right here.

Signed-off-by: Santiago Gala <sgala@apache.org>
---
 gitk-git/gitk     |    2 +-
 gitk-git/po/it.po |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 84ab02e..6fe454b 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1370,7 +1370,7 @@ proc keys {} {
 [mc "d		Scroll diff view down 18 lines"]
 [mc "<%s-F>		Find" $M1T]
 [mc "<%s-G>		Move to next find hit" $M1T]
-[mc "<Return>	Move to next find hit"]
+[mc "<Return>		Move to next find hit"]
 [mc "/		Move to next find hit, or redo find"]
 [mc "?		Move to previous find hit"]
 [mc "f		Scroll diff view to next file"]
diff --git a/gitk-git/po/it.po b/gitk-git/po/it.po
index d0f4c2e..e4d49ea 100644
--- a/gitk-git/po/it.po
+++ b/gitk-git/po/it.po
@@ -389,8 +389,8 @@ msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tTrova in avanti"
 
 #: gitk:1373
-msgid "<Return>\tMove to next find hit"
-msgstr "<Return>\tTrova in avanti"
+msgid "<Return>\t\tMove to next find hit"
+msgstr "<Return>\t\tTrova in avanti"
 
 #: gitk:1374
 msgid "/\t\tMove to next find hit, or redo find"
-- 
1.5.4.4
