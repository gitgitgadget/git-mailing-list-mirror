From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/66] i18n: fast-export: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:08 +0700
Message-ID: <1345465975-16927-20-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:41:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RI3-0006MS-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab2HTMlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab2HTMk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HBlTuYnREuWaTjqhZY+3p0fbS9nXFv/ZrPsgJx7S36I=;
        b=jkpSE3hpGjpAA2eT4iv+l2OXUbuI+0t8+S+jN6cgAVivOwsl9kBtEZoevj8wC/bH1R
         hroVqMZM1T0oDvnC6ChW6DtzpfpJ/LdgdPytZ6JVtCvp7V61reoJErhR8Kb7xrqYOVZX
         n6vg86G7dI3G5sqCDsdBVjWJ07oBtvxPZH66KoAb1iMrlO/AzQZcgPtifuGMkYVxUodF
         4Tq6cml4s2yj/uOl6DxSaaFFOB4QsedjK5kNL+MfIfzFiVrerfHiY5xHBD4GrLrCdJBX
         nu1+OwW5jTQp1+z+iwglNRy4Aam2u4Hkbk3n5/92cqFuRAv5VdYGyg1/vGq9yj0N1d/d
         Qzog==
Received: by 10.68.231.233 with SMTP id tj9mr34080288pbc.39.1345466459302;
        Mon, 20 Aug 2012 05:40:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id hr1sm11040913pbc.23.2012.08.20.05.40.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:59 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203791>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fast-export.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9ab6db3..12220ad 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -19,7 +19,7 @@
 #include "quote.h"
=20
 static const char *fast_export_usage[] =3D {
-	"git fast-export [rev-list-opts]",
+	N_("git fast-export [rev-list-opts]"),
 	NULL
 };
=20
@@ -632,24 +632,24 @@ int cmd_fast_export(int argc, const char **argv, =
const char *prefix)
 	char *export_filename =3D NULL, *import_filename =3D NULL;
 	struct option options[] =3D {
 		OPT_INTEGER(0, "progress", &progress,
-			    "show progress after <n> objects"),
-		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
-			     "select handling of signed tags",
+			    N_("show progress after <n> objects")),
+		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
+			     N_("select handling of signed tags"),
 			     parse_opt_signed_tag_mode),
-		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, "mo=
de",
-			     "select handling of tags that tag filtered objects",
+		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_(=
"mode"),
+			     N_("select handling of tags that tag filtered objects"),
 			     parse_opt_tag_of_filtered_mode),
-		OPT_STRING(0, "export-marks", &export_filename, "file",
-			     "Dump marks to this file"),
-		OPT_STRING(0, "import-marks", &import_filename, "file",
-			     "Import marks from this file"),
+		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
+			     N_("Dump marks to this file")),
+		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
+			     N_("Import marks from this file")),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
-			     "Fake a tagger when tags lack one"),
+			     N_("Fake a tagger when tags lack one")),
 		OPT_BOOLEAN(0, "full-tree", &full_tree,
-			     "Output full tree for each commit"),
+			     N_("Output full tree for each commit")),
 		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
-			     "Use the done feature to terminate the stream"),
-		OPT_BOOL(0, "no-data", &no_data, "Skip output of blob data"),
+			     N_("Use the done feature to terminate the stream")),
+		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
