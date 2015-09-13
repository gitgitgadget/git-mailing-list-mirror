From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/5] path.c: delete an extra space
Date: Sun, 13 Sep 2015 08:02:24 +0700
Message-ID: <1442106148-22895-2-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgb-0006Ws-5C
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbbIMBCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33090 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbbIMBCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:16 -0400
Received: by pacex6 with SMTP id ex6so108930068pac.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=misWsALusl9s+QalsfA/upwdf4KY4fAWJiehwOKu8YA=;
        b=YSJ0nCA0dbEwgnRd78rmX5U5NIw1bM5yo49qsAUyPdJ2TaP+3Sqwp4KrCqQkxt+zag
         EQtFG5YNCouUJzIb3WjeB9lMc1DfVi8x44it2XOpi3zkJW5otqUnsX/5e+GkTfIRSF40
         xXbTGmxhWS2Qdd4Et0OFnIu6YzxsBH9vZ/sBH+bwPWDw+CyXZxqirM0pVABWQQvfjWzN
         +cvYMC2Qm/Oso09lvcfBaDK/Bx04mvIyY0I3IlBvF2W6ppH2hRmTYbj6vJ93QjTJKdap
         Cuz4qxTds7UQbxMThmusxSkZSMDnO4EQ1M2qJAVUMxr2OjdbXs6FyD4MWt9M/lRozj/d
         qHHw==
X-Received: by 10.68.135.232 with SMTP id pv8mr16125967pbb.103.1442106135944;
        Sat, 12 Sep 2015 18:02:15 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id qe6sm7923143pbb.90.2015.09.12.18.02.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277743>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 95acbaf..a536ee3 100644
--- a/path.c
+++ b/path.c
@@ -431,7 +431,7 @@ const char *enter_repo(const char *path, int strict=
)
 		}
 		if (!suffix[i])
 			return NULL;
-		gitfile =3D read_gitfile(used_path) ;
+		gitfile =3D read_gitfile(used_path);
 		if (gitfile)
 			strcpy(used_path, gitfile);
 		if (chdir(used_path))
--=20
2.3.0.rc1.137.g477eb31
