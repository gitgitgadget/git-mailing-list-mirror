From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/66] i18n: commit: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:04 +0700
Message-ID: <1345465975-16927-16-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHf-00067A-1L
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab2HTMkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab2HTMke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DXnDSrPQNfe2gFPbjQbgt5xsBcvt9WZIhdXwFQa+24w=;
        b=v0TCg66pFtDyymL0lN2xGRsX1klOCoN6yHj5qLDOkpnBOxrvQaagmTeAEpfnFOwLaw
         XDGFoYfDXZlA4933RCfR+IJcUBBaYnVX6Uqez30h/XBjYCX6f6x2DUPHnHmKVN3lo7xd
         IOEoOWmeH6U64hqTb50AuXwOY4EHO0ep0T7auCmOWeQvt7sMsa+nqCqYX0OREjCzEb9n
         yfwPMD3vGwNLxBpSMG3pefo/JvEz1ucO5gGi0t2DvkPu90018V1zCHJtV6ZTKRm6W9dh
         Ue/fnsB95moE28bN9bGSjghCaC8eFNKqdrrdZdfm6BE5JcdsCU8A6keJYLact3OYKand
         L3/A==
Received: by 10.66.75.104 with SMTP id b8mr29450917paw.21.1345466434608;
        Mon, 20 Aug 2012 05:40:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ou6sm10582503pbc.9.2012.08.20.05.40.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:34 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203787>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 78 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 20cef95..33b78fe 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,7 +30,7 @@
 #include "column.h"
=20
 static const char * const builtin_commit_usage[] =3D {
-	"git commit [options] [--] <filepattern>...",
+	N_("git commit [options] [--] <filepattern>..."),
 	NULL
 };
=20
@@ -1188,7 +1188,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "whe=
n",
 		  "ignore changes to submodules, optional when: all, dirty, untracke=
d. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		OPT_COLUMN(0, "column", &s.colopts, "list untracked files in columns=
"),
+		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in colu=
mns")),
 		OPT_END(),
 	};
=20
@@ -1369,53 +1369,53 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 {
 	static struct wt_status s;
 	static struct option builtin_commit_options[] =3D {
-		OPT__QUIET(&quiet, "suppress summary after successful commit"),
-		OPT__VERBOSE(&verbose, "show diff in commit message template"),
-
-		OPT_GROUP("Commit message options"),
-		OPT_FILENAME('F', "file", &logfile, "read message from file"),
-		OPT_STRING(0, "author", &force_author, "author", "override author fo=
r commit"),
-		OPT_STRING(0, "date", &force_date, "date", "override date for commit=
"),
-		OPT_CALLBACK('m', "message", &message, "message", "commit message", =
opt_parse_m),
-		OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse an=
d edit message from specified commit"),
-		OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse mess=
age from specified commit"),
-		OPT_STRING(0, "fixup", &fixup_message, "commit", "use autosquash for=
matted message to fixup specified commit"),
-		OPT_STRING(0, "squash", &squash_message, "commit", "use autosquash f=
ormatted message to squash specified commit"),
-		OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is aut=
hored by me now (used with -C/-c/--amend)"),
-		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-		OPT_FILENAME('t', "template", &template_file, "use specified templat=
e file"),
-		OPT_BOOL('e', "edit", &edit_flag, "force edit of commit"),
-		OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spac=
es and #comments from message"),
-		OPT_BOOLEAN(0, "status", &include_status, "include status in commit =
message template"),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
-		  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
+		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+
+		OPT_GROUP(N_("Commit message options")),
+		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
+		OPT_STRING(0, "author", &force_author, N_("author"), N_("override au=
thor for commit")),
+		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for=
 commit")),
+		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit mes=
sage"), opt_parse_m),
+		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("r=
euse and edit message from specified commit")),
+		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reu=
se message from specified commit")),
+		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosqu=
ash formatted message to fixup specified commit")),
+		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autos=
quash formatted message to squash specified commit")),
+		OPT_BOOLEAN(0, "reset-author", &renew_authorship, N_("the commit is =
authored by me now (used with -C/-c/--amend)")),
+		OPT_BOOLEAN('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_FILENAME('t', "template", &template_file, N_("use specified temp=
late file")),
+		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
+		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to str=
ip spaces and #comments from message")),
+		OPT_BOOLEAN(0, "status", &include_status, N_("include status in comm=
it message template")),
+		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
+		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
=20
-		OPT_GROUP("Commit contents options"),
-		OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
-		OPT_BOOLEAN('i', "include", &also, "add specified files to index for=
 commit"),
-		OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files=
"),
-		OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add cha=
nges"),
-		OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
-		OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
-		OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
-		OPT_SET_INT(0, "short", &status_format, "show status concisely",
+		OPT_GROUP(N_("Commit contents options")),
+		OPT_BOOLEAN('a', "all", &all, N_("commit all changed files")),
+		OPT_BOOLEAN('i', "include", &also, N_("add specified files to index =
for commit")),
+		OPT_BOOLEAN(0, "interactive", &interactive, N_("interactively add fi=
les")),
+		OPT_BOOLEAN('p', "patch", &patch_interactive, N_("interactively add =
changes")),
+		OPT_BOOLEAN('o', "only", &only, N_("commit only specified files")),
+		OPT_BOOLEAN('n', "no-verify", &no_verify, N_("bypass pre-commit hook=
")),
+		OPT_BOOLEAN(0, "dry-run", &dry_run, N_("show what would be committed=
")),
+		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
-		OPT_BOOLEAN(0, "branch", &s.show_branch, "show branch information"),
+		OPT_BOOLEAN(0, "branch", &s.show_branch, N_("show branch information=
")),
 		OPT_SET_INT(0, "porcelain", &status_format,
-			    "machine-readable output", STATUS_FORMAT_PORCELAIN),
+			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
-			    "terminate entries with NUL"),
-		OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
-		OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rew=
rite hook"),
-		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode=
", "show untracked files, optional modes: all, normal, no. (Default: al=
l)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+			    N_("terminate entries with NUL")),
+		OPT_BOOLEAN(0, "amend", &amend, N_("amend previous commit")),
+		OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-=
rewrite hook")),
+		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("m=
ode"), N_("show untracked files, optional modes: all, normal, no. (Defa=
ult: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
=20
 		{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
-		  "ok to record an empty change",
+		  N_("ok to record an empty change"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		{ OPTION_BOOLEAN, 0, "allow-empty-message", &allow_empty_message, NU=
LL,
-		  "ok to record a change with an empty message",
+		  N_("ok to record a change with an empty message"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
=20
 		OPT_END()
--=20
1.7.12.rc2.18.g61b472e
