From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/66] i18n: fmt-merge-msg: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:10 +0700
Message-ID: <1345465975-16927-22-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:41:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RIH-0006VI-9c
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab2HTMlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab2HTMlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:41:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TMvlrPLpoi9JnqqhnBafn+jBMahdK2+zgIWcqSd5HCk=;
        b=NwpEexW6DRGl2alriw3//B2mOXV8QVD6kONRE8SmdRPBSq1FbWVa5Vi7zqwk+2u5n8
         JZcJhe86smNh0Msnn83zlhR87867Hl1MTy233L8/gb8Cqxkp0Yj2UeShK26yZ6QgHZBh
         RHRm2+24YXx7S/JJ+6fDeQCXxyB1p+oQuhOxHXBmNJIgZ4ot41vG2uxFXFhHTf6NQFy6
         NBfBL0uKGbesUdVbYx7p6EfUo3lPSvWuB6qhcARoe+RsjsITmsnzxXw1vKWi1BEJyv7u
         r5ZZM+cvOuHVGwUi0GZvZYVnN/7eP85CsQ4g7jTK8ZmuuoiG0uYXMxllhnoHu4p3bYdq
         pnjA==
Received: by 10.68.216.104 with SMTP id op8mr34125784pbc.65.1345466471695;
        Mon, 20 Aug 2012 05:41:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wh7sm11039855pbc.33.2012.08.20.05.41.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:41:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:35:11 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203793>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fmt-merge-msg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 2c4d435..e2e27b2 100644
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
1.7.12.rc2.18.g61b472e
