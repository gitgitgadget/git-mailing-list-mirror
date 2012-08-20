From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/66] i18n: column: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:03 +0700
Message-ID: <1345465975-16927-15-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHY-00060d-Qw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab2HTMkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46092 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2HTMk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:29 -0400
Received: by dady13 with SMTP id y13so2154786dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0fc9ChnFj5W4EKxuLLAuqkTCKIue6fBnCQAdiqXdrvE=;
        b=XoyuEP0fWwp7Wk0Ywiu2qE4aacz7O/2y1fkjJkgP7EiKuiurk+sQEccuzusQE3rML2
         ubGn2ur8DdxixF6X7azzC736uTrYcUkbMwwvSHhQyaKtnkXdAkFseOP2LW4vEzUAmTt3
         0scodEi/x5VxUGFYSTvHs0kMIdMG1Y3I1mcz4mz3LmYQMRT3iyeLBkC08Fy38753v/cZ
         hyCDrCezioc9pSpytTqmS/EUZZhH6hpbNaKXHNndyAkI2Un5gmPv8F8hp9wsDiyZhcgk
         zY5d1MhuA91SyDiG63OA5aoGfvSss4jqUeHlTznyr0WQWXvKH6+J9MelJgTIesobE6Eu
         Mj3w==
Received: by 10.68.132.41 with SMTP id or9mr33996072pbb.115.1345466428470;
        Mon, 20 Aug 2012 05:40:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id rm9sm11024705pbc.72.2012.08.20.05.40.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:28 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203786>

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
1.7.12.rc2.18.g61b472e
