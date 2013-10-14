From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] rev-parse doc: clarify use of optional / required arguments
Date: Mon, 14 Oct 2013 16:23:31 +0200
Message-ID: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 14 16:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVj3e-0008Sx-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 16:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab3JNOXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 10:23:39 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:45278 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3JNOXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 10:23:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 66A00489C
	for <git@vger.kernel.org>; Mon, 14 Oct 2013 16:23:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6Z3k8MiIb9oY; Mon, 14 Oct 2013 16:23:50 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 8A83547B6;
	Mon, 14 Oct 2013 16:23:50 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 4EB8F43920; Mon, 14 Oct 2013 16:23:36 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236102>

"the option is optional" was confusing as it is not the option but its
argument which is optional.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-rev-parse.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2b126c0..7ec9221 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -259,9 +259,10 @@ Each line of options has this format:
 
 `<flags>`::
 	`<flags>` are of `*`, `=`, `?` or `!`.
-	* Use `=` if the option takes an argument.
+	* Use `=` if the option requires an argument.
 
-	* Use `?` to mean that the option is optional (though its use is discouraged).
+	* Use `?` if the option takes an optional argument (though its use is
+	  discouraged).
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
-- 
1.8.4
