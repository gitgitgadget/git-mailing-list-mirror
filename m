From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 50/65] i18n: rerere: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:02 +0700
Message-ID: <1338203657-26486-48-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy4u-0005e5-0t
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab2E1LZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab2E1LZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rKahck9iE+WATODT7zM4f34S1MhVwAwQLqlI4vsogrw=;
        b=CWk2bJ+hQY49FAaVMhZfprEYh8uaVivW7pVXxRDdBPUUSa1o6RaRPHOoHWriI6r5wH
         HhJ7wM/24YBweOolK4W+xUea/8v+ZAppdz9jZSDovqziMmuzGwUWiiMd+MAauMjJx9vv
         6GUt7VM80fxHUUgcLalaBQldAAbPCUcy2ZC5UbJ18jX3AtoBilAaY9pP4cMqZEHi0MnM
         QQDv6sF9M3Z0QpklRzAnK2AUn7A8erJdHh2Lq3SREbcKFR0wu6p3fvEao3SYMtmRQ4Cj
         ImPwZAmzkEXf/TLTHfGZZRbAPog/9Mv84fdtG9JqZycxMX+BN2UHilIijOxhEiRQs5yk
         iiVg==
Received: by 10.68.227.197 with SMTP id sc5mr22128231pbc.58.1338204329961;
        Mon, 28 May 2012 04:25:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id oy8sm18995972pbc.52.2012.05.28.04.25.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:24 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198687>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rerere.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 08213c7..dc1708e 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -8,7 +8,7 @@
 #include "xdiff-interface.h"
=20
 static const char * const rerere_usage[] =3D {
-	"git rerere [clear | forget path... | status | remaining | diff | gc]=
",
+	N_("git rerere [clear | forget path... | status | remaining | diff | =
gc]"),
 	NULL,
 };
=20
@@ -53,7 +53,7 @@ int cmd_rerere(int argc, const char **argv, const cha=
r *prefix)
=20
 	struct option options[] =3D {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
-			"register clean resolutions in index", 1),
+			N_("register clean resolutions in index"), 1),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
