From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/65] i18n: commit: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:28 +0700
Message-ID: <1338203657-26486-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzz-0007c8-AL
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab2E1LUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab2E1LUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RXB0rvSdNltRklQM8o7x0ypOUlp8pB1RLfACW5RXZAc=;
        b=ZuxDMh/h6YcOl9XTYrXEum1b9Ofnb9AKoDeOAa1avjvvfR+XIXC5jiV87kKZb75lS7
         TG1DuZTnPdpexCAvmOHd3YsUmbpS7aPVilBPeTt4cE05TLUW9q1cEvIyXYGZgzi8XACQ
         CA0T59tFOW9VyCf1fOnL8FsA7HUcIt4pQGiG7ymu6eow6yyqOuGggPswpGO3xZP+XR/r
         3I46caBy3l0uNYK414mqi5yz+8NBjFpLQlzzlrqIcE6vmC0wwMJtFo8FIQ7R5xjwInZL
         p+xnic15Y5VhultdcQKTuqH0wF4tleNMW9ep2uAfCYxtr9H7BGaadkxOD+vlJB5siEAG
         k/aQ==
Received: by 10.68.233.193 with SMTP id ty1mr26555805pbc.47.1338204022221;
        Mon, 28 May 2012 04:20:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ok6sm9656655pbb.29.2012.05.28.04.20.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:17 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198651>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 76 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a2ec73d..34d723b 100644
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
@@ -1367,53 +1367,53 @@ int cmd_commit(int argc, const char **argv, con=
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
1.7.10.2.549.g9354186
