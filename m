From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 58/65] i18n: symbolic-ref: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:10 +0700
Message-ID: <1338203657-26486-56-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy64-00071l-Ai
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab2E1L0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab2E1L0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cqTCFsXZukUR9b8V97qwPKIlgFVU+EzWYMv65Jw06HE=;
        b=aqFWNHm0m+fTohtzHuN8yYNFV4QV0biziX78rRUCngsLdvWVxbNNOwzeAKF8Wv1apl
         cUD+TQ/FxfdkBfm0VQtfhzPIB8KTGP6fDENk9eJnMrDQvSjHeaoehrnfqjhYiS+qXIFq
         RZn+BBZk483jVny48qUPabHfkA+s4/MO/J94k/QKY4XXQam/ogTvtNGEr4L3XkVBeXJn
         S2eWGWOGAUInlZm3lBI5xb4g1+13pvniGv5VANDp3uc1c1no3Ha6SvYXnC1VVmE/mbka
         289IiRakxSyZx2ICaDWo1U9RquXSthe9mhT3CghMHtsY4YuLMOyt17JGZMl95bmXolSp
         3nlw==
Received: by 10.68.220.98 with SMTP id pv2mr26638534pbc.117.1338204402990;
        Mon, 28 May 2012 04:26:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id kh10sm18996508pbc.67.2012.05.28.04.26.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:37 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198694>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/symbolic-ref.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..9e92828 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
=20
 static const char * const git_symbolic_ref_usage[] =3D {
-	"git symbolic-ref [options] name [ref]",
+	N_("git symbolic-ref [options] name [ref]"),
 	NULL
 };
=20
@@ -35,9 +35,9 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 	const char *msg =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet,
-			"suppress error message for non-symbolic (detached) refs"),
-		OPT_BOOL(0, "short", &shorten, "shorten ref output"),
-		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
+			N_("suppress error message for non-symbolic (detached) refs")),
+		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
+		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")=
),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
