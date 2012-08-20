From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/66] i18n: notes: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:28 +0700
Message-ID: <1345465975-16927-40-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKR-00080d-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab2HTMna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Paecmzi0r0MB+Q4tj5kqDBCWihrJ2U3ZA8wCo/8jZqo=;
        b=O9tjFCvWxUoqMzeEvLFv5KW6XWtzjB1FzxbgislYVChe8bpgbZwnJR394unsVdv/VH
         0uwkjNR1bl7p4CrKlGmBZhXQMPRTmDIqLENJU7DH1EFGpRzcFDQP66RA2WmHw3jR3g1D
         GaGAmnGOGuGqWZaFf8qjpX3pC+K+Ve5XyHyjxFGv7FJU0yU3sG4GVDn1lkpmoALAsJH+
         iUAOdavM5bKblUvKlAZBCL48yE98RRMn7h2GJA7V1GlnEE/OMjnwyFgfuagzxMMFBd9h
         4oPqSHPLFBeOzvULWnvqzeci/IXwwg7VyG/EuEmE5zBz8NzwOEeZj/aKn8VK8DLkWco7
         bs5Q==
Received: by 10.68.234.98 with SMTP id ud2mr33842692pbc.165.1345466608543;
        Mon, 20 Aug 2012 05:43:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qr2sm11044407pbc.35.2012.08.20.05.43.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:28 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203811>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c | 120 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..423c6e8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,71 +20,71 @@
 #include "notes-merge.h"
=20
 static const char * const git_notes_usage[] =3D {
-	"git notes [--ref <notes_ref>] [list [<object>]]",
-	"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c |=
 -C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>",
-	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -=
C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] edit [<object>]",
-	"git notes [--ref <notes_ref>] show [<object>]",
-	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <note=
s_ref>",
-	"git notes merge --commit [-v | -q]",
-	"git notes merge --abort [-v | -q]",
-	"git notes [--ref <notes_ref>] remove [<object>...]",
-	"git notes [--ref <notes_ref>] prune [-n | -v]",
-	"git notes [--ref <notes_ref>] get-ref",
+	N_("git notes [--ref <notes_ref>] [list [<object>]]"),
+	N_("git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-=
c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>=
"),
+	N_("git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c =
| -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes_ref>] edit [<object>]"),
+	N_("git notes [--ref <notes_ref>] show [<object>]"),
+	N_("git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <n=
otes_ref>"),
+	N_("git notes merge --commit [-v | -q]"),
+	N_("git notes merge --abort [-v | -q]"),
+	N_("git notes [--ref <notes_ref>] remove [<object>...]"),
+	N_("git notes [--ref <notes_ref>] prune [-n | -v]"),
+	N_("git notes [--ref <notes_ref>] get-ref"),
 	NULL
 };
=20
 static const char * const git_notes_list_usage[] =3D {
-	"git notes [list [<object>]]",
+	N_("git notes [list [<object>]]"),
 	NULL
 };
=20
 static const char * const git_notes_add_usage[] =3D {
-	"git notes add [<options>] [<object>]",
+	N_("git notes add [<options>] [<object>]"),
 	NULL
 };
=20
 static const char * const git_notes_copy_usage[] =3D {
-	"git notes copy [<options>] <from-object> <to-object>",
-	"git notes copy --stdin [<from-object> <to-object>]...",
+	N_("git notes copy [<options>] <from-object> <to-object>"),
+	N_("git notes copy --stdin [<from-object> <to-object>]..."),
 	NULL
 };
=20
 static const char * const git_notes_append_usage[] =3D {
-	"git notes append [<options>] [<object>]",
+	N_("git notes append [<options>] [<object>]"),
 	NULL
 };
=20
 static const char * const git_notes_edit_usage[] =3D {
-	"git notes edit [<object>]",
+	N_("git notes edit [<object>]"),
 	NULL
 };
=20
 static const char * const git_notes_show_usage[] =3D {
-	"git notes show [<object>]",
+	N_("git notes show [<object>]"),
 	NULL
 };
=20
 static const char * const git_notes_merge_usage[] =3D {
-	"git notes merge [<options>] <notes_ref>",
-	"git notes merge --commit [<options>]",
-	"git notes merge --abort [<options>]",
+	N_("git notes merge [<options>] <notes_ref>"),
+	N_("git notes merge --commit [<options>]"),
+	N_("git notes merge --abort [<options>]"),
 	NULL
 };
=20
 static const char * const git_notes_remove_usage[] =3D {
-	"git notes remove [<object>]",
+	N_("git notes remove [<object>]"),
 	NULL
 };
=20
 static const char * const git_notes_prune_usage[] =3D {
-	"git notes prune [<options>]",
+	N_("git notes prune [<options>]"),
 	NULL
 };
=20
 static const char * const git_notes_get_ref_usage[] =3D {
-	"git notes get-ref",
+	N_("git notes get-ref"),
 	NULL
 };
=20
@@ -531,19 +531,19 @@ static int add(int argc, const char **argv, const=
 char *prefix)
 	const unsigned char *note;
 	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
 	struct option options[] =3D {
-		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
-			"note contents as a string", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'm', "message", &msg, N_("msg"),
+			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, "file",
-			"note contents in a file", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
+			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "object",
-			"reuse and edit specified note object", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, N_("object"),
+			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "object",
-			"reuse specified note object", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
+			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
-		OPT__FORCE(&force, "replace existing notes"),
+		OPT__FORCE(&force, N_("replace existing notes")),
 		OPT_END()
 	};
=20
@@ -611,11 +611,11 @@ static int copy(int argc, const char **argv, cons=
t char *prefix)
 	struct notes_tree *t;
 	const char *rewrite_cmd =3D NULL;
 	struct option options[] =3D {
-		OPT__FORCE(&force, "replace existing notes"),
-		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
-		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
-			   "load rewriting config for <command> (implies "
-			   "--stdin)"),
+		OPT__FORCE(&force, N_("replace existing notes")),
+		OPT_BOOLEAN(0, "stdin", &from_stdin, N_("read objects from stdin")),
+		OPT_STRING(0, "for-rewrite", &rewrite_cmd, N_("command"),
+			   N_("load rewriting config for <command> (implies "
+			      "--stdin)")),
 		OPT_END()
 	};
=20
@@ -688,17 +688,17 @@ static int append_edit(int argc, const char **arg=
v, const char *prefix)
 	const char * const *usage;
 	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
 	struct option options[] =3D {
-		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
-			"note contents as a string", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'm', "message", &msg, N_("msg"),
+			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &msg, "file",
-			"note contents in a file", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
+			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "object",
-			"reuse and edit specified note object", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, N_("object"),
+			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
 			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "object",
-			"reuse specified note object", PARSE_OPT_NONEG,
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, N_("object"),
+			N_("reuse specified note object"), PARSE_OPT_NONEG,
 			parse_reuse_arg},
 		OPT_END()
 	};
@@ -861,19 +861,19 @@ static int merge(int argc, const char **argv, con=
st char *prefix)
 	int verbosity =3D 0, result;
 	const char *strategy =3D NULL;
 	struct option options[] =3D {
-		OPT_GROUP("General options"),
+		OPT_GROUP(N_("General options")),
 		OPT__VERBOSITY(&verbosity),
-		OPT_GROUP("Merge options"),
-		OPT_STRING('s', "strategy", &strategy, "strategy",
-			   "resolve notes conflicts using the given strategy "
-			   "(manual/ours/theirs/union/cat_sort_uniq)"),
-		OPT_GROUP("Committing unmerged notes"),
+		OPT_GROUP(N_("Merge options")),
+		OPT_STRING('s', "strategy", &strategy, N_("strategy"),
+			   N_("resolve notes conflicts using the given strategy "
+			      "(manual/ours/theirs/union/cat_sort_uniq)")),
+		OPT_GROUP(N_("Committing unmerged notes")),
 		{ OPTION_BOOLEAN, 0, "commit", &do_commit, NULL,
-			"finalize notes merge by committing unmerged notes",
+			N_("finalize notes merge by committing unmerged notes"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
-		OPT_GROUP("Aborting notes merge resolution"),
+		OPT_GROUP(N_("Aborting notes merge resolution")),
 		{ OPTION_BOOLEAN, 0, "abort", &do_abort, NULL,
-			"abort notes merge",
+			N_("abort notes merge"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_END()
 	};
@@ -980,10 +980,10 @@ static int remove_cmd(int argc, const char **argv=
, const char *prefix)
 	int from_stdin =3D 0;
 	struct option options[] =3D {
 		OPT_BIT(0, "ignore-missing", &flag,
-			"attempt to remove non-existent note is not an error",
+			N_("attempt to remove non-existent note is not an error"),
 			IGNORE_MISSING),
 		OPT_BOOLEAN(0, "stdin", &from_stdin,
-			    "read object names from the standard input"),
+			    N_("read object names from the standard input")),
 		OPT_END()
 	};
 	struct notes_tree *t;
@@ -1064,8 +1064,8 @@ int cmd_notes(int argc, const char **argv, const =
char *prefix)
 	int result;
 	const char *override_notes_ref =3D NULL;
 	struct option options[] =3D {
-		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
-			   "use notes from <notes_ref>"),
+		OPT_STRING(0, "ref", &override_notes_ref, N_("notes_ref"),
+			   N_("use notes from <notes_ref>")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
