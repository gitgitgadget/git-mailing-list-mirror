From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 52/66] i18n: revert, cherry-pick: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:41 +0700
Message-ID: <1345465975-16927-53-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLn-0000dN-92
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822Ab2HTMoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab2HTMow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dRCPAFaYkbqQdWX+aB0kcSozhILDSQIz7xzawkIXCms=;
        b=FPU7hU+tCsFTP3NXz8s47wGEPAn8MzEj6M9omySHjdy7TmLvu4zr6dv3Q0INnF4zb9
         YL1LrdWyyzelRCIY9Xsxigu1rd4FlFlCcipYQOGdgnAHN7n5CjJS1unhd4uZqjpY4h5o
         FEvchN+WcNbH1MXhNmQcSXP3HsO6BrO8duvL2UE+mdVku/xtwrSeWKqYnb/Vp4gnS1qi
         B70a51AkgVrJkKF4A1O62tDXQL0djSxe09+6isYcUdsv5UWmYPdH3rYuC/4uZ38wVufM
         uxkSUFvjc2x0QEpp2FLEzBWS+QtoDFIMaSuA/7Vx9OsHTTf3W2iA6wUtY4O54CskgvXe
         kQnw==
Received: by 10.66.89.36 with SMTP id bl4mr29349085pab.58.1345466692472;
        Mon, 20 Aug 2012 05:44:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id nv6sm11042967pbc.42.2012.08.20.05.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:52 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203824>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/revert.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..02ca95f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -19,14 +19,14 @@
  */
=20
 static const char * const revert_usage[] =3D {
-	"git revert [options] <commit-ish>",
-	"git revert <subcommand>",
+	N_("git revert [options] <commit-ish>"),
+	N_("git revert <subcommand>"),
 	NULL
 };
=20
 static const char * const cherry_pick_usage[] =3D {
-	"git cherry-pick [options] <commit-ish>",
-	"git cherry-pick <subcommand>",
+	N_("git cherry-pick [options] <commit-ish>"),
+	N_("git cherry-pick <subcommand>"),
 	NULL
 };
=20
@@ -100,18 +100,18 @@ static void parse_args(int argc, const char **arg=
v, struct replay_opts *opts)
 	int contin =3D 0;
 	int rollback =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN(0, "quit", &remove_state, "end revert or cherry-pick seq=
uence"),
-		OPT_BOOLEAN(0, "continue", &contin, "resume revert or cherry-pick se=
quence"),
-		OPT_BOOLEAN(0, "abort", &rollback, "cancel revert or cherry-pick seq=
uence"),
-		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically=
 commit"),
-		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
+		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick =
sequence")),
+		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick=
 sequence")),
+		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick =
sequence")),
+		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, N_("don't automatica=
lly commit")),
+		OPT_BOOLEAN('e', "edit", &opts->edit, N_("edit the commit message"))=
,
 		OPT_NOOP_NOARG('r', NULL),
-		OPT_BOOLEAN('s', "signoff", &opts->signoff, "add Signed-off-by:"),
-		OPT_INTEGER('m', "mainline", &opts->mainline, "parent number"),
+		OPT_BOOLEAN('s', "signoff", &opts->signoff, N_("add Signed-off-by:")=
),
+		OPT_INTEGER('m', "mainline", &opts->mainline, N_("parent number")),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
-		OPT_STRING(0, "strategy", &opts->strategy, "strategy", "merge strate=
gy"),
-		OPT_CALLBACK('X', "strategy-option", &opts, "option",
-			"option for merge strategy", option_parse_x),
+		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge=
 strategy")),
+		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
+			N_("option for merge strategy"), option_parse_x),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -121,10 +121,10 @@ static void parse_args(int argc, const char **arg=
v, struct replay_opts *opts)
=20
 	if (opts->action =3D=3D REPLAY_PICK) {
 		struct option cp_extra[] =3D {
-			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
-			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
-			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initial=
ly empty commits"),
-			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_comm=
its, "keep redundant, empty commits"),
+			OPT_BOOLEAN('x', NULL, &opts->record_origin, N_("append commit name=
")),
+			OPT_BOOLEAN(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
+			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, N_("preserve init=
ially empty commits")),
+			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_comm=
its, N_("keep redundant, empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
--=20
1.7.12.rc2.18.g61b472e
