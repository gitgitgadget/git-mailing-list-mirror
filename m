From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 01/10] t5601: add missing && cascade
Date: Mon, 16 Jan 2012 16:46:07 +0700
Message-ID: <1326707176-8045-2-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:46:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmj9E-0002d2-Ur
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab2APJqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:46:35 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61203 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab2APJqe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 04:46:34 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so4312998obc.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cFaSz5bVnuZyr+3jnuFe+elGwXmpbBaL4ZVCk5oVtqw=;
        b=irPWeGnSwDELCTTkPo40d11oPvgklV+74ru7IRguEUHMVXRYE/xCBWNJBO5Ezf+udK
         8uSHFMilgg6nGNp1FRm4y9PntaY9kUJzTf56+ZEG861S0S0jYu+YCo/yslgSBvQrY6FZ
         j5ys06jeRb7/266Ff4yydQkij/VhEbec+SqJw=
Received: by 10.50.189.199 with SMTP id gk7mr9437248igc.30.1326707194360;
        Mon, 16 Jan 2012 01:46:34 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py4sm24306146igc.2.2012.01.16.01.46.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:46:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:46:25 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188616>

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
