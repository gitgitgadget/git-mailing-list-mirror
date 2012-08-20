From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/66] i18n: gc: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:14 +0700
Message-ID: <1345465975-16927-26-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RIx-0006x4-9F
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab2HTMl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab2HTMl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:41:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rhEvULQJkGU98B5S667exR8HfC5hWitFtwXdAawHsyY=;
        b=hBxpsaBnlhYrpvCdZInWSJ/bGDNBk51s2EBCDzJMOVMg/288qsWSNZz9EjK+0JNdtD
         5+ntFcomE+PVjDzEifcogS8zSi7eGlvSpoUzJG9GQ5NlF/uQ6iYKENn0fN4T5VrTo7gN
         Hep6uvUFbvHgWzkxHCCwzEQxXGtwwRKIWyRkwgXa7iDLhnS4nAgDVxaa6Oo4V4DT3q/F
         URmoPmze7h5v2YJx/dJz7sfbApvifFJ9a+7Rlw1r6eCyTeNX9jRKK2SVmJ8F9nRoXEBC
         WAI7xp4Q++tigPCtALDui4AE2k003IoAkRZdSvGycaEJxaa33IlY5c0LFM4CG6LT1bbq
         kK3Q==
Received: by 10.66.82.168 with SMTP id j8mr24255964pay.73.1345466516466;
        Mon, 20 Aug 2012 05:41:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id pf10sm10905048pbc.56.2012.08.20.05.41.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:41:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:35:56 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203797>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9b4232c..6d46608 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -19,7 +19,7 @@
 #define FAILED_RUN "failed to run %s"
=20
 static const char * const builtin_gc_usage[] =3D {
-	"git gc [options]",
+	N_("git gc [options]"),
 	NULL
 };
=20
@@ -174,12 +174,12 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 	int quiet =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
-		OPT__QUIET(&quiet, "suppress progress reporting"),
-		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
-			"prune unreferenced objects",
+		OPT__QUIET(&quiet, N_("suppress progress reporting")),
+		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
+			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
-		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
-		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more thorough (incr=
eased runtime)")),
+		OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
