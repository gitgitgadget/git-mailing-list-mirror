From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/65] i18n: fmt-merge-msg: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:34 +0700
Message-ID: <1338203657-26486-20-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy10-0000aY-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab2E1LVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab2E1LVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:15 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+/wsF4Q5OvRT6uNpPpdsUzOf67iV9Dm0dwFKgJ+HMH0=;
        b=XgDgc4dCymarCsGFXOvMLw6vzjVvTmHgWIzPa0wl9n2nVE8Y5uQ2H+SI0ETj1xjmW2
         yd42KtC02ZyzyDf1VC7ETarXOzgB8Gwxm81t+ScCZQylh6y3MSwW0ecNg2lVMHYBUmwf
         9nNTl4+DbJJ5mmUIeO/8c9HwCOWkbWxnQpMypTxpbIAtn73AhXYAWtLF/pJX5asuJXzR
         y8LWjheAGYbLycTFJdkcEZkTHzA9NMmFJRxSUyMofBWBoJt1xnH1PvRAwJHnJHQYkDp+
         CRpxTUZIv80lKC6Cv3EZ31v+ZEDDCdD+nRu3K9U/DkG8w5Aw+u6zXCcP4YxhwL6uYBMR
         JTAQ==
Received: by 10.68.132.166 with SMTP id ov6mr27143415pbb.24.1338204075398;
        Mon, 28 May 2012 04:21:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ql3sm18976576pbc.72.2012.05.28.04.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:10 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198659>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fmt-merge-msg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index d42015d..bf118b3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -10,7 +10,7 @@
 #include "gpg-interface.h"
=20
 static const char * const fmt_merge_msg_usage[] =3D {
-	"git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--file <f=
ile>]",
+	N_("git fmt-merge-msg [-m <message>] [--log[=3D<n>]|--no-log] [--file=
 <file>]"),
 	NULL
 };
=20
@@ -650,16 +650,16 @@ int cmd_fmt_merge_msg(int argc, const char **argv=
, const char *prefix)
 	const char *message =3D NULL;
 	int shortlog_len =3D -1;
 	struct option options[] =3D {
-		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
-		  "populate log with at most <n> entries from shortlog",
+		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
+		  N_("populate log with at most <n> entries from shortlog"),
 		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
-		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
-		  "alias for --log (deprecated)",
+		{ OPTION_INTEGER, 0, "summary", &shortlog_len, N_("n"),
+		  N_("alias for --log (deprecated)"),
 		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
 		  DEFAULT_MERGE_LOG_LEN },
-		OPT_STRING('m', "message", &message, "text",
-			"use <text> as start of message"),
-		OPT_FILENAME('F', "file", &inpath, "file to read from"),
+		OPT_STRING('m', "message", &message, N_("text"),
+			N_("use <text> as start of message")),
+		OPT_FILENAME('F', "file", &inpath, N_("file to read from")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
