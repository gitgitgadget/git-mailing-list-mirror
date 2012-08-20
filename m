From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 51/66] i18n: rev-parse: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:40 +0700
Message-ID: <1345465975-16927-52-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLh-0000Wi-3e
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab2HTMos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab2HTMoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2SEKhHkdEYdGY6XJADlypHKNn6/UGkZjYqC9/de/Ttg=;
        b=V7zuAE6vw5b5sHSR3mX1s5HfsRim0x/lgocBjT1bpm9g0t/McaEwGlNUabpL84JY9u
         /OyF0VCrXEQFR/p7GAfUKFOHzBJZOCni2tj2vMk5GNUGPJ8I76L9TcToP1RpiZBHTNSj
         DyEfXzwCvc/cRlaPiB0x9M7CgIoI5VSH0QjRZQn6n0ARrEr496N6eh4vRRwn/fggP5dm
         nOfX1hijc4icWBmt+abgZMPuzi0XrYIwvjnt0NHKrkvFh4Psx7tJkVFLhhRKgLz1CJ7l
         p3i3wrlBVSfeN0Ke5vfSrCYzexBFzIZaxBDp+3ghVUR7Yh7RRez41GblOO/oGDdyT2ZT
         upJA==
Received: by 10.68.138.166 with SMTP id qr6mr33923900pbb.69.1345466686342;
        Mon, 20 Aug 2012 05:44:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id st6sm11031920pbc.58.2012.08.20.05.44.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:46 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203823>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 32788a9..bb3a516 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -324,15 +324,15 @@ static int cmd_parseopt(int argc, const char **ar=
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
@@ -449,11 +449,11 @@ static void die_no_single_rev(int quiet)
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
1.7.12.rc2.18.g61b472e
