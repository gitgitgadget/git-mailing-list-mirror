From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/6] path.c: delete an extra space
Date: Mon, 28 Sep 2015 20:06:11 +0700
Message-ID: <1443445576-29526-2-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8T-0005ZD-9p
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640AbbI1NGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:24 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34507 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbbI1NGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:23 -0400
Received: by padhy16 with SMTP id hy16so174446216pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=misWsALusl9s+QalsfA/upwdf4KY4fAWJiehwOKu8YA=;
        b=uOmrzUwfQKcEkuDhSzJ4F9D+RhIBbh7U8BcYQibZmQgoRBaHCkiuy1ObyzY4d8OtnC
         YyGDoWRT4qGepKkGQYSwH1XecP4UID1kLqtgwJstP/dWEzhRzQnDeYvNYUplFU4jKq/m
         5D+GEFEEVxJB8uXWODspbqaMOaEcyIW82Eeoowkx3BiRv3DvneGM+oX/CRje5EGW1tnx
         U4/UgFGxUAwok8/xVUgbmO4oMALnFOiakDbq+fpMWx3jhwY48eUN4Ol37KuCaMNYkpBW
         bCmm7UKX65upApKrn23ECqpCrVm1RUfYxLxgPhUWxQp+vPhBemyr45zn5evK7i1Q1Khp
         iH8g==
X-Received: by 10.66.139.232 with SMTP id rb8mr26480234pab.99.1443445583018;
        Mon, 28 Sep 2015 06:06:23 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id f5sm19484599pas.23.2015.09.28.06.06.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:06:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278717>

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
