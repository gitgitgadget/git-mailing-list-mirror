From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 53/66] i18n: rm: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:42 +0700
Message-ID: <1345465975-16927-54-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLt-0000gL-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab2HTMo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab2HTMo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=l8U2m/tjBHuYExPHLzsCG3PF04QmkjbhyuySLeDOqEE=;
        b=gT4mCi1o3fRRubSFxoWcAvGJ5t9K64+2EdrYYwupLjAnK7jxbv8S09fUjXw0RjjR+k
         GbS4PihlCu8WwFCREtqhKyUllR5IWkjMoSNZ1OxC9tL7Qi+hYHaxMZ6S3PT0ZBPKA0gu
         BveYIKPnyBf7xn/zo9otFlBFc9xvZRL88Y9F4KE+SOKr/sGdT9nARSN+fciUbtyl49eG
         f/NjHwaYzqobPv+nUPzqz8Cc77Hnt7l5c2Qz7BMwt77IZuVF4OcWJ8i4+0v8sTa+z/WY
         7IPeLpsAp9Kpv/k5/r5t1TuYWyjo+Cg5mnGXTSqFK72RYhp4RAjmJPp5+6jA14mpnBHZ
         lfpA==
Received: by 10.66.74.100 with SMTP id s4mr29506242pav.27.1345466698524;
        Mon, 20 Aug 2012 05:44:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ns9sm4635866pbb.13.2012.08.20.05.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:58 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203825>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..b384c4c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
=20
 static const char * const builtin_rm_usage[] =3D {
-	"git rm [options] [--] <file>...",
+	N_("git rm [options] [--] <file>..."),
 	NULL
 };
=20
@@ -130,13 +130,13 @@ static int show_only =3D 0, force =3D 0, index_on=
ly =3D 0, recursive =3D 0, quiet =3D 0;
 static int ignore_unmatch =3D 0;
=20
 static struct option builtin_rm_options[] =3D {
-	OPT__DRY_RUN(&show_only, "dry run"),
-	OPT__QUIET(&quiet, "do not list removed files"),
-	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the=
 index"),
-	OPT__FORCE(&force, "override the up-to-date check"),
-	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive remo=
val"),
+	OPT__DRY_RUN(&show_only, N_("dry run")),
+	OPT__QUIET(&quiet, N_("do not list removed files")),
+	OPT_BOOLEAN( 0 , "cached",         &index_only, N_("only remove from =
the index")),
+	OPT__FORCE(&force, N_("override the up-to-date check")),
+	OPT_BOOLEAN('r', NULL,             &recursive,  N_("allow recursive r=
emoval")),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
-				"exit with a zero status even if nothing matched"),
+				N_("exit with a zero status even if nothing matched")),
 	OPT_END(),
 };
=20
--=20
1.7.12.rc2.18.g61b472e
