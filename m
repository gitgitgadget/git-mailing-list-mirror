From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 45/65] i18n: push: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:57 +0700
Message-ID: <1338203657-26486-43-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy4A-0004hX-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab2E1LYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab2E1LYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=waY5rjP9mXRl3w0Z3xOJyo6oYMW1JrViDkJwZiz/iDA=;
        b=U/sTrG55T7cbb2TxSX1XxHQMj8vERS7bUcrY8cYbqVdW/OKDjGF3Av+Q2K2tvqmIw9
         t8NAyBFPOTWNOe7MN/WOsoHZHYm+eeW1FKDUQTBOqVPtg3pqDBsmNt3HCLrgiH+QsYPD
         dkX7fbscQaTrZhJKHI9eJTvWO4PvBTeEsvBzLNTZDvAozQHa33Q9DekrhPiAsJPmre3S
         BYge4kap6U3J/4kJkXWcpBz/WmldR8K3vh4gtna2GeEfhU8zgBdqRnZu2gSVt/qoOr/+
         kHcTbVoD6XuNeFadsUakE+lyA1OtaXmstn/H7bpclwkYw7Tn2MAvUzTGrxo0jiWYEhMw
         c7dQ==
Received: by 10.68.227.5 with SMTP id rw5mr27238395pbc.32.1338204284010;
        Mon, 28 May 2012 04:24:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id wn3sm18988028pbc.74.2012.05.28.04.24.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:20:38 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198681>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/push.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index fdfcc6c..4840bc2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -11,7 +11,7 @@
 #include "submodule.h"
=20
 static const char * const push_usage[] =3D {
-	"git push [<options>] [<repository> [<refspec>...]]",
+	N_("git push [<options>] [<repository> [<refspec>...]]"),
 	NULL,
 };
=20
@@ -354,25 +354,25 @@ int cmd_push(int argc, const char **argv, const c=
har *prefix)
 	const char *repo =3D NULL;	/* default repository */
 	struct option options[] =3D {
 		OPT__VERBOSITY(&verbosity),
-		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
-		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
-		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
+		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
+		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL)=
,
+		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0, "delete", &deleterefs, "delete refs"),
-		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all=
 or --mirror)"),
-		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
-		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPO=
RT_PUSH_PORCELAIN),
-		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE)=
,
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check",
-			"controls recursive pushing of submodules",
+		OPT_BOOLEAN( 0, "delete", &deleterefs, N_("delete refs")),
+		OPT_BOOLEAN( 0 , "tags", &tags, N_("push tags (can't be used with --=
all or --mirror)")),
+		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_R=
UN),
+		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRA=
NSPORT_PUSH_PORCELAIN),
+		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FO=
RCE),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
+			N_("controls recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
-		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "recei=
ve pack program"),
-		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack =
program"),
-		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/stat=
us",
+		OPT_BOOLEAN( 0 , "thin", &thin, N_("use thin pack")),
+		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("re=
ceive pack program")),
+		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pa=
ck program")),
+		OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/s=
tatus"),
 			TRANSPORT_PUSH_SET_UPSTREAM),
-		OPT_BOOL(0, "progress", &progress, "force progress reporting"),
-		OPT_BIT(0, "prune", &flags, "prune locally removed refs",
+		OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
+		OPT_BIT(0, "prune", &flags, N_("prune locally removed refs"),
 			TRANSPORT_PUSH_PRUNE),
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186
