From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/65] i18n: grep: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:39 +0700
Message-ID: <1338203657-26486-25-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy1V-0001I0-Md
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab2E1LWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab2E1LV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:59 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/84FgCEhYV2CdK1i3LpLxHja1Gpq2CG5kPn2Ebf/zS4=;
        b=mdZ8Kov8XuU5Bmpvd2apnGFhT43yPnBM+2u8ppMnDTRenQHukR674slp9BmYHIjoPn
         0xDHf8NPiWRg2k6BulVXHmvFyyeLsJTfyCDgX5jSutqk9sn/Gv/u4M340CXJrGfJjeHJ
         inueq0iCkFZw7BMlkMOJnM+RXqSMOOkFRiQG1Mm7X/oGBYRMSkbUnnDWaaiik6+p+DFV
         yL4+kBYC1kOJkKH5HMWA+jaDpPuxkEc/zDhoV7RzaoL8sAAmAiUNiWRIXrWQqFr0eo7k
         ipAxZvFzsOuhERgE1Mr4IapeaP4cCHt9raMCy8/Vh6aShZxXe0DpF4X/5VYQxWAs9ziV
         4q3Q==
Received: by 10.68.191.201 with SMTP id ha9mr26916164pbc.75.1338204118971;
        Mon, 28 May 2012 04:21:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id wd10sm18988978pbc.70.2012.05.28.04.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:53 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198663>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 90 +++++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fe1726f..c2dfdb0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -19,7 +19,7 @@
 #include "dir.h"
=20
 static char const * const grep_usage[] =3D {
-	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
+	N_("git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
 };
=20
@@ -680,84 +680,84 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
=20
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
-			"search in index instead of in the work tree"),
+			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
-			 "finds in contents not managed by git", 1),
+			 N_("finds in contents not managed by git"), 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
-			"search in both tracked and untracked files"),
+			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
-			    "search also in ignored files", 1),
+			    N_("search also in ignored files"), 1),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('v', "invert-match", &opt.invert,
-			"show non-matching lines"),
+			N_("show non-matching lines")),
 		OPT_BOOLEAN('i', "ignore-case", &opt.ignore_case,
-			"case insensitive matching"),
+			N_("case insensitive matching")),
 		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
-			"match patterns only at word boundaries"),
+			N_("match patterns only at word boundaries")),
 		OPT_SET_INT('a', "text", &opt.binary,
-			"process binary files as text", GREP_BINARY_TEXT),
+			N_("process binary files as text"), GREP_BINARY_TEXT),
 		OPT_SET_INT('I', NULL, &opt.binary,
-			"don't match patterns in binary files",
+			N_("don't match patterns in binary files"),
 			GREP_BINARY_NOMATCH),
-		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, "depth",
-			"descend at most <depth> levels", PARSE_OPT_NONEG,
+		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
+			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
 		OPT_GROUP(""),
 		OPT_SET_INT('E', "extended-regexp", &pattern_type,
-			    "use extended POSIX regular expressions",
+			    N_("use extended POSIX regular expressions"),
 			    pattern_type_ere),
 		OPT_SET_INT('G', "basic-regexp", &pattern_type,
-			    "use basic POSIX regular expressions (default)",
+			    N_("use basic POSIX regular expressions (default)"),
 			    pattern_type_bre),
 		OPT_SET_INT('F', "fixed-strings", &pattern_type,
-			    "interpret patterns as fixed strings",
+			    N_("interpret patterns as fixed strings"),
 			    pattern_type_fixed),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type,
-			    "use Perl-compatible regular expressions",
+			    N_("use Perl-compatible regular expressions"),
 			    pattern_type_pcre),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
-		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
-		OPT_BIT('H', NULL, &opt.pathname, "show filenames", 1),
+		OPT_BOOLEAN('n', "line-number", &opt.linenum, N_("show line numbers"=
)),
+		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
+		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
-			"show filenames relative to top directory", 1),
+			N_("show filenames relative to top directory"), 1),
 		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
-			"show only filenames instead of matching lines"),
+			N_("show only filenames instead of matching lines")),
 		OPT_BOOLEAN(0, "name-only", &opt.name_only,
-			"synonym for --files-with-matches"),
+			N_("synonym for --files-with-matches")),
 		OPT_BOOLEAN('L', "files-without-match",
 			&opt.unmatch_name_only,
-			"show only the names of files without match"),
+			N_("show only the names of files without match")),
 		OPT_BOOLEAN('z', "null", &opt.null_following_name,
-			"print NUL after filenames"),
+			N_("print NUL after filenames")),
 		OPT_BOOLEAN('c', "count", &opt.count,
-			"show the number of matches instead of matching lines"),
-		OPT__COLOR(&opt.color, "highlight matches"),
+			N_("show the number of matches instead of matching lines")),
+		OPT__COLOR(&opt.color, N_("highlight matches")),
 		OPT_BOOLEAN(0, "break", &opt.file_break,
-			"print empty line between matches from different files"),
+			N_("print empty line between matches from different files")),
 		OPT_BOOLEAN(0, "heading", &opt.heading,
-			"show filename only once above matches from same file"),
+			N_("show filename only once above matches from same file")),
 		OPT_GROUP(""),
-		OPT_CALLBACK('C', "context", &opt, "n",
-			"show <n> context lines before and after matches",
+		OPT_CALLBACK('C', "context", &opt, N_("n"),
+			N_("show <n> context lines before and after matches"),
 			context_callback),
 		OPT_INTEGER('B', "before-context", &opt.pre_context,
-			"show <n> context lines before matches"),
+			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
-			"show <n> context lines after matches"),
-		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
+			N_("show <n> context lines after matches")),
+		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOLEAN('p', "show-function", &opt.funcname,
-			"show a line with the function name before matches"),
+			N_("show a line with the function name before matches")),
 		OPT_BOOLEAN('W', "function-context", &opt.funcbody,
-			"show the surrounding function"),
+			N_("show the surrounding function")),
 		OPT_GROUP(""),
-		OPT_CALLBACK('f', NULL, &opt, "file",
-			"read patterns from file", file_callback),
-		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
-			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		OPT_CALLBACK('f', NULL, &opt, N_("file"),
+			N_("read patterns from file"), file_callback),
+		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
+			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
-		  "combine patterns specified with -e",
+		  N_("combine patterns specified with -e"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
 		OPT_BOOLEAN(0, "or", &dummy, ""),
 		{ OPTION_CALLBACK, 0, "not", &opt, NULL, "",
@@ -769,16 +769,16 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
 		  close_callback },
 		OPT__QUIET(&opt.status_only,
-			   "indicate hit with exit status without output"),
+			   N_("indicate hit with exit status without output")),
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
-			"show only matches from files that match all patterns"),
+			N_("show only matches from files that match all patterns")),
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
-			"pager", "show matching files in the pager",
+			N_("pager"), N_("show matching files in the pager"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
-			    "allow calling of grep(1) (ignored by this build)"),
-		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
+			    N_("allow calling of grep(1) (ignored by this build)")),
+		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186
