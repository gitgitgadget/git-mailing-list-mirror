From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 55/65] i18n: shortlog: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:07 +0700
Message-ID: <1338203657-26486-53-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5b-0006Ww-8U
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab2E1L0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2E1L0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:13 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CnDiy4i1Uf3ukrqOlTTwfKMJMFaFY9m3WCh3n2dd7Tc=;
        b=A4m063fbfygXAnJ2+kH+EuRdiDNcSPeoP2ztaasJkhQe8ds9KlaCeWXHWGbUwmRw+I
         DC9d3aDSrUFvgubouUg59B01EHNkR+HLlsNCteUEWCa0hS5MjPQE6ePBULP5QDr+suiu
         gCFVVxUvTKFMcaxDSS2S6QDAJSYhPI0Fu39FFrZPv5wwRZe8jIT+44osrC/LzNhGEa14
         Wz0FKMcAUSjMxKpFDsPnUQJwBIqKIuzDeIACKe8MdpZe74tSDTDKp8sowOni9dBxzjFy
         pR0sk39rtd+gUq6t5uLKYBEuXPKyAqEoDuDKZhcxjJhfeVnIU5x27mULQBoQUiINeCY6
         dAPw==
Received: by 10.68.233.102 with SMTP id tv6mr26251403pbc.153.1338204373520;
        Mon, 28 May 2012 04:26:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qp3sm13793287pbc.17.2012.05.28.04.26.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:07 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198691>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/shortlog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 37f3193..b316cf3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,9 +10,9 @@
 #include "parse-options.h"
=20
 static char const * const shortlog_usage[] =3D {
-	"git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]",
+	N_("git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... =
]"),
 	"",
-	"[rev-opts] are documented in git-rev-list(1)",
+	N_("[rev-opts] are documented in git-rev-list(1)"),
 	NULL
 };
=20
@@ -250,13 +250,13 @@ int cmd_shortlog(int argc, const char **argv, con=
st char *prefix)
=20
 	static const struct option options[] =3D {
 		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
-			    "sort output according to the number of commits per author"),
+			    N_("sort output according to the number of commits per author")=
),
 		OPT_BOOLEAN('s', "summary", &log.summary,
-			    "Suppress commit descriptions, only provides commit count"),
+			    N_("Suppress commit descriptions, only provides commit count"))=
,
 		OPT_BOOLEAN('e', "email", &log.email,
-			    "Show the email address of each author"),
-		{ OPTION_CALLBACK, 'w', NULL, &log, "w[,i1[,i2]]",
-			"Linewrap output", PARSE_OPT_OPTARG, &parse_wrap_args },
+			    N_("Show the email address of each author")),
+		{ OPTION_CALLBACK, 'w', NULL, &log, N_("w[,i1[,i2]]"),
+			N_("Linewrap output"), PARSE_OPT_OPTARG, &parse_wrap_args },
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
