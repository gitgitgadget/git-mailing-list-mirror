From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Man page section reference should be in uppercase
Date: Tue, 25 May 2010 11:01:24 +0800
Message-ID: <1274756484-27867-1-git-send-email-ayiehere@gmail.com>
Cc: nazri <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 05:35:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGkvN-0004TY-46
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 05:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab0EYDfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 23:35:20 -0400
Received: from raven4.regentmarkets.com ([213.137.29.27]:59276 "EHLO
	raven4.regentmarkets.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758269Ab0EYDfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 23:35:18 -0400
X-Greylist: delayed 2020 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2010 23:35:18 EDT
Received: from mailvz.regentmarkets.com (mindx.regentmarkets.com [202.168.70.162])
	by raven4.regentmarkets.com (Postfix) with SMTP id 1CEA12248208;
	Tue, 25 May 2010 03:01:27 +0000 (UTC)
Received: from mailvz.regentmarkets.com (localhost.localdomain [127.0.0.1])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 96B6938080AD;
	Tue, 25 May 2010 11:01:25 +0800 (MYT)
Received: from nazri (harimau [192.168.12.202])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 895D138080A9;
	Tue, 25 May 2010 11:01:24 +0800 (MYT)
Received: by nazri (sSMTP sendmail emulation); Tue, 25 May 2010 11:01:24 +0800
X-Mailer: git-send-email 1.7.1.rc1.21.gf3bd6
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147658>

From: nazri <ayiehere@gmail.com>

The advice given by git push when doing a non-fast-forward push refers
to the section 'Note about fast-forwards' in the git-push(1) man page.

The section name should really be all in uppercase, as in 'NOTE ABOUT
FAST-FORWARDS' because that is how it is shown by git push --help.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 builtin/push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f4358b9..0694200 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -130,8 +130,8 @@ static int push_with_options(struct transport *transport, int flags)
 
 	if (nonfastforward && advice_push_nonfastforward) {
 		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
-				"Merge the remote changes before pushing again.  See the 'Note about\n"
-				"fast-forwards' section of 'git push --help' for details.\n");
+				"Merge the remote changes before pushing again.  See the 'NOTE ABOUT\n"
+				"FAST-FORWARDS' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
-- 
1.7.1.rc1.21.gf3bd6
