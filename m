From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 54/66] i18n: shortlog: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:43 +0700
Message-ID: <1345465975-16927-55-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RM1-0000mQ-2v
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2HTMpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2HTMpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J6n1fFuoMybhBaoAQRnW/JJHy/MMiyxFUBaciingRow=;
        b=yu2VxAa/ZTUc7EpL9fFTsRcmdhFLlMnrtRMv0IrYH005Ty5RPw2VR/HsWv1H/CTuHK
         7odnm2L/61kdtdi1XsOBReiN/jrSUw098ssgPEkWAKBruWA3KSchibELwQ3uBYglYYZu
         /TkCI62LZlK3QOPoRb/7M/D82U9IR4OA6evIDHM7WfGX18XSbS5Ch/WUvN7M7nQZzomo
         KLHgvA0ieBmYwqGDyqaPMCPX8kOc/iBxG6AaYhDMWmJJke6FrcqBxeBYFjgRZOoODCXI
         sXZGacczRaoyLbqO11MphuRKYWagHpoh3exeJqlg1tD/uxcCQ3+ePMhFUcZmxuAPNAB9
         9QLw==
Received: by 10.68.231.233 with SMTP id tj9mr34106816pbc.39.1345466705502;
        Mon, 20 Aug 2012 05:45:05 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qb6sm10115861pbb.18.2012.08.20.05.45.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:04 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203826>

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
1.7.12.rc2.18.g61b472e
