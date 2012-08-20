From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 43/66] i18n: prune: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:32 +0700
Message-ID: <1345465975-16927-44-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKp-0008JG-JR
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2HTMny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+7BU65aaIgt5f4P7i+R6DfR9qHO+4i995lKdAXnLz9k=;
        b=Q0JL6zU7Ke/LX9UzBmNYrUvebQ485/l62/kuGF2e/z3rHXeqjjwLz+K+H4FT2cZ1ZM
         jDgVfnCZEF9DaIN402iQAQcRqJ6zcfn+njjtLva+POpstxxuNmTqiuul0GwVqzV+8ed0
         Dm3/NV7bg+P2SXLWrv0VquCWhCZUpB54Q+UtULpna5hUoDFfT7y52uFuz8E11LiRFfyR
         zHsXzsSZv3iRs2YLT26q7pqBKrV7tfHm/RVRQlfCA3A827wEkqlfOAgBrTHtuacqMGeg
         HCy+QKa+9V2wbZk5WVll3rSQrHYj3doxoxbialcZS3r2PETnpzcN/epjsH3AWxa4XL95
         ZVOQ==
Received: by 10.68.138.166 with SMTP id qr6mr33917630pbb.69.1345466632660;
        Mon, 20 Aug 2012 05:43:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wd6sm11050540pbc.15.2012.08.20.05.43.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:52 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203815>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/prune.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index b99b635..a9e2241 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -9,7 +9,7 @@
 #include "dir.h"
=20
 static const char * const prune_usage[] =3D {
-	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
+	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
 	NULL
 };
 static int show_only;
@@ -128,11 +128,11 @@ int cmd_prune(int argc, const char **argv, const =
char *prefix)
 	struct rev_info revs;
 	struct progress *progress =3D NULL;
 	const struct option options[] =3D {
-		OPT__DRY_RUN(&show_only, "do not remove, show only"),
-		OPT__VERBOSE(&verbose, "report pruned objects"),
-		OPT_BOOL(0, "progress", &show_progress, "show progress"),
+		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
+		OPT__VERBOSE(&verbose, N_("report pruned objects")),
+		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_DATE(0, "expire", &expire,
-			 "expire objects older than <time>"),
+			 N_("expire objects older than <time>")),
 		OPT_END()
 	};
 	char *s;
--=20
1.7.12.rc2.18.g61b472e
