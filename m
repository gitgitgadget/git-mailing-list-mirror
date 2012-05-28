From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 53/65] i18n: revert, cherry-pick: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:05 +0700
Message-ID: <1338203657-26486-51-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5I-00068e-Eg
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab2E1LZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab2E1LZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:55 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xI3MQCYYJ/7IFqPdAp1UvfnQIAtEf/NREb4hQ5kOaLI=;
        b=aHibKXFQ1u8kpgzV8fwGk8OupLaJjO835sfT3FFLZwTQNi6isMlHcSZ6SYar+JUNe6
         x0ASbncIX1E8xvONs75dwadsQpa2FFracsOGf8fm4D8mtQqxOahkflmsSFjDF8IrIgRU
         2+D+8pIKKsQR9+LO7FVoOQmKQj3IStYnzm9fjcuUDdeH+p/+OCZXhjVnKBxQnpudLL9B
         CPh73dxk0uIm0I+6w12zdNwPQMO6evgIMa4kn3NmQtuJXoZwiiGUuxK/d6pyB9hHCtjk
         8giIzzOeLdbaukM4RvyP4vnt9SqM/PoOJkU4eF9rBvSrT31fyFDGogFCAvmezoyh9aFS
         fydw==
Received: by 10.68.236.129 with SMTP id uu1mr26456494pbc.77.1338204355209;
        Mon, 28 May 2012 04:25:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ud10sm19010460pbc.25.2012.05.28.04.25.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:50 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198689>

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
1.7.10.2.549.g9354186
