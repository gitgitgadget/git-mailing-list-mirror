From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 49/66] i18n: rerere: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:38 +0700
Message-ID: <1345465975-16927-50-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLV-0000MO-4g
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab2HTMog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab2HTMoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OCnToxCJNazNlMEA1plVTu7UH+6dswrSwqmD33y/6Cg=;
        b=ATiz0Szze3aJxa3aVSLsX4D7mk/0mtmAO8kOoNkVQnwKhrNrTtuclyFwXYZF/di+Zb
         mhS//dhlKNb6PtfiwVIy3zgov/x/6FBOYwvgR5BI5rg4/cbEoA1Q1BHIj+R168IWReRE
         k4asMgpC3PCnVpggSGLbd9v7/Xqtyu9QRUwAFQky2669sFM6X6UriPt38skyR7Z/rI4Z
         pHXKfpgPwU4qdrerLdvHc652PJmKPoGo6SjP29Ekv87or3fmRt0o5SJQVWp3LB9gqCC1
         dvGo9q+Gv30acGvZqkjfQPGLTe0XjJPxyweMLZ/y0CLBeAWdnolJehJUgxp6lfQAbHs7
         oPVA==
Received: by 10.68.227.165 with SMTP id sb5mr34081855pbc.82.1345466674310;
        Mon, 20 Aug 2012 05:44:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qn13sm11030920pbb.71.2012.08.20.05.44.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:34 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203821>

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
1.7.12.rc2.18.g61b472e
