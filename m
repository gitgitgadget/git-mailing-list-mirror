From: Max Kirillov <max@max630.net>
Subject: [PATCH v3 3/3] Add GIT_COMMON_DIR to local_repo_env
Date: Tue,  9 Dec 2014 06:44:43 +0200
Message-ID: <1418100283-8995-4-git-send-email-max@max630.net>
References: <1418100283-8995-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 05:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyCfl-00014Z-1K
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 05:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbaLIEpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 23:45:08 -0500
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:38567
	"EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756510AbaLIEpH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 23:45:07 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-04.prod.phx3.secureserver.net with 
	id RGkh1p00V5B68XE01Gl4x3; Mon, 08 Dec 2014 21:45:07 -0700
X-Mailer: git-send-email 2.2.0.50.gb2b6831
In-Reply-To: <1418100283-8995-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261110>

This is obviously right thing to do, because submodule repository does
not use common directory of super repository.

Suggested-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Max Kirillov <max@max630.net>
---
 environment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/environment.c b/environment.c
index 8351007..85ce3c4 100644
--- a/environment.c
+++ b/environment.c
@@ -94,6 +94,7 @@ const char * const local_repo_env[] = {
 	CONFIG_DATA_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
+	GIT_COMMON_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
 	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
 	GRAFT_ENVIRONMENT,
-- 
2.2.0.50.gb2b6831
