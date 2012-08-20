From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 56/66] i18n: show-ref: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:45 +0700
Message-ID: <1345465975-16927-57-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMD-0000uR-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab2HTMpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2HTMpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:17 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2157219dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fFNw3cLOJti/gt8dfdxOmJA4oyFVXU/a6I05ah1pwv4=;
        b=sJaZKJ9Ptqq50ABB8zRvBRKD+rh7AS6ErhRGyrcy5JNrvoYN7Jw6lu6VKNBR9vV7Ok
         z//xkuRKSDCqvqpjC9TE3v6ridZe1130ej/vf+VBmnsEIU8FbJEmqPkrUySRbh9NqoDd
         GA10BNvrNMeXfPhjzrc6huFouy7LvNXMSDMIeRtP2VF0ANN6lblhet9/OOu6id2ILmPn
         3ge24fvcfHV8i6DVdSGIArV9Pax0uO3lsNMtDDCUtHlZYu9Tl709G1UD1/3cqonDQZoP
         4lon36dHMKGizwjSbnxpXHwsfW5I1co0CHjNujDeY2JDeQhNyqSnBSoSscdyIDDNmByl
         N3KA==
Received: by 10.68.136.138 with SMTP id qa10mr34044907pbb.103.1345466717451;
        Mon, 20 Aug 2012 05:45:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ox5sm11026065pbc.75.2012.08.20.05.45.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:17 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203828>

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
1.7.12.rc2.18.g61b472e
