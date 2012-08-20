From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 62/66] i18n: verify-pack: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:51 +0700
Message-ID: <1345465975-16927-63-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMm-0001M2-GL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab2HTMpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2HTMpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:54 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2157219dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Iuj+81ZfJ6keHTxRgpoBlc0QCBrhSSQySQO9/FjzfuE=;
        b=JJBRcCrh3ON2XsTiyAqtF6cJIXaSuMgqAlwxpt+Wx30aJNda6L3RK15uy2aViAZAFG
         FaBiNXe+608+8h/6pGvA2oW2bnfFbBhi1wE57ck6xCvcXNbDGu8YiLxmJ5f41HcLb5o5
         5KeA2Oigd3C8YEzzzyCxpZpjv32je8l/RUlnvNAMguk5ZZpT8bD0/FAEyujUNrf/frw4
         G30I8zTSDwuQlMmQqNJfmKxUH11JcTlwjikP/yjEmqoUpNBPKmlxJoF53x7kayyaQeMm
         1E1PDQVMpdmLWVEmUFnkydMfImoKRQ92pJDLdzmR2qkftroqJ06NXKoSJdixeAH1PTz6
         LxJQ==
Received: by 10.68.235.236 with SMTP id up12mr33955124pbc.79.1345466753828;
        Mon, 20 Aug 2012 05:45:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id nd2sm11054438pbc.7.2012.08.20.05.45.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:53 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203834>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/verify-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index e841b4a..66cd2df 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -53,7 +53,7 @@ static int verify_one_pack(const char *path, unsigned=
 int flags)
 }
=20
 static const char * const verify_pack_usage[] =3D {
-	"git verify-pack [-v|--verbose] [-s|--stat-only] <pack>...",
+	N_("git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."),
 	NULL
 };
=20
@@ -63,9 +63,9 @@ int cmd_verify_pack(int argc, const char **argv, cons=
t char *prefix)
 	unsigned int flags =3D 0;
 	int i;
 	const struct option verify_pack_options[] =3D {
-		OPT_BIT('v', "verbose", &flags, "verbose",
+		OPT_BIT('v', "verbose", &flags, N_("verbose"),
 			VERIFY_PACK_VERBOSE),
-		OPT_BIT('s', "stat-only", &flags, "show statistics only",
+		OPT_BIT('s', "stat-only", &flags, N_("show statistics only"),
 			VERIFY_PACK_STAT_ONLY),
 		OPT_END()
 	};
--=20
1.7.12.rc2.18.g61b472e
