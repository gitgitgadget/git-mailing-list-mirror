From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/65] i18n: describe: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:31 +0700
Message-ID: <1338203657-26486-17-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy0T-0008IR-1h
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab2E1LUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:53 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab2E1LUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:50 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=muJWmP5vrevOp8D8Yci9L9zg2ECJrm9Idr/H6K0Jbbg=;
        b=dhehAUjYuTxltbRlSGHljHCvwZ2Sn8RRg7XFB/4qhFhDiyD4/yIOKenOUmcGNUwrP9
         Np1+8FaM+dCxbs/HT8JVJSB3s+5K9PYQ+kem/m6Oi4T5lPPMHdOc7gxgU/UBN2TFJY+y
         DmXdxlPNgJ3e+2RN5gF+6ZiHyeDQ9vtXvUYs6DiqiCRYXZ4AtWxSXHqh9063IHuEHpBJ
         UnLwecBP4WJt/e96tTCchzUSf+1JhzlUnYlNp1K5Q4j5zI/s22BhbNBflLCYCzpxWdyZ
         k4t5hLv4GIHSNQW0VAbZ4uB1cRBcglTNN3Go7NmHu05hhaADCiM/zPuIWZH1uveqFLis
         MeTg==
Received: by 10.68.202.136 with SMTP id ki8mr25802957pbc.65.1338204049945;
        Mon, 28 May 2012 04:20:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ve6sm18972079pbc.75.2012.05.28.04.20.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:44 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198655>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/describe.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 9f63067..9fe11ed 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,8 +12,8 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
=20
 static const char * const describe_usage[] =3D {
-	"git describe [options] <committish>*",
-	"git describe [options] --dirty",
+	N_("git describe [options] <committish>*"),
+	N_("git describe [options] --dirty"),
 	NULL
 };
=20
@@ -400,22 +400,22 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
 {
 	int contains =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN(0, "contains",   &contains, "find the tag that comes aft=
er the commit"),
-		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stder=
r"),
-		OPT_BOOLEAN(0, "all",        &all, "use any ref in .git/refs"),
-		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags")=
,
-		OPT_BOOLEAN(0, "long",       &longformat, "always use long format"),
+		OPT_BOOLEAN(0, "contains",   &contains, N_("find the tag that comes =
after the commit")),
+		OPT_BOOLEAN(0, "debug",      &debug, N_("debug search strategy on st=
derr")),
+		OPT_BOOLEAN(0, "all",        &all, N_("use any ref in .git/refs")),
+		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag in .git/refs/tag=
s")),
+		OPT_BOOLEAN(0, "long",       &longformat, N_("always use long format=
")),
 		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
-			    "only output exact matches", 0),
+			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
-			    "consider <n> most recent tags (default: 10)"),
-		OPT_STRING(0, "match",       &pattern, "pattern",
-			   "only consider tags matching <pattern>"),
+			    N_("consider <n> most recent tags (default: 10)")),
+		OPT_STRING(0, "match",       &pattern, N_("pattern"),
+			   N_("only consider tags matching <pattern>")),
 		OPT_BOOLEAN(0, "always",     &always,
-			   "show abbreviated commit object as fallback"),
-		{OPTION_STRING, 0, "dirty",  &dirty, "mark",
-			   "append <mark> on dirty working tree (default: \"-dirty\")",
+			   N_("show abbreviated commit object as fallback")),
+		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
+			   N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 		 PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
 		OPT_END(),
 	};
--=20
1.7.10.2.549.g9354186
