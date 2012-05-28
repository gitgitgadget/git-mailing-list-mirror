From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/65] i18n: format-patch: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:36 +0700
Message-ID: <1338203657-26486-22-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy16-0000jl-TL
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab2E1LVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:34 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2E1LVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:33 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yQM2qUOR0gZvlTMD9X/lJxf7Y94ZoPAAv6NrWUZs7cA=;
        b=vVSS2KvmZ/xgda22iBZNkBddzBvQ7fabzB3GpvLtp4L/tUjQqz0F/oOg5paAi/ZCFs
         f/Ps7xAIrPFzzXOsoIZYGSCL/6QLk+yA8ajHqvrZpe1di3yICBjInM6LYirlDhmyXUOU
         bjppDEkwE3mpZ9WYqeOVbj0KW0MjpBvz8knd5xy1ttv9cq8qI50khdSrWtiXbkIdUrOH
         2Z41sxIY4udOkV9P7uABolLMr/esXkKaTPSGF1KqaytsHCV9u/00rOboyQpbX6fpl4Ba
         uLbm4wwB5mEALQzn2FwBhe263NjoqHIXRaUcFo6CJSfNpj8P8f7n5rg0HXZi7J3gs6k+
         JlZA==
Received: by 10.68.190.131 with SMTP id gq3mr3247816pbc.17.1338204093052;
        Mon, 28 May 2012 04:21:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id rv8sm18987094pbc.64.2012.05.28.04.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:27 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198660>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 66 +++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6282ed2..da54ce9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -910,7 +910,7 @@ static const char *set_outdir(const char *prefix, c=
onst char *output_directory)
 }
=20
 static const char * const builtin_format_patch_usage[] =3D {
-	"git format-patch [options] [<since> | <revision range>]",
+	N_("git format-patch [options] [<since> | <revision range>]"),
 	NULL
 };
=20
@@ -1083,61 +1083,61 @@ int cmd_format_patch(int argc, const char **arg=
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
1.7.10.2.549.g9354186
