From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 57/65] i18n: show-ref: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:09 +0700
Message-ID: <1338203657-26486-55-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5v-0006pC-2w
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab2E1L0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab2E1L0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tPsn/1xNjGufRSX5dXJ97IO6VKL2L6kYdN5mCuSwc2Y=;
        b=D4aB9b36JIdS01+nb9MrCtREnX+s5StOp/1dTqxe5s3kmjmBWYnecxIOce1oBMEHUh
         3QHbYc+H6voD5CM5KgWh/y8NYQnEeCKe94zxyxP/WhKOWALJFcsfz/5l5Kf3jFEaX7Dm
         VWJOrKllP+4W3WQixae5oMeBNDipuTbh6GlJ7YFxAsAEUiHgau0iPN58XKLqGEz8SinQ
         eaBmEhMP5GP99gVmG959bD5nx0iEbCi098l50LCdCg+XmCBr1JGwDCwtN/c1Yg1YmQSD
         edDLQghXJvrAUjJebca0Fr4FvhPbRN0gOnzGWyIvWBTT+WGGfh5oXIqcjgPVM/HXgTwL
         FWCw==
Received: by 10.68.242.166 with SMTP id wr6mr4138405pbc.28.1338204394475;
        Mon, 28 May 2012 04:26:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qx8sm17918167pbc.28.2012.05.28.04.26.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:25 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198693>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/show-ref.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3911661..4eb016d 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -7,8 +7,8 @@
 #include "parse-options.h"
=20
 static const char * const show_ref_usage[] =3D {
-	"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s=
|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] =
",
-	"git show-ref --exclude-existing[=3Dpattern] < ref-list",
+	N_("git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] =
[-s|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern=
*] "),
+	N_("git show-ref --exclude-existing[=3Dpattern] < ref-list"),
 	NULL
 };
=20
@@ -179,26 +179,26 @@ static int help_callback(const struct option *opt=
, const char *arg, int unset)
 }
=20
 static const struct option show_ref_options[] =3D {
-	OPT_BOOLEAN(0, "tags", &tags_only, "only show tags (can be combined w=
ith heads)"),
-	OPT_BOOLEAN(0, "heads", &heads_only, "only show heads (can be combine=
d with tags)"),
-	OPT_BOOLEAN(0, "verify", &verify, "stricter reference checking, "
-		    "requires exact ref path"),
+	OPT_BOOLEAN(0, "tags", &tags_only, N_("only show tags (can be combine=
d with heads)")),
+	OPT_BOOLEAN(0, "heads", &heads_only, N_("only show heads (can be comb=
ined with tags)")),
+	OPT_BOOLEAN(0, "verify", &verify, N_("stricter reference checking, "
+		    "requires exact ref path")),
 	{ OPTION_BOOLEAN, 'h', NULL, &show_head, NULL,
-	  "show the HEAD reference",
+	  N_("show the HEAD reference"),
 	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-	OPT_BOOLEAN(0, "head", &show_head, "show the HEAD reference"),
+	OPT_BOOLEAN(0, "head", &show_head, N_("show the HEAD reference")),
 	OPT_BOOLEAN('d', "dereference", &deref_tags,
-		    "dereference tags into object IDs"),
-	{ OPTION_CALLBACK, 's', "hash", &abbrev, "n",
-	  "only show SHA1 hash using <n> digits",
+		    N_("dereference tags into object IDs")),
+	{ OPTION_CALLBACK, 's', "hash", &abbrev, N_("n"),
+	  N_("only show SHA1 hash using <n> digits"),
 	  PARSE_OPT_OPTARG, &hash_callback },
 	OPT__ABBREV(&abbrev),
 	OPT__QUIET(&quiet,
-		   "do not print results to stdout (useful with --verify)"),
+		   N_("do not print results to stdout (useful with --verify)")),
 	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
-	  "pattern", "show refs from stdin that aren't in local repository",
+	  N_("pattern"), N_("show refs from stdin that aren't in local reposi=
tory"),
 	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
-	{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, "show usage",
+	{ OPTION_CALLBACK, 0, "help-all", NULL, NULL, N_("show usage"),
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 	OPT_END()
 };
--=20
1.7.10.2.549.g9354186
