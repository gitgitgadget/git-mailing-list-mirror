From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Mon, 28 Apr 2014 17:51:32 +0400
Message-ID: <1398693097-24651-8-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Welyy-0004FV-6Q
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbaD1NwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:52:23 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56253 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbaD1Nvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:53 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyH-0004qo-Pg; Mon, 28 Apr 2014 17:51:50 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247334>

HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
msysGit, they're general MinGW settings.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index dc87e21..2f1939e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -521,13 +521,13 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
 else
 	NO_CURL = YesPlease
 endif
+	HAVE_LIBCHARSET_H = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
-- 
1.9.1
