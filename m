From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/2] update-index: list supported idx versions and their features
Date: Sat, 23 Feb 2013 09:29:31 +0700
Message-ID: <1361586571-12917-1-git-send-email-pclouds@gmail.com>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 03:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U94rM-0004Ot-8E
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 03:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763Ab3BWC2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 21:28:39 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51122 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab3BWC2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 21:28:38 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so784721pab.15
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cZVuMrLwysabrnRyCkJ/+OgtY0tLNXaxmAg6PuD+w/g=;
        b=csNtuqfCSqOaKa3snxLUes7XIhAJX6su3/9IoqyYznWh8t7uLXfgcp/VX4DfSRqm4n
         uxeUV6Yxuo1gCFW3c1c989r3Dtk/d4LX7zBxJc9PcFBWrZmpvFp8qPPWRdTyFFGAfqR0
         I0DpBh3CrCtjJXQRD66DbsPKGkU6JRMTQCQKUT+0KFnUjhjFZt+O35kbHG0daTmbyPdM
         Nu5KTHrowSLEQOb0F3H9fqGIWPUFutUw+9Cqb+iCyx2ZEksb/0s3IAFnKK0hy0YtVgmf
         Bgao8aDiKiOg7bIYjtQD/u0nx2tP7rLJB7nfQE+iS/JCn5ypUSA4MA16tiCCwCzcrxlg
         8U/g==
X-Received: by 10.66.147.39 with SMTP id th7mr7358425pab.136.1361586518065;
        Fri, 22 Feb 2013 18:28:38 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id bi2sm4906440pab.18.2013.02.22.18.28.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 18:28:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Feb 2013 09:29:33 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216888>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Oops, bogus indentation in the first 3/2

 Documentation/git-update-index.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 77a912d..dbb75f4 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -145,7 +145,14 @@ you will need to handle the situation manually.
=20
 --index-version <n>::
 	Write the resulting index out in the named on-disk format version.
-	The current default version is 2.
+	Supported versions are 2, 3 and 4. The current default version is 2
+	or 3, depending on whether extra features are used, such as
+	`git add -N`.
++
+Version 4 performs a simple pathname compression that could reduce
+index size by 30%-50% on large repositories, which results in faster
+load time. Version 4 is relatively young (first released in in 1.8.0
+in October 2012). Other Git implementations may not support it yet.
=20
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
--=20
1.8.1.2.536.gf441e6d
