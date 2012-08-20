From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/66] i18n: format-patch: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:12 +0700
Message-ID: <1345465975-16927-24-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RIl-0006oB-LC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab2HTMlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2HTMlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:41:44 -0400
Received: by pbbrr13 with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gmfUaoAkNASAvqPJrLiqdowq1TOvNVdJ9El5U8rLj2U=;
        b=YGCRbpvYkDgDROj2tTyuj2b6wPdtVu7Xoev2Ecz7VgNk4X/hmE/rxfg1YxDiT0gv1k
         ei88f1bYQ94NaXQkXrZdOEtVKPXRxuwsMKROqndSGLOnA8s1Ra8+AdHu0WyWVMGlQ3zv
         IcXDh4ec4oQJhNjmHhyoiEGN9eTJW6mQkwH/B9MhvVeTsMqs5n09Jyuu29mIICrcgtVB
         h1PjDx7acARhqH1+E6BlIRqVWd8TpD7YOZmiqOJwtsuU59Q/6EiZ/pRehMiYKpOU5CFz
         gcIlb6N7sMY0i3MmwAbTAuUOYoJpBIbgRLLVzhA5y7kkWuhiIaKQWkmLEw84lAixObEg
         LhcQ==
Received: by 10.66.81.202 with SMTP id c10mr18109940pay.80.1345466503939;
        Mon, 20 Aug 2012 05:41:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id hr1sm11041949pbc.23.2012.08.20.05.41.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:41:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:35:43 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203795>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 66 +++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index dcd3e13..ba59110 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -890,7 +890,7 @@ static const char *set_outdir(const char *prefix, c=
onst char *output_directory)
 }
=20
 static const char * const builtin_format_patch_usage[] =3D {
-	"git format-patch [options] [<since> | <revision range>]",
+	N_("git format-patch [options] [<since> | <revision range>]"),
 	NULL
 };
=20
@@ -1063,61 +1063,61 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
 	char *branch_name =3D NULL;
 	const struct option builtin_format_patch_options[] =3D {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
-			    "use [PATCH n/m] even with a single patch",
+			    N_("use [PATCH n/m] even with a single patch"),
 			    PARSE_OPT_NOARG, numbered_callback },
 		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
-			    "use [PATCH] even with multiple patches",
+			    N_("use [PATCH] even with multiple patches"),
 			    PARSE_OPT_NOARG, no_numbered_callback },
-		OPT_BOOLEAN('s', "signoff", &do_signoff, "add Signed-off-by:"),
+		OPT_BOOLEAN('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
 		OPT_BOOLEAN(0, "stdout", &use_stdout,
-			    "print patches to standard out"),
+			    N_("print patches to standard out")),
 		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
-			    "generate a cover letter"),
+			    N_("generate a cover letter")),
 		OPT_BOOLEAN(0, "numbered-files", &numbered_files,
-			    "use simple number sequence for output file names"),
-		OPT_STRING(0, "suffix", &fmt_patch_suffix, "sfx",
-			    "use <sfx> instead of '.patch'"),
+			    N_("use simple number sequence for output file names")),
+		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
+			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
-			    "start numbering patches at <n> instead of 1"),
-		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, "prefix",
-			    "Use [<prefix>] instead of [PATCH]",
+			    N_("start numbering patches at <n> instead of 1")),
+		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
+			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
 		{ OPTION_CALLBACK, 'o', "output-directory", &output_directory,
-			    "dir", "store resulting files in <dir>",
+			    N_("dir"), N_("store resulting files in <dir>"),
 			    PARSE_OPT_NONEG, output_directory_callback },
 		{ OPTION_CALLBACK, 'k', "keep-subject", &rev, NULL,
-			    "don't strip/add [PATCH]",
+			    N_("don't strip/add [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
 		OPT_BOOLEAN(0, "no-binary", &no_binary_diff,
-			    "don't output binary diffs"),
+			    N_("don't output binary diffs")),
 		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
-			    "don't include a patch matching a commit upstream"),
+			    N_("don't include a patch matching a commit upstream")),
 		{ OPTION_BOOLEAN, 'p', "no-stat", &use_patch_format, NULL,
-		  "show patch format instead of default (patch + stat)",
+		  N_("show patch format instead of default (patch + stat)"),
 		  PARSE_OPT_NONEG | PARSE_OPT_NOARG },
-		OPT_GROUP("Messaging"),
-		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
-			    "add email header", 0, header_callback },
-		{ OPTION_CALLBACK, 0, "to", NULL, "email", "add To: header",
+		OPT_GROUP(N_("Messaging")),
+		{ OPTION_CALLBACK, 0, "add-header", NULL, N_("header"),
+			    N_("add email header"), 0, header_callback },
+		{ OPTION_CALLBACK, 0, "to", NULL, N_("email"), N_("add To: header"),
 			    0, to_callback },
-		{ OPTION_CALLBACK, 0, "cc", NULL, "email", "add Cc: header",
+		{ OPTION_CALLBACK, 0, "cc", NULL, N_("email"), N_("add Cc: header"),
 			    0, cc_callback },
-		OPT_STRING(0, "in-reply-to", &in_reply_to, "message-id",
-			    "make first mail a reply to <message-id>"),
-		{ OPTION_CALLBACK, 0, "attach", &rev, "boundary",
-			    "attach the patch", PARSE_OPT_OPTARG,
+		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
+			    N_("make first mail a reply to <message-id>")),
+		{ OPTION_CALLBACK, 0, "attach", &rev, N_("boundary"),
+			    N_("attach the patch"), PARSE_OPT_OPTARG,
 			    attach_callback },
-		{ OPTION_CALLBACK, 0, "inline", &rev, "boundary",
-			    "inline the patch",
+		{ OPTION_CALLBACK, 0, "inline", &rev, N_("boundary"),
+			    N_("inline the patch"),
 			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			    inline_callback },
-		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
-			    "enable message threading, styles: shallow, deep",
+		{ OPTION_CALLBACK, 0, "thread", &thread, N_("style"),
+			    N_("enable message threading, styles: shallow, deep"),
 			    PARSE_OPT_OPTARG, thread_callback },
-		OPT_STRING(0, "signature", &signature, "signature",
-			    "add a signature"),
+		OPT_STRING(0, "signature", &signature, N_("signature"),
+			    N_("add a signature")),
 		OPT_BOOLEAN(0, "quiet", &quiet,
-			    "don't print the patch filenames"),
+			    N_("don't print the patch filenames")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
