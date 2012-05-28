From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/65] i18n: column: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:27 +0700
Message-ID: <1338203657-26486-13-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy03-0007kZ-7W
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab2E1LUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2E1LUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2PT5UZY43iyeSLz/e1t7fV+TrAlddicOVUUVjuasgw0=;
        b=iwWifTSgjkBbCLJUHkF6spHsJ7Nhov2N8uqK9K4wp8RD3C5K1SDm+oNMLukaRI4GMU
         bsijKtTm1/BzvnIWrE4Ls4xnY4iWiNFx0uKh6AVwszQkqk5ndvXShGe9m3WYkd76hOOp
         TcAnPWNcuRFZNY9MSAK4EG1BKb1ubfI26kHQpd7kF8u9xcOBW+i9hx90vlsr88fSylpy
         coU6ReezNYauXV5mzmX2jxuOM0kyHX8gNpEADWkbn8OqXl19pmWUEmNRzXRuhTUhbAM7
         c2EImjAw14m8TTE0mAOUXuC15yy1VOd14OIJqnzEgOJ1t9qks1DDDG68eMuGTZpL41I+
         B1WA==
Received: by 10.68.202.234 with SMTP id kl10mr26834497pbc.108.1338204014037;
        Mon, 28 May 2012 04:20:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id tt5sm14835901pbc.12.2012.05.28.04.20.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:09 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198652>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/column.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index 5ea798a..e125a55 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -6,7 +6,7 @@
 #include "column.h"
=20
 static const char * const builtin_column_usage[] =3D {
-	"git column [options]",
+	N_("git column [options]"),
 	NULL
 };
 static unsigned int colopts;
@@ -23,13 +23,13 @@ int cmd_column(int argc, const char **argv, const c=
har *prefix)
 	struct column_options copts;
 	const char *command =3D NULL, *real_command =3D NULL;
 	struct option options[] =3D {
-		OPT_STRING(0, "command", &real_command, "name", "lookup config vars"=
),
-		OPT_COLUMN(0, "mode", &colopts, "layout to use"),
-		OPT_INTEGER(0, "raw-mode", &colopts, "layout to use"),
-		OPT_INTEGER(0, "width", &copts.width, "Maximum width"),
-		OPT_STRING(0, "indent", &copts.indent, "string", "Padding space on l=
eft border"),
-		OPT_INTEGER(0, "nl", &copts.nl, "Padding space on right border"),
-		OPT_INTEGER(0, "padding", &copts.padding, "Padding space between col=
umns"),
+		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup confi=
g vars")),
+		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
+		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
+		OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
+		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding spa=
ce on left border")),
+		OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border"))=
,
+		OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between =
columns")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
