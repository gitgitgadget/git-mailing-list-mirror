From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/66] i18n: prune-packed: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:31 +0700
Message-ID: <1345465975-16927-43-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKj-0008Hl-IB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab2HTMnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54012 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:47 -0400
Received: by dady13 with SMTP id y13so2156474dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ma+4qwVhQN8yXaoAeCfyykBSvPaQ5vpMiLzmP/EPlsU=;
        b=X73UI1PaijHBy5CZNUFrkb715X4xkABJJnTF70OlTmTASP+AM5HVfLOXjF7kVYHmbM
         O0NV6GItWMsXmy1g1mUmHUBc03qtQe9VxiiKsPGztFVnTkHino7ejBlMT0mvDPz2LzR1
         N+/Eqmj8uiFc4vy8696MoRatJrOrOkAFf5t+N8ApiE6TjSmO/RhnF7cq3yykbzmxg0Td
         D6wQGINM8JiSPtggXjXKoxi6f2fM7m1zEYBxBKkCrKgPZhR/WyOQxXCFhmohycoablca
         viZtraMdeOTFcsmA5VoikPTP2pCVUMMbVzVYXIGs4yT6RfMhRd8FKaUBy+gn81/RH5Ac
         8BXg==
Received: by 10.66.74.67 with SMTP id r3mr29622481pav.1.1345466626578;
        Mon, 20 Aug 2012 05:43:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id uy3sm10403954pbc.29.2012.08.20.05.43.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:46 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203814>

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
1.7.12.rc2.18.g61b472e
