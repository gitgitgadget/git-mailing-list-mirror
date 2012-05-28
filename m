From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/65] i18n: fast-export: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:32 +0700
Message-ID: <1338203657-26486-18-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy10-0000aY-CU
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2E1LVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab2E1LU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=w6tTh/pNCKV8GcNWeRa6b+45pzRFVgIfvJdIugeP7pk=;
        b=sxeQL1YyeTKHBaW0Ll1oc6GJxKR1fBVx8vQBIx97ZO4DkrQ9EGB4f0G4k73EXqD9jv
         hyuNKfX8PxLE6t9e3Py85zC7gvZIYx7ZO3AcU6SBDOg++ezOW6L9Hk2jCFcppSO5LLml
         sSky9itQpJd/t0k687tVufgsDfec1PU+l+iY+uqzuvA/3IjL+47AwUUcfH//D8v/sQkZ
         ii7hTbbySiAJ4Pf36EeqvOIsR8I3sPMZvZ+WffuEoFlARdtvoj12fwdclmRCqm9oh8wt
         3GSyt9M0vzSxcLIxX8B28fcIdHMpflOVe3DCpdkRMJ/jOmcuwr5VrlittWgZhGcRW8PU
         LE/w==
Received: by 10.68.238.71 with SMTP id vi7mr26639837pbc.159.1338204058656;
        Mon, 28 May 2012 04:20:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id jw3sm6306066pbc.65.2012.05.28.04.20.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:53 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198657>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fast-export.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 19509ea..65217eb 100644
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
@@ -630,24 +630,24 @@ int cmd_fast_export(int argc, const char **argv, =
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
1.7.10.2.549.g9354186
