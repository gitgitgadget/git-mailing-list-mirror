From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] t5601: add &&
Date: Sun,  8 Jan 2012 18:46:23 +0700
Message-ID: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 12:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrDN-0000TL-76
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 12:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab2AHLq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 06:46:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39267 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab2AHLq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 06:46:56 -0500
Received: by iaeh11 with SMTP id h11so5239138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XZ/4TAceu8h18hypUkLWKsSeAoZe9jduhWdWb7ngp84=;
        b=xF4IYCPFvqVKKfMksxbb1/tKltVWP7vX7bRjb5/mghCf/Gec6zRZZexXpjiYIDZWk0
         0wYebpdSRtW34/wj8FhVmbn0q5jAz3e8emokyCKn06K77VK6NYymashhKV/Vz3RS4HQS
         b0qDoI1/zZ3Tz4x30hc27uO2M1ROAsmv51+7I=
Received: by 10.50.180.167 with SMTP id dp7mr5261900igc.26.1326023216390;
        Sun, 08 Jan 2012 03:46:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.35.243])
        by mx.google.com with ESMTPS id py4sm9486387igc.2.2012.01.08.03.46.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 03:46:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 Jan 2012 18:46:29 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188099>


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
1.7.8.36.g69ee2
