From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/66] i18n: pack-refs: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:30 +0700
Message-ID: <1345465975-16927-42-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKd-000890-BY
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab2HTMnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CBcEHTzGVG3g2JoTVAJU1J805tAMYm1kjEJCNbYa2SU=;
        b=C243vOQnKJrln2jFPQpMjg5b+egMonfTeI7IC62H6mH2qf45NfP31NgLJwSWksFLWg
         zGSTjRgCPnaVo+/F3GfpkLqb93qTVSixetLS6AAI1kUIkr3Ol+UepEkafwUUu2dK2UnD
         3nGIXvbMKnKQWrlT+zmSOQrRnS5RxT843fj1TWsbQ9wQS3YTSJ8j9XRT7x4skYDn3iE1
         2fo48vXmn7gnas6l3x0sj2RLkGhy6gMpnrJiP1vHKOg18l/o7pBl79XYVyzjyJk0CoXx
         XeGm6dFoxQgcLBeYV+4vX13iFAetHJVIpfkEp03Rp73KMmZveTy5IQ2NXa/6HY8ydV9T
         o0JA==
Received: by 10.66.78.69 with SMTP id z5mr29550427paw.14.1345466620518;
        Mon, 20 Aug 2012 05:43:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id tq4sm11048695pbc.11.2012.08.20.05.43.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:40 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203813>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39a9d89..b5a0f88 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -3,7 +3,7 @@
 #include "pack-refs.h"
=20
 static char const * const pack_refs_usage[] =3D {
-	"git pack-refs [options]",
+	N_("git pack-refs [options]"),
 	NULL
 };
=20
@@ -11,8 +11,8 @@ int cmd_pack_refs(int argc, const char **argv, const =
char *prefix)
 {
 	unsigned int flags =3D PACK_REFS_PRUNE;
 	struct option opts[] =3D {
-		OPT_BIT(0, "all",   &flags, "pack everything", PACK_REFS_ALL),
-		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_=
PRUNE),
+		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
+		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_R=
EFS_PRUNE),
 		OPT_END(),
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
--=20
1.7.12.rc2.18.g61b472e
