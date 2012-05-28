From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 65/65] i18n: write-tree: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:17 +0700
Message-ID: <1338203657-26486-63-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 13:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy71-0008BF-4D
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab2E1L1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52445 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2E1L1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:42 -0400
Received: by pbbrp8 with SMTP id rp8so4545462pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dsoIwFEegeqyc3avE6eTJnZaVd0BWFJMXZ35pvbC7D8=;
        b=sUw0loatIasARfzLT4NAlBfinX1JRWg5DEzNdn40d3cbPXWPkkF5HhmqO1zsMaqHHj
         dr4JHuWrGXcq2z2OODrrWTDhzI5811l/pGEri9YNx01VY4N47dmLM91ddKA/R5HPPuJH
         9kvTeWDYX2wJAwZaJJhL7VKAcIlBBRPDqhWKp4KNaO1iv6ixvg7JUmravbuWLbA/0IFf
         gVhw2a6ZJpb7cM7ph1ZMZ5UAAaYZygaxNu8hdN77RONKrm5IfI99udlhSXD0cMBOAk8H
         2OIr22UU7OuwlZ/93ArEPUBEExfcybQAL/+LqnGqKzc7CUFgmUshxfUoREUrns0pNZv0
         PUDg==
Received: by 10.68.226.99 with SMTP id rr3mr26491250pbc.48.1338204461856;
        Mon, 28 May 2012 04:27:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id uz7sm19015044pbc.35.2012.05.28.04.27.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:27:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:23:36 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198702>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/write-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..084c0df 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
=20
 static const char * const write_tree_usage[] =3D {
-	"git write-tree [--missing-ok] [--prefix=3D<prefix>/]",
+	N_("git write-tree [--missing-ok] [--prefix=3D<prefix>/]"),
 	NULL
 };
=20
@@ -21,13 +21,13 @@ int cmd_write_tree(int argc, const char **argv, con=
st char *unused_prefix)
 	unsigned char sha1[20];
 	const char *me =3D "git-write-tree";
 	struct option write_tree_options[] =3D {
-		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
+		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
 			WRITE_TREE_MISSING_OK),
-		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
-		  "write tree object for a subdirectory <prefix>" ,
+		{ OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
+		  N_("write tree object for a subdirectory <prefix>") ,
 		  PARSE_OPT_LITERAL_ARGHELP },
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
-		  "only useful for debugging",
+		  N_("only useful for debugging"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
 		  WRITE_TREE_IGNORE_CACHE_TREE },
 		OPT_END()
--=20
1.7.10.2.549.g9354186
