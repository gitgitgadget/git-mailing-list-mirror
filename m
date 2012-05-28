From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/65] i18n: mv: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:50 +0700
Message-ID: <1338203657-26486-36-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:23:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy34-0003GG-FA
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2E1LXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:23:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab2E1LXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:23:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6quph/k5SbvSJZPO5pIPr0GXbmSZJUnwodz50B7WYZM=;
        b=XE5bmTsnXW0a1muGSbNICAh8rR5dNOKnjMvPG7hwFhYTrdn9HZeXCu1BaHpd/Y2w4P
         B9ihlBLr/0C7q33VD5jtZX9TdiwdcMGenUdSOYqoBSHzd/mGTNmxC/xzosMguEQAEM4d
         uvmO4FTumt5OGJWDIl45Xitc4/qx5d4xIBieY3wMm14X656A1Msd2lDgIclhwzOo8Uh4
         jTuZIZh7QfIG53WO5SqBtcEgXVOXlp733NYvRMXZGt5kianjKEZ1TFgVNdfbUFXgxe57
         jtF+MeZ1wxWUFxxQijiqRm7uQPXURD6YpYt2oC1qwYMeCKs7rRVR5J0M2Y8AsZK6DJDi
         4pTw==
Received: by 10.68.226.99 with SMTP id rr3mr26463042pbc.48.1338204217306;
        Mon, 28 May 2012 04:23:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id i1sm18992739pbv.49.2012.05.28.04.23.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:23:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:31 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198674>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2a144b0..034fec9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
=20
 static const char * const builtin_mv_usage[] =3D {
-	"git mv [options] <source>... <destination>",
+	N_("git mv [options] <source>... <destination>"),
 	NULL
 };
=20
@@ -59,10 +59,10 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 	int i, newfd;
 	int verbose =3D 0, show_only =3D 0, force =3D 0, ignore_errors =3D 0;
 	struct option builtin_mv_options[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose"),
-		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT__FORCE(&force, "force move/rename even if target exists"),
-		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__FORCE(&force, N_("force move/rename even if target exists")),
+		OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")=
),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path;
--=20
1.7.10.2.549.g9354186
