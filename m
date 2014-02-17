From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] wt-status.c: make cut_line[] const to shrink .data section a bit
Date: Mon, 17 Feb 2014 19:15:30 +0700
Message-ID: <1392639332-7703-2-git-send-email-pclouds@gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
 <1392639332-7703-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 17 13:16:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFN7E-0000tM-TS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 13:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbaBQMP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 07:15:58 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59433 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbaBQMP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 07:15:57 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so14700984pde.6
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 04:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tySkdcK5Q0ELuPpnbWcM1s8Cx/isaRPDB46T4WLaVdw=;
        b=E1gRSNAvOW6OQPOgiHXWVg7VgJ2ATXZhAIWaQm3ZNEcN+0KzbZXir2NqsoTpOrmCEj
         oKq09zDL3s9lh5QUxLS3gHzqbB3FFQshkXpg+COrgQxBz4vabqe8TIWq4Q4jsV8G4DiM
         uaymyELECj3d8Zv1HVg0eUelmQRGJNsX+fqZQKO7MkJcpMg0xTrqvED8dEBJApZbDB6J
         TV4T8lrsXPjlNoWOq8/m/kaoYv53HtNdzkTO96J0PMvh91sQMeGa3rCfgR64OA6vWfJ0
         6AGyw8P8/s1N9oiUghh+B1yMiCH7MTNgkfnBMiFEoQ72up2pkBi+dcXn/KOSXErT4c8B
         FvJA==
X-Received: by 10.68.75.9 with SMTP id y9mr26195466pbv.61.1392639357127;
        Mon, 17 Feb 2014 04:15:57 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id fk4sm116404660pab.23.2014.02.17.04.15.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Feb 2014 04:15:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 17 Feb 2014 19:16:09 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392639332-7703-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242254>

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
