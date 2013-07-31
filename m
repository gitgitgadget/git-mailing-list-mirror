From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Rename advice.object_name_warning to objectNameWarning
Date: Wed, 31 Jul 2013 22:23:31 +0200
Message-ID: <bc52a7d4a5f1010e6813ddf503a0b84976dc55e4.1375301985.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4cvp-00007G-3r
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab3GaUXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:23:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:29057 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757067Ab3GaUXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:23:32 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:23:26 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 22:23:31 +0200
X-Mailer: git-send-email 1.8.4.rc0.408.gad6868d
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231454>

We spell config variables in camelCase instead of with_underscores.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

I figure since we don't have the variable in any release yet *and* the
worst possible outcome is that someone sees the advice message again,
the consistency is worth the change.


 advice.c    | 2 +-
 sha1_name.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 2a52098..3eca9f5 100644
--- a/advice.c
+++ b/advice.c
@@ -35,7 +35,7 @@
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
 	{ "setupstreamfailure", &advice_set_upstream_failure },
-	{ "object_name_warning", &advice_object_name_warning },
+	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
 
 	/* make this an alias for backward compatibility */
diff --git a/sha1_name.c b/sha1_name.c
index 1d210e3..852dd95 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -445,7 +445,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	"\n"
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 	"examine these refs and maybe delete them. Turn this message off by\n"
-	"running \"git config advice.object_name_warning false\"");
+	"running \"git config advice.objectNameWarning false\"");
 	unsigned char tmp_sha1[20];
 	char *real_ref = NULL;
 	int refs_found = 0;
-- 
1.8.4.rc0.408.gad6868d
