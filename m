From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/65] i18n: notes: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:52 +0700
Message-ID: <1338203657-26486-38-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy3N-0003Xk-7E
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab2E1LX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2E1LXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XeZ/kfHpiuvc2kvA3/d41WbNQmx3BA8fCFa57Z8w2S8=;
        b=O3xDIWMvSYK9HvmohZAJ5i8jO2XKHVlNTen4tEzZXicfz8oVpdTeIoP5i69qtVSXPx
         7Sn03bXSv7fYJIZiofcIdOEkBznmGLBGfRRtIZ4EMswx1yeL49tItf3uBmuSdjrkqF65
         vyCJSBtVuwCM+k01uIfLcAWnve/sNlrM3suJec2hJLNU/lEqIXxzhlcKZEMHRoryaGx7
         QZs1rB4AyrfJc5ormS0KqWWkZWtG5iPlQ4V7nnEAJg834w02vYTekAfXe2sI6hxeJwJ8
         Na8MFH+McXs4SIwbgmlKK4mqqBOEE+PlQGSmohzDnpT3Xhxfx2O/gEVI9bFuICknaZrM
         lpRA==
Received: by 10.68.130.9 with SMTP id oa9mr26484870pbb.95.1338204235720;
        Mon, 28 May 2012 04:23:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id wi8sm19012800pbc.11.2012.05.28.04.23.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:49 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198676>

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
1.7.10.2.549.g9354186
