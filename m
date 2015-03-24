From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git.txt: list index versions in plain English
Date: Tue, 24 Mar 2015 07:28:33 +0700
Message-ID: <1427156913-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 01:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaCiM-0008V6-59
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 01:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbbCXA26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 20:28:58 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33726 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbCXA25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 20:28:57 -0400
Received: by pdnc3 with SMTP id c3so203494843pdn.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4Ilucxe1FzZIuQ0WZ1xevGpdjfomj+4qRjH2Qdzb8oI=;
        b=e5UpCFVLaRNouk2HfEJEpufe6ZaYmFaadSxalL3/VUgF7aGOiEkmyqA1qIeqbCyBEM
         0wz/SBNvnb/tl7+y8c50FK0/TgPF8PQyLbSpZBGEhz/rnVfd2zWTsnLTjGONoVADPaA3
         6OibyEEdFwtYRMh0l+EG2Yv82UP1IqpcEoJGoi8EcwxhxNEyO3vzG9PpUe9Tel8nPDe3
         h1qjInYKlGU2lQZeyaIVjH4mnEnuPaxH9yxBIZlB34j1K+nxgYGSYNdEwS4f0Kx5adFO
         gDbCsZ8ZFdck4QMbosX4BY17sz7TX2Ns+A69fypxVunsncucaIGnN2OwI/Ur7tfLSzhd
         adbw==
X-Received: by 10.66.160.197 with SMTP id xm5mr2747448pab.51.1427156936667;
        Mon, 23 Mar 2015 17:28:56 -0700 (PDT)
Received: from duynguyen-vnpc.dek-tpc.internal ([14.161.14.188])
        by mx.google.com with ESMTPSA id qv9sm2203213pab.27.2015.03.23.17.28.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 17:28:55 -0700 (PDT)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266169>

At the first look, a user may think the default version is "23". Even
with UNIX background, there's no reference anywhere close that may
indicate this is glob or regex.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b37f1ab..29d9257 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -766,7 +766,8 @@ Git so take care if using Cogito etc.
 'GIT_INDEX_VERSION'::
 	This environment variable allows the specification of an index
 	version for new repositories.  It won't affect existing index
-	files.  By default index file version [23] is used.
+	files.  By default index file version 2 or 3 is used. See
+	linkgit:git-update-index[1] for more information.
=20
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
--=20
2.2.0.513.g477eb31
