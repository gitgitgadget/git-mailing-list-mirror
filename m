From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Fix typo in remote set-head usage
Date: Sun, 25 Nov 2012 14:43:39 +0100
Message-ID: <1353851019-27254-1-git-send-email-apelisse@gmail.com>
Cc: tim.henigan@gmail.com, Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 14:44:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TccVE-0007u8-18
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 14:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab2KYNnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 08:43:52 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60669 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab2KYNnv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 08:43:51 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so3043131wer.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kYd6NXhRIwAvUN8i+0soZgQ6zZgmQ/BzbJgkID9DIkY=;
        b=wz3y7uQjqD0FnjP6yijCLRWaKlYreUceHVQTil1uGwNzMHxpVWXHHu7Rb4so3My1nA
         Tej9yUGbgl3Lba8jcbNH6WTB7pcMNMtHnhLWMCTtisxthLMilZczz8TKxoph18BxWEF/
         Wth9VmY22KVJOC2J71vTRQDRJvzpwrlN1/JbB6lciVrXLHLtzddqMRUyjOiZ25YLHj/G
         T7CXGq91Q/UvjFcwXUiYNQytDG5VhMAHkaz82HUnMmwaE4ldoaoLb6FX4KvK8d4NX+Rh
         xdInZIsp4+7iJ/aDL0v/4yMwo4/dxfXakpI2RU9EiCRTJyV7wH340JBCU2YokFTBQuVe
         cuCg==
Received: by 10.216.202.73 with SMTP id c51mr3349388weo.102.1353851030333;
        Sun, 25 Nov 2012 05:43:50 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id en20sm19035078wid.4.2012.11.25.05.43.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 05:43:49 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210369>

parenthesis are not matching in `builtin_remote_sethead_usage`
as a square bracket is closing something never opened.
---
This will also break all translation files, should I also send a patch
to update them ?

Cheers,
Antoine Pelisse

 builtin/remote.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index a5a4b23..937484d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -39,7 +39,7 @@ static const char * const builtin_remote_rm_usage[] = {
 };

 static const char * const builtin_remote_sethead_usage[] = {
-	N_("git remote set-head <name> (-a | -d | <branch>])"),
+	N_("git remote set-head <name> (-a | -d | <branch>)"),
 	NULL
 };

--
1.7.9.5
