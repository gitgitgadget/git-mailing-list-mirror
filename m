From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] config doc: user.signingkey is also used for signed commits
Date: Mon, 14 Oct 2013 19:04:36 +0200
Message-ID: <1381770276-12062-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 14 19:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVlaF-0007Ht-OK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 19:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab3JNRFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 13:05:01 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:47346 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab3JNRFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 13:05:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id E82A34E6E
	for <git@vger.kernel.org>; Mon, 14 Oct 2013 19:05:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TTyG9d966Qlr; Mon, 14 Oct 2013 19:05:12 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 5BF84489C;
	Mon, 14 Oct 2013 19:05:12 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 250B243920; Mon, 14 Oct 2013 19:04:58 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236105>

The description of the user.signingkey option only mentioned its use
when creating a signed tag. Make it clear that is is also used when
creating signed commits.
---
 Documentation/config.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..50c5add 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2251,11 +2251,11 @@ user.name::
 	environment variables.  See linkgit:git-commit-tree[1].
 
 user.signingkey::
-	If linkgit:git-tag[1] is not selecting the key you want it to
-	automatically when creating a signed tag, you can override the
-	default selection with this variable.  This option is passed
-	unchanged to gpg's --local-user parameter, so you may specify a key
-	using any method that gpg supports.
+	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
+	key you want it to automatically when creating a signed tag or
+	commit, you can override the default selection with this variable.
+	This option is passed unchanged to gpg's --local-user parameter,
+	so you may specify a key using any method that gpg supports.
 
 web.browser::
 	Specify a web browser that may be used by some commands.
-- 
1.8.4
