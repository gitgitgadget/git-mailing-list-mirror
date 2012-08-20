From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/66] i18n: bisect--helper: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:53 +0700
Message-ID: <1345465975-16927-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGV-0005Gp-38
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab2HTMjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2HTMjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sGoymNbm3qTfwLUgCh3xPnsafHB1XhhjKTiFkdai5xQ=;
        b=IjpOqT+ZWX3MSazAER5XxCj1PDUvgP60mH5tE40aPd4z+S1WsHiCdHowUXXt5lx6/B
         XSy01z+08iqnk1VaVQeIp/vkMjJToyrB3/OWZ8SlxefYBnMdob8M8bKKbdL3d+gAenXG
         aNranBVxQfJrq9paTil8jwevi1ZEc1yZkcl732H6wC8oQz7/2Q0CqPCyyxL8XnyUPxvU
         6c3qXT2tNAa7ELI8R4dQZUASBf5NFO+/u4NNUZ+Hfqiz9MSgVLPZP/Sy9rmC6gss7Zdp
         oANWES+MJ+gZkRayN+gnPTw9rfGDxHsAhnC1wa2AOgLJ5rvEQd45zJi2TLZ+StCB4aQV
         9Pjw==
Received: by 10.68.135.67 with SMTP id pq3mr34861859pbb.49.1345466362844;
        Mon, 20 Aug 2012 05:39:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kt8sm11043242pbc.1.2012.08.20.05.39.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:22 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203775>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/bisect--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8d325a5..e3884e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,7 +4,7 @@
 #include "bisect.h"
=20
 static const char * const git_bisect_helper_usage[] =3D {
-	"git bisect--helper --next-all [--no-checkout]",
+	N_("git bisect--helper --next-all [--no-checkout]"),
 	NULL
 };
=20
@@ -14,9 +14,9 @@ int cmd_bisect__helper(int argc, const char **argv, c=
onst char *prefix)
 	int no_checkout =3D 0;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "next-all", &next_all,
-			    "perform 'git bisect next'"),
+			    N_("perform 'git bisect next'")),
 		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
-			    "update BISECT_HEAD instead of checking out the current commit"=
),
+			    N_("update BISECT_HEAD instead of checking out the current comm=
it")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e
