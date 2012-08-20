From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/66] i18n: merge: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:24 +0700
Message-ID: <1345465975-16927-36-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RK3-0007iW-KS
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab2HTMnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab2HTMnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xQebYkLze/HCv0F33i8NPjJ64nKW++Hrobct9+kjlbA=;
        b=Ddqw9i+ljHydUwmiUrnFqBHwKyGzSKdz8ajC7LOX3Uv3VBLjPooy2kJEwZBGY9w4xG
         93wswD+Zexws/LBO7fPa3tlBY4aG3iDNwZpA6CPRUXQTCZvsG8badUDIj+bjLQavyZqt
         Co0IaW5+0m5bYcpwj9m73CLwUqgp91b3P8kTsx77FrdtNhTXwjq4yMHBqAcVNPYwQElm
         nwQqeC+TONeyBR7DOD/XPi6W4E5JbH+MrDUrx1oyk7nB1TB6jrYbWdjj/0INHhC/5GUI
         fAKC8WzW7/JbywqSkSZl26pfvyRIhCbZxikkMyuZRvdGoczRLWXjJK8K2r5LxN4pKWsK
         ID6g==
Received: by 10.68.138.135 with SMTP id qq7mr34472980pbb.167.1345466582713;
        Mon, 20 Aug 2012 05:43:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id oj8sm11031949pbb.54.2012.08.20.05.42.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:02 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203807>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dd50a0c..e9871ab 100644
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
1.7.12.rc2.18.g61b472e
