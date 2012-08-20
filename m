From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 58/66] i18n: tag: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:47 +0700
Message-ID: <1345465975-16927-59-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMP-000148-97
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab2HTMpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2HTMp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:29 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2157219dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LrqNwksBRIXfdchlo2mpUdg6qWTWq90LZwSeKGc9b80=;
        b=Y6gshSWsSw4PWAsENVF1SMgW7TFM9Gp6ZxQNbt0q843yy9y56H+PVX5gqmEfAonOeN
         faNi4YdvBwDL3aFHjCJfcvug8LrhHiEvzXNGuRyhcjAOxOWJkVhkuyFU57RT6p5UCAl8
         fReRpLzeeuHC3ADx0aicTiZtPENLHAPrkjrOUlgvz5W7CZEGhYPQm8JOvAg2TKclWgxh
         j+uRGkv2YdjipTdyYTbNkkffWkJy9+V7+xDmn0n2HIU3BOpKowoKB8FGkV+F6V7e/6+x
         VHY2y9eqlSRMR0TrHPLU7+1oqYiyFkJN9hW+jF2SFhFMT2zR4NBB3QBGAsOuAASD65Wc
         d9sA==
Received: by 10.68.235.236 with SMTP id up12mr33952671pbc.79.1345466729521;
        Mon, 20 Aug 2012 05:45:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qn13sm11032223pbb.71.2012.08.20.05.45.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:29 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203830>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/tag.c | 56 ++++++++++++++++++++++++++++-----------------------=
-----
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 7b1be85..c581e0a 100644
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
1.7.12.rc2.18.g61b472e
