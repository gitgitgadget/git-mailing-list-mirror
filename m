From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] index-pack: remove dead code (it should never happen)
Date: Sun, 31 Mar 2013 18:09:06 +0700
Message-ID: <1364728148-7537-3-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMG8x-0007LH-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab3CaLJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:09:18 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62272 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab3CaLJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:09:17 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa10so916310pad.27
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 04:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=hYohwNFWxL01GLBcOXU+jHbEoqiH5e42uaEbmqH74Tk=;
        b=tuJrvNrpBD6lD58hwMcFDEg7qfmuG1KlOjnT+zoa5dlvD9wtUM9skK4QOhOBErPfez
         1pitCE7j+kRBaxHgb1X2DrpDOyCYPElWe37/h8A3b9en1qZ/tgh7GFmwyQgtrkCEJTp5
         JSaIgdOIN+6AFQ5DwMSb/Sp2NNeBEnTQytiJOPoCNfMAWjpFiLWgQ5nIHw057bQeN60+
         KxlNANPmXJ/dAuR8MupBdzOyIAXeS8d5MEy7HI8xLfDy8e7PRAomh0HmMzywqhP+Y3ZN
         D4o2ENNAj8OJr4Dyk79wjhPPGfw9BpyKglBBQoYA6twf1950WlbFnK2PlkLz2O1oJiwo
         bhow==
X-Received: by 10.66.147.161 with SMTP id tl1mr13497911pab.61.1364728156801;
        Sun, 31 Mar 2013 04:09:16 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id s6sm5536113pbi.37.2013.03.31.04.09.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 04:09:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 18:09:23 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219614>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ef62124..fdac7c7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -735,8 +735,7 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 			int eaten;
 			void *buf =3D (void *) data;
=20
-			if (!buf)
-				buf =3D new_data =3D get_data_from_pack(obj_entry);
+			assert(data && "data can only be NULL for large blobs");
=20
 			/*
 			 * we do not need to free the memory here, as the
--=20
1.8.2.83.gc99314b
