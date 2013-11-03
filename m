From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 6/8] rebase: don't try to match -M option
Date: Sun,  3 Nov 2013 16:54:22 +0100
Message-ID: <1383494064-5653-7-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd012-0007zG-JU
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab3KCPy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:57 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35797 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab3KCPyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 6DDDB4E74
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MW0b5kkcJbwA; Sun,  3 Nov 2013 16:55:06 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 6F40248C2;
	Sun,  3 Nov 2013 16:55:05 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 0BDDD43938; Sun,  3 Nov 2013 16:54:49 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237264>

The -M option does not exist in OPTIONS_SPEC, so there is no use to try
to find it.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6b9279a69028..2f2f8ded5c3f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -259,7 +259,7 @@ do
 	--no-autosquash)
 		autosquash=
 		;;
-	-M|-m)
+	-m)
 		do_merge=t
 		;;
 	-X)
-- 
1.8.4.2
