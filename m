From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/65] i18n: merge: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:48 +0700
Message-ID: <1338203657-26486-34-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2n-0002od-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab2E1LXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2E1LXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:20 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o5uvXYd1gE7APaF7jbetuYugDkWj96Tjq0RMUvnQtDI=;
        b=o2wueeIgJ9WOoO8KEgCRxZ1YOu5BPeZ1YZI8HbVgrMn6ELeE92mBGWUic1UG+vtdux
         h3ilk+0NetYBaC+HRImfkm4vuhy2ErPTOP30O7ZTtvxSDeRLZeu2Ebm24ZUvBqAb6ltS
         AU3ZJ70S+hdLCYfJ8YPgfmVnONesM/KlYzhHmtd1pLrddjtDk816LSsl/cizrY61vZd0
         zvmh1xd8E7mWWWJ60xDONNUcVrSpf7YPcUrwbimwse/1iXb7hNUMTJzhiQJYXC0Jf/Nh
         4m96O4Quz5eb9687mU1cCw3B8EdGYglBaJjiexz1Lqysi2AMyjyDE5cBHRBLlXYeIPTR
         FUjg==
Received: by 10.68.225.69 with SMTP id ri5mr26195278pbc.147.1338204200224;
        Mon, 28 May 2012 04:23:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id pi8sm1030878pbb.32.2012.05.28.04.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:14 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198672>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 470fc57..9b0d37b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -40,9 +40,9 @@ struct strategy {
 };
=20
 static const char * const builtin_merge_usage[] =3D {
-	"git merge [options] [<commit>...]",
-	"git merge [options] <msg> HEAD <commit>",
-	"git merge --abort",
+	N_("git merge [options] [<commit>...]"),
+	N_("git merge [options] <msg> HEAD <commit>"),
+	N_("git merge --abort"),
 	NULL
 };
=20
@@ -180,39 +180,39 @@ static int option_parse_n(const struct option *op=
t,
=20
 static struct option builtin_merge_options[] =3D {
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
-		"do not show a diffstat at the end of the merge",
+		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG, option_parse_n },
 	OPT_BOOLEAN(0, "stat", &show_diffstat,
-		"show a diffstat at the end of the merge"),
-	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
-	{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
-	  "add (at most <n>) entries from shortlog to merge commit message",
+		N_("show a diffstat at the end of the merge")),
+	OPT_BOOLEAN(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
+	{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
+	  N_("add (at most <n>) entries from shortlog to merge commit message=
"),
 	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 	OPT_BOOLEAN(0, "squash", &squash,
-		"create a single commit instead of doing a merge"),
+		N_("create a single commit instead of doing a merge")),
 	OPT_BOOLEAN(0, "commit", &option_commit,
-		"perform a commit if the merge succeeds (default)"),
+		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
-		"edit message before committing"),
+		N_("edit message before committing")),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
-		"allow fast-forward (default)"),
+		N_("allow fast-forward (default)")),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
-		"abort if fast-forward is not possible"),
+		N_("abort if fast-forward is not possible")),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
-		"merge strategy to use", option_parse_strategy),
-	OPT_CALLBACK('X', "strategy-option", &xopts, "option=3Dvalue",
-		"option for selected merge strategy", option_parse_x),
-	OPT_CALLBACK('m', "message", &merge_msg, "message",
-		"merge commit message (for a non-fast-forward merge)",
+	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
+		N_("merge strategy to use"), option_parse_strategy),
+	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=3Dvalue"),
+		N_("option for selected merge strategy"), option_parse_x),
+	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
+		N_("merge commit message (for a non-fast-forward merge)"),
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
-		"abort the current in-progress merge"),
-	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting"=
, 1),
-	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
-	  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, "update ignored=
 files (default)"),
+		N_("abort the current in-progress merge")),
+	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporti=
ng"), 1),
+	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
+	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, N_("update igno=
red files (default)")),
 	OPT_END()
 };
=20
--=20
1.7.10.2.549.g9354186
