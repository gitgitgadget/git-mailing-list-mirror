From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 44/66] i18n: push: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:33 +0700
Message-ID: <1345465975-16927-45-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKw-0008Pe-EN
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab2HTMoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:01 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e1xnLtru7IlJgmTbbgesAYbG9pePhnPIe9xdJ00KDSw=;
        b=aUjZx06EopQwxAzyfKTPMHOwkYefzACkqL6dCKZHvgR4D2jeTf3zbwkTQGuR4n/R/i
         IqwkiMX3WXrLuXa7vGzNeJH8FwIi1xhX2dfN/p8zQWInwZZNQy0wJjWRCFxodnYck8ta
         JAa5sy5aMO7fvBIEdFNsTMKY1g8XBqtfhegxO5pt6kJajeHJkHHuzxZ2vVxZVUVd+g6V
         MN0s3oEFrJkh8sZHAkvBjj6OnSHtedpOZm2h6TwGE0jQBerA9+JBBD2TPmK8lNYwUC4u
         V7wmECYjnUq4YpIw0LlJNBK7STAxq5uLEomA7RAcY/9pWuehXWkyrbVtb+XPRmdw5zCS
         f8ig==
Received: by 10.66.81.66 with SMTP id y2mr29272183pax.62.1345466639077;
        Mon, 20 Aug 2012 05:43:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id hx9sm11032019pbc.68.2012.08.20.05.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:58 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203816>

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
1.7.12.rc2.18.g61b472e
