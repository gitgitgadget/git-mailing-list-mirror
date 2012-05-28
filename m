From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 52/65] i18n: rev-parse: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:04 +0700
Message-ID: <1338203657-26486-50-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5A-0005vk-4X
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2E1LZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383Ab2E1LZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ONDxI1CsEHlbnihD7Z7i0Qv19r+gj6A/Rr9hsHhI5Dk=;
        b=H/eUag9nEZwrxD29GWPymfiS36XkpU9nsb8apa4W5iRwhEesYkv2QceJVy8CCWc1yQ
         CFO0PbiPEsFKCp6pT7SLIGPXEtbB9hWqwv87Tn+oTLXq4a/+BigXLkXXjzxQvnCEmgBd
         xwppX7s7dfNxQWamWWzkrPeb3ALHpKMbmL57a4CBW3V98KfbCoB2RgXSVd2FfAn1NhxQ
         neXtUjw+11Ri5wIrI0UyBxbvil/BkfCrPXIcRSlbQYHlHeoqArahAa1Ke+eM/6hmw8Tt
         7rU7Ub0uB6jV9mw81PD1+TR+FGQ43TRyxlO/EVvgwqsF2mBA11teLg0qz8TfvRRb1Uvn
         70VQ==
Received: by 10.68.203.73 with SMTP id ko9mr27005691pbc.66.1338204346996;
        Mon, 28 May 2012 04:25:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id pd9sm19012435pbc.26.2012.05.28.04.25.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:41 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198688>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 733f626..1f79aa5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -318,15 +318,15 @@ static int cmd_parseopt(int argc, const char **ar=
gv, const char *prefix)
 {
 	static int keep_dashdash =3D 0, stop_at_non_option =3D 0;
 	static char const * const parseopt_usage[] =3D {
-		"git rev-parse --parseopt [options] -- [<args>...]",
+		N_("git rev-parse --parseopt [options] -- [<args>...]"),
 		NULL
 	};
 	static struct option parseopt_opts[] =3D {
 		OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
-					"keep the `--` passed as an arg"),
+					N_("keep the `--` passed as an arg")),
 		OPT_BOOLEAN(0, "stop-at-non-option", &stop_at_non_option,
-					"stop parsing after the "
-					"first non-option argument"),
+					N_("stop parsing after the "
+					   "first non-option argument")),
 		OPT_END(),
 	};
=20
@@ -443,11 +443,11 @@ static void die_no_single_rev(int quiet)
 }
=20
 static const char builtin_rev_parse_usage[] =3D
-"git rev-parse --parseopt [options] -- [<args>...]\n"
-"   or: git rev-parse --sq-quote [<arg>...]\n"
-"   or: git rev-parse [options] [<arg>...]\n"
-"\n"
-"Run \"git rev-parse --parseopt -h\" for more information on the first=
 usage.";
+N_("git rev-parse --parseopt [options] -- [<args>...]\n"
+   "   or: git rev-parse --sq-quote [<arg>...]\n"
+   "   or: git rev-parse [options] [<arg>...]\n"
+   "\n"
+   "Run \"git rev-parse --parseopt -h\" for more information on the fi=
rst usage.");
=20
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
--=20
1.7.10.2.549.g9354186
