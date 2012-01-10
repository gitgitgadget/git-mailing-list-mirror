From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/10] t5601: add missing && cascade
Date: Tue, 10 Jan 2012 16:56:58 +0700
Message-ID: <1326189427-20800-2-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYSS-00051S-Vm
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab2AJJ52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:57:28 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49885 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147Ab2AJJ51 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 04:57:27 -0500
Received: by obcwo16 with SMTP id wo16so5292866obc.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cFaSz5bVnuZyr+3jnuFe+elGwXmpbBaL4ZVCk5oVtqw=;
        b=lrk/YOhW4A/MB379wZ2cBOEio7iB8YilxaCZNUZPF9O3qoOek2h/qdZmG+O6tf+aia
         tWZ5LApWaba8MQP9CbmiyLOhyr2n+APsyC/o5Fq1ctSMzUIq1BWq8Y+dbbpteei3pKPx
         VKSIwXliBp3OvS5NqdRPzGEVSKuxdLuji9mxE=
Received: by 10.50.219.225 with SMTP id pr1mr1370786igc.21.1326189446966;
        Tue, 10 Jan 2012 01:57:26 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r18sm261439727ibh.4.2012.01.10.01.57.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:57:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:18 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188233>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5601-clone.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 87ee016..49821eb 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -9,9 +9,9 @@ test_expect_success setup '
 	rm -fr .git &&
 	test_create_repo src &&
 	(
-		cd src
-		>file
-		git add file
+		cd src &&
+		>file &&
+		git add file &&
 		git commit -m initial
 	)
=20
--=20
1.7.3.1.256.g2539c.dirty
