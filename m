From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/5] path.c: delete an extra space
Date: Sat, 22 Aug 2015 07:39:58 +0700
Message-ID: <1440204002-7638-2-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
 <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSwrx-0005K7-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbbHVAlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:07 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34073 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbHVAlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:05 -0400
Received: by padfo6 with SMTP id fo6so17450113pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=misWsALusl9s+QalsfA/upwdf4KY4fAWJiehwOKu8YA=;
        b=xFLwwHRL41oYdWZ0zxQjuiK+ELAhOG2vm2/yCDz5RP+CbYrhPrTljAz7qImMevkkxZ
         8HPavLYxG//JjfeYKd+yBEv2Lqt3Hd5GbY4xUezYWusn2K7eJ3F7yaDxfk9dGPya8+F6
         0t8Jjf57nBYSgYynXHTnDE8cLYhWBx2q9vNX16UuKNz6b6J96qmoNLkpzr9ZWZWgWaVq
         HD2bvOqxAHcv6iyEpD6yGRsY4tT5dHkBoaF29dWteq928eCLwh00EbJPfBL5fduiBsgj
         MWK5Sq/XmacIDkKlCsVBDJuu7FXdWqGmrTrwDQ/UNHY5nd/KLW297n1/UaNQddk5hKez
         7wig==
X-Received: by 10.68.65.47 with SMTP id u15mr22470781pbs.127.1440204065307;
        Fri, 21 Aug 2015 17:41:05 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id jr12sm9062475pbb.91.2015.08.21.17.41.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:41:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:41:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276349>

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
