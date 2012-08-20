From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/66] i18n: mktree: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:25 +0700
Message-ID: <1345465975-16927-37-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RK9-0007nn-M0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2HTMnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2HTMnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0zU/BgJCS12Ag0eGT11FaP6CXrpSEuhwTtnfCx2T/Qk=;
        b=BzzvN2Q2FxZg4T+g9yH8Pyj6NOJ9Gfi/aYr2ifwpvcJ7wLZUA0CWlfflzlYkufQoK6
         8SxgKYwcMrIOS6P2AGkQsZPHRZ+l6EqPhE+/e2cjIhuqUJlJD9c5m2uxAsO+hWkZJrOa
         zD8/4R5TGyeO47kxI88cTFzsCmj5SHq+qxcJfjTl/GR4h1WT/MQa38Ag2cV/TXJl3RLM
         8YCre4S8zD3deHnSO3+byP2M4zNoxLjJ+6l8KGEzz2jSLwJQMZV6ndzmBNr2ATSLWKus
         JJwdVG3Gxor62ei3D3KdbC+IhvoLImexTD0w4bJhhVWo1husrAaGwIVtlTwqa9JAlYtI
         IJXw==
Received: by 10.68.224.100 with SMTP id rb4mr34581268pbc.100.1345466588880;
        Mon, 20 Aug 2012 05:43:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id gf3sm11030062pbc.74.2012.08.20.05.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:08 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203808>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4ae1c41..f92ba40 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -64,7 +64,7 @@ static void write_tree(unsigned char *sha1)
 }
=20
 static const char *mktree_usage[] =3D {
-	"git mktree [-z] [--missing] [--batch]",
+	N_("git mktree [-z] [--missing] [--batch]"),
 	NULL
 };
=20
@@ -150,9 +150,9 @@ int cmd_mktree(int ac, const char **av, const char =
*prefix)
 	int got_eof =3D 0;
=20
 	const struct option option[] =3D {
-		OPT_SET_INT('z', NULL, &line_termination, "input is NUL terminated",=
 '\0'),
-		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing objects",=
 1),
-		OPT_SET_INT( 0 , "batch", &is_batch_mode, "allow creation of more th=
an one tree", 1),
+		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminate=
d"), '\0'),
+		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing object=
s"), 1),
+		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more=
 than one tree"), 1),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
