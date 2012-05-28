From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 43/65] i18n: prune-packed: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:55 +0700
Message-ID: <1338203657-26486-41-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy3o-0004Ew-LC
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2E1LYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab2E1LYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4541874pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7uimSGww1MYlsWQqTySuHi/iHbdo4GEyKN73tJkIo2Q=;
        b=JzHXbwVeGQENnGx9YFHTWdggsGcq3ar8X80n8VpVltT8Vr2rXyQ7Inn+ZauSzHXvPo
         EwydJHo1YKwb9oyiT+XZ1iQvgtqakwDrxCMttbwNkdJEsaLLlTztnI3rqd4pfn4/TkU/
         TMeocrHENxBKnukDXxCyJbUgP3scnKSLcFCCmFGvOhRlMRxsJ84LDb069pJCG02914G+
         f/VGqeIfFzxxYep+AGD5LaaB+hx2dekqZHI2O3Mz22jWLET5A5A+MVfTtYtV2PcsdQ5U
         LVM4URHuaQGcH8ETck/lFkeRcs5z4P2GijOQS6Ryw1ZwGdb85nke7Gg/Qfv2eiWmjR38
         OzRw==
Received: by 10.68.238.228 with SMTP id vn4mr26114383pbc.132.1338204263122;
        Mon, 28 May 2012 04:24:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qt10sm18996051pbc.57.2012.05.28.04.24.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:20:17 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198679>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/prune-packed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index b58a2e1..83382c1 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
=20
 static const char * const prune_packed_usage[] =3D {
-	"git prune-packed [-n|--dry-run] [-q|--quiet]",
+	N_("git prune-packed [-n|--dry-run] [-q|--quiet]"),
 	NULL
 };
=20
@@ -73,8 +73,8 @@ int cmd_prune_packed(int argc, const char **argv, con=
st char *prefix)
 {
 	int opts =3D isatty(2) ? VERBOSE : 0;
 	const struct option prune_packed_options[] =3D {
-		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
-		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
+		OPT_BIT('n', "dry-run", &opts, N_("dry run"), DRY_RUN),
+		OPT_NEGBIT('q', "quiet", &opts, N_("be quiet"), VERBOSE),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
