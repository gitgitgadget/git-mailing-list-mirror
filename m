From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 01/10] t5601: add missing && cascade
Date: Fri, 13 Jan 2012 14:21:53 +0700
Message-ID: <1326439322-15648-2-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbT2-0007tq-92
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab2AMHWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:22:23 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37541 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab2AMHWX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 02:22:23 -0500
Received: by obcva7 with SMTP id va7so1808457obc.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cFaSz5bVnuZyr+3jnuFe+elGwXmpbBaL4ZVCk5oVtqw=;
        b=mZ2Z/qFoW1+GtbEXqfOsaP9bLhfuECpuCJPMC4u8249xGhi8PXC/exPUIrN39OyAzm
         331d1LluYmk+6VOhehP4xq/jwrmXwXtdD8tygzrV/Gu07wqglVkMLlElIvCwc8rM3j03
         f3gWPGMP7r5f+fJpZx0mWXjiKybtBjxX6avWQ=
Received: by 10.50.160.201 with SMTP id xm9mr1469312igb.16.1326439342486;
        Thu, 12 Jan 2012 23:22:22 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lu10sm13102692igc.0.2012.01.12.23.22.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:22:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188498>

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
