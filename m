From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] wt-status.c: make cut_lines[] const to shrink .data section a bit
Date: Sun, 16 Feb 2014 10:37:18 +0700
Message-ID: <1392521840-21628-2-git-send-email-pclouds@gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 04:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEsXp-0008OH-P9
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 04:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaBPDhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 22:37:22 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:54433 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaBPDhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 22:37:21 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so13892555pbc.12
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 19:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tySkdcK5Q0ELuPpnbWcM1s8Cx/isaRPDB46T4WLaVdw=;
        b=WJ8guIx+Od36gvvf7x/bgv0YT0S93ocwRvahx77EA+a15D7OjyItj/mlqUjlntyTkC
         cUas3ccn4r8fPyeusKMY1G4/6/naa09JcNe8XCBRjDqcYWoMlk0/OouRRmaDlAIRnUUi
         trWWBpheXW+whaiSWKIwFjK7wdkEYodPIm8WbQG/CGN+nT5e7cSW74Ri10AGa6Sj51Se
         C0ZHUa6XPe6nHrDUV0QAOxWo0ZuMgalDwNNxGZuuAJ9ZsErGaH0rm9df/k5uGao4A7b6
         68g05euGJJ3UUHWVcaVWapl82y2lg8Icv8mciSAXLU5LHog0rrN/N80QZDBptJBnveCo
         Rclw==
X-Received: by 10.68.133.138 with SMTP id pc10mr18255613pbb.98.1392521840091;
        Sat, 15 Feb 2014 19:37:20 -0800 (PST)
Received: from lanh ([115.73.213.123])
        by mx.google.com with ESMTPSA id si6sm81353800pab.19.2014.02.15.19.37.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 19:37:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Feb 2014 10:37:30 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242209>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..65e35c3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -17,7 +17,7 @@
 #include "strbuf.h"
 #include "utf8.h"
=20
-static char cut_line[] =3D
+static const char cut_line[] =3D
 "------------------------ >8 ------------------------\n";
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
--=20
1.8.5.2.240.g8478abd
