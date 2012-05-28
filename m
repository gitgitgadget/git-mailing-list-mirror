From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/65] i18n: log: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:43 +0700
Message-ID: <1338203657-26486-29-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2C-00026F-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2E1LWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab2E1LWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:35 -0400
Received: by dady13 with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W/4T2tTuD5Zg0niOXqyzOLsvOixZl7f+yAw8yS8HbMw=;
        b=DstA1M+x4xet7jQ8hDZ/Lz9Y/A3bw3umiRg8NojvsmmzGn3F+8s+4pZZhDHGc8UMw6
         kRhLj4IiQ0Mtw6POvz2GS9Haxawu2mMga9RHd7F1b+O+/l3pD7hq+ySUiJFbPEpiRZ5/
         z+yKK5HR7pUeugbrulMLqlWCzEk9jIUhLscvLxR4/78dIpwF9kw+g5HOxNLrsv4l/9fW
         3pfRQOu7V625PznnCIQWlp80mjtUb0nqBUQl3ZKpYrJp6dFFX8BAh17pHGjQQri4tEKu
         Jx7kiyvOjq5XNXbIgJlV3XtoUQlOKMUnZ5zIwNvMKUG+5nmMEouJerems3M2tTBXjEuQ
         EBaQ==
Received: by 10.68.227.198 with SMTP id sc6mr26342405pbc.138.1338204155562;
        Mon, 28 May 2012 04:22:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id gj8sm15479414pbc.39.2012.05.28.04.22.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:30 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198667>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index da54ce9..09d9a01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -33,8 +33,8 @@ static const char *fmt_patch_subject_prefix =3D "PATC=
H";
 static const char *fmt_pretty;
=20
 static const char * const builtin_log_usage[] =3D {
-	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-	"   or: git show [options] <object>...",
+	N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
+	N_("   or: git show [options] <object>..."),
 	NULL
 };
=20
@@ -96,9 +96,9 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 	int quiet =3D 0, source =3D 0;
=20
 	const struct option builtin_log_options[] =3D {
-		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
-		OPT_BOOLEAN(0, "source", &source, "show source"),
-		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
+		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT_BOOLEAN(0, "source", &source, N_("show source")),
+		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options")=
,
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186
