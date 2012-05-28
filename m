From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 44/65] i18n: prune: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:56 +0700
Message-ID: <1338203657-26486-42-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy40-0004VT-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab2E1LYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab2E1LYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UG6WMIPR/OukcTDPCfnm33ZzMN4VKjAKjFXa+vuEBB8=;
        b=hyLx8omFepmpppft+3KMutpRMNXK15Gw2B+X/cxy3lqk4I0GfG+4FO5ToSzflAllHC
         jS4u0H3yLvix1WtkKKsy9F55q6va4imU6M1MBLmbPQbpdCY5jgkf8A8tLyrU++HMXqxk
         b8QAVBCtfBcW0hawiiNlFcti2gGVoREVfvqezqnQUuz8R7S/mY6DhvN9lQNi7NW0khig
         9NG+oWdyEJWSLHsWRYWeRHdb392q8g0l7ZV+PwLofveUSOi1IeGgA5zMqDNii8kzuUEI
         vyDoQFezx17XJFQDLksW/p7ialX8xL6TS5VKZ5PIz3W0XsaDiIS9FU+YWHC0awcvuPCc
         31iA==
Received: by 10.68.239.161 with SMTP id vt1mr6393840pbc.15.1338204275030;
        Mon, 28 May 2012 04:24:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id py5sm19023280pbb.1.2012.05.28.04.24.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:20:27 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198680>

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
1.7.10.2.549.g9354186
