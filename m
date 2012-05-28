From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 59/65] i18n: tag: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:11 +0700
Message-ID: <1338203657-26486-57-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6C-0007EM-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab2E1L0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab2E1L0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:51 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KMuGxFYFwBRH3HjgftYym6sN7NAKBgvw7s6g0QK1Luw=;
        b=Tm9NAS9HYuTw400vahaejguD8NC1fJIMBqldHTWvoBsYnKZkOdQgFE/dm+h2Kn83YF
         5rhGCSpj4DSqAD8kx9AdsgzxotSZPWRePiMvw6M21Bmy5Q2nmWQYp+j0nY3D+2yFYBhk
         Ec5vJCiwav5qQaiTOyhBRFHcoi79j9vAlNfLZGt/F9Tt2Hn7QUpkfB8sTT3jMu0e0oLU
         fueOKbB8SgmB9NtOcJCvsCgfX0GG+ioz67OBNNlSsQ2wpUiN19MEu+mM9RcnQryo9s+I
         WqROmH5xGFAU4yB8zS6xrU27tCCH6STM7ozOXnD6RkHniU7ptcWYCJeKTPKfLjAiU35h
         EeCw==
Received: by 10.68.219.166 with SMTP id pp6mr25391333pbc.35.1338204411677;
        Mon, 28 May 2012 04:26:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ru4sm18993001pbc.66.2012.05.28.04.26.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:46 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198695>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/tag.c | 56 ++++++++++++++++++++++++++++-----------------------=
-----
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4fb6bd7..326fe5f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,11 +19,11 @@
 #include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
-	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
-	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] =
"
-		"\n\t\t[<pattern>...]",
-	"git tag -v <tagname>...",
+	N_("git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [=
<head>]"),
+	N_("git tag -d <tagname>..."),
+	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object=
>] "
+		"\n\t\t[<pattern>...]"),
+	N_("git tag -v <tagname>..."),
 	NULL
 };
=20
@@ -444,37 +444,37 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
 	struct option options[] =3D {
-		OPT_BOOLEAN('l', "list", &list, "list tag names"),
-		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
-				"print <n> lines of each tag message",
+		OPT_BOOLEAN('l', "list", &list, N_("list tag names")),
+		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
+				N_("print <n> lines of each tag message"),
 				PARSE_OPT_OPTARG, NULL, 1 },
-		OPT_BOOLEAN('d', "delete", &delete, "delete tags"),
-		OPT_BOOLEAN('v', "verify", &verify, "verify tags"),
+		OPT_BOOLEAN('d', "delete", &delete, N_("delete tags")),
+		OPT_BOOLEAN('v', "verify", &verify, N_("verify tags")),
=20
-		OPT_GROUP("Tag creation options"),
+		OPT_GROUP(N_("Tag creation options")),
 		OPT_BOOLEAN('a', "annotate", &annotate,
-					"annotated tag, needs a message"),
-		OPT_CALLBACK('m', "message", &msg, "message",
-			     "tag message", parse_msg_arg),
-		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
-		OPT_BOOLEAN('s', "sign", &opt.sign, "annotated and GPG-signed tag"),
-		OPT_STRING(0, "cleanup", &cleanup_arg, "mode",
-			"how to strip spaces and #comments from message"),
-		OPT_STRING('u', "local-user", &keyid, "key-id",
-					"use another key to sign the tag"),
-		OPT__FORCE(&force, "replace the tag if exists"),
-		OPT_COLUMN(0, "column", &colopts, "show tag list in columns"),
-
-		OPT_GROUP("Tag listing options"),
+					N_("annotated tag, needs a message")),
+		OPT_CALLBACK('m', "message", &msg, N_("message"),
+			     N_("tag message"), parse_msg_arg),
+		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
+		OPT_BOOLEAN('s', "sign", &opt.sign, N_("annotated and GPG-signed tag=
")),
+		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
+			N_("how to strip spaces and #comments from message")),
+		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
+					N_("use another key to sign the tag")),
+		OPT__FORCE(&force, N_("replace the tag if exists")),
+		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
+
+		OPT_GROUP(N_("Tag listing options")),
 		{
-			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
-			"print only tags that contain the commit",
+			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
+			N_("print only tags that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
-			OPTION_CALLBACK, 0, "points-at", NULL, "object",
-			"print only tags of the object", 0, parse_opt_points_at
+			OPTION_CALLBACK, 0, "points-at", NULL, N_("object"),
+			N_("print only tags of the object"), 0, parse_opt_points_at
 		},
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186
