From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 54/65] i18n: rm: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:06 +0700
Message-ID: <1338203657-26486-52-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5S-0006ML-Pi
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab2E1L0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab2E1L0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:04 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=osmIhlohslZ9SzNz5xI0WpiM0Ym35CZBSlDFJqAmFYM=;
        b=wV64IwR86Ze95fIumsnixyUceo87DMrANnZWpyf63I3Ktc2jTi95uGR7mKSR93AbPV
         ET9R3NLI0J+lFYGtiwutnXh17vjbof472+euZF8spOvfK6Nf+LxA1ud+xDi9rT5IgOWn
         cNnljCsKjqmByzS43JtdDnj99tYsBl5nVco23ND1RhbVfuZbdH0TjLRQ1F6maup8V/A/
         ta9la6SR01EXdiFXOwzRvdudlqIK3fZGSQw7peSWUgsCL0YP+kOYWMK9ZAa4XFimi+Z0
         gZ+22Ww8jsnBRNKJ3RTmx4b/NHCZCO+dA0KCC7yh1QuwPsxRt3Rc2+BjmuymTMTbiGo/
         BlMw==
Received: by 10.68.211.234 with SMTP id nf10mr26382673pbc.121.1338204364569;
        Mon, 28 May 2012 04:26:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id nr3sm7036098pbc.36.2012.05.28.04.25.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:58 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198690>

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
1.7.10.2.549.g9354186
