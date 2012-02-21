From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] t3900: add missing UTF-16.txt and mark the test successful
Date: Tue, 21 Feb 2012 21:24:49 +0700
Message-ID: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:25:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzqf4-0004Uy-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab2BUOZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:25:42 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64503 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab2BUOZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:25:41 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so6934617dae.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:25:41 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.226.41 as permitted sender) client-ip=10.68.226.41;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.226.41 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.226.41])
        by 10.68.226.41 with SMTP id rp9mr66676670pbc.162.1329834341471 (num_hops = 1);
        Tue, 21 Feb 2012 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9vjhGk+Em8RyoX1Oik9CLDogO3FRbgS1zUc1stTE29Y=;
        b=DrFA5TnTSxIOFWxxt9THEiGCaTv8vVkU2PeyoTagWMnldB1ZiXeoNRoXoWXKCZpi39
         9hXiQKY5Wdk0xaTF82TUw9K4LQVizEPbWFD5zr9ekxy3ebfK8Lixpgd7Kl380Sh7toPi
         bnGWAaOjMb0Zj2LXM+bNMg/C14odmqBipyEHg=
Received: by 10.68.226.41 with SMTP id rp9mr55570339pbc.162.1329834341409;
        Tue, 21 Feb 2012 06:25:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id e6sm16184305pbr.74.2012.02.21.06.25.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 06:25:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Feb 2012 21:24:52 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191157>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3900-i18n-commit.sh |    4 ++--
 t/t3900/UTF-16.txt     |  Bin 0 -> 18 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)
 create mode 100644 t/t3900/UTF-16.txt

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index d48a7c0..a9e5662 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,9 +34,9 @@ test_expect_success 'no encoding header for base case=
' '
 	test z =3D "z$E"
 '
=20
-test_expect_failure 'UTF-16 refused because of NULs' '
+test_expect_success 'UTF-16 refused because of NULs' '
 	echo UTF-16 >F &&
-	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
+	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
=20
=20
diff --git a/t/t3900/UTF-16.txt b/t/t3900/UTF-16.txt
new file mode 100644
index 0000000000000000000000000000000000000000..8d0945b8e0a734ced8948da=
29ed9f8c65e3ec775
GIT binary patch
literal 18
VcmezW&xIi$409P$8B!Ry7yv#b1kV5f

literal 0
HcmV?d00001

--=20
1.7.8.36.g69ee2
