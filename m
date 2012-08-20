From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/66] i18n: describe: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:07 +0700
Message-ID: <1345465975-16927-19-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:41:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHx-0006JX-6q
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab2HTMkz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab2HTMkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qM9/TzwXrcnpW54kvn136UKIFPYUuXMvo2E61127wc0=;
        b=zI51rIsSSqmAmZ0nZAhnMGUQCPafF25DBsUUV8GvEzGCN9Pvl4TkJd9V659GbMCBXh
         4KLcfkaxb0PZqbZmtUno/CeNU2WyBMDGvB88IABEk7rYKvMamBO+MuYHxIigxg04zo6l
         1kCdlWsIcgm1uHHVhXiBZRzSQRhTSnlYS2jFxagYm3aNMJveLJCc11yQfaFIXJZN2fqj
         PWqG6M1xl3VuX4SPPSHn573NEE8GoXHpKwj7L/HxzVYKxG8Q6BbMrpJgCHAez7EGFHBY
         n/pMXY5E2N0UpHvuKUzdMwESvIV4Ei/BtK5eigx4gh0ZqhbGRLbfWLHr9NrrKnIHRwha
         pNJA==
Received: by 10.66.75.133 with SMTP id c5mr29774730paw.24.1345466453199;
        Mon, 20 Aug 2012 05:40:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id gf7sm11016614pbc.65.2012.08.20.05.40.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:52 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203790>

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
1.7.12.rc2.18.g61b472e
