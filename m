From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] t5403: convert leading spaces to tabs
Date: Wed, 12 Oct 2011 20:35:04 +1100
Message-ID: <1318412105-13595-2-git-send-email-pclouds@gmail.com>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 11:35:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDvDz-0007vl-SP
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 11:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab1JLJfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 05:35:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37380 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1JLJff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 05:35:35 -0400
Received: by ywb5 with SMTP id 5so491291ywb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aFVwc31+u82y+Rh5AqDbZo1tHfbDI6CnCG2Phpy+HXU=;
        b=AiupDYUag0YLY3Fy3Xn8QR0pKazuHgOqolCpDv8ums4Pyn3K0TVEWnqGYyFZOBEyU9
         A6QQUIvb6/JAZPuCDz85cjRcbYKs0iO6mKIUH5BXAhrjaBxIYFN6il5bu+mh2VW/uXM5
         8TTzaM9ZdWnwssIjWcLO+qaV7cDP8sWyXFBQA=
Received: by 10.236.123.43 with SMTP id u31mr34941274yhh.97.1318412135144;
        Wed, 12 Oct 2011 02:35:35 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id p54sm2132391yhh.1.2011.10.12.02.35.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 02:35:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 20:35:20 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183364>

The first and last tests use tabs. The rest uses spaces. Convert all
to tabs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5403-post-checkout-hook.sh |   46 ++++++++++++++++++++-------------=
-------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook=
=2Esh
index 0c126d7..6643f32 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -28,44 +28,44 @@ EOF
 done
=20
 test_expect_success 'post-checkout runs as expected ' '
-        GIT_DIR=3Dclone1/.git git checkout master &&
-        test -e clone1/.git/post-checkout.args
+	GIT_DIR=3Dclone1/.git git checkout master &&
+	test -e clone1/.git/post-checkout.args
 '
=20
 test_expect_success 'post-checkout receives the right arguments with H=
EAD unchanged ' '
-        old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-        new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-        flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old =3D $new -a $flag =3D 1
+	old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+	new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+	flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test $old =3D $new -a $flag =3D 1
 '
=20
 test_expect_success 'post-checkout runs as expected ' '
-        GIT_DIR=3Dclone1/.git git checkout master &&
-        test -e clone1/.git/post-checkout.args
+	GIT_DIR=3Dclone1/.git git checkout master &&
+	test -e clone1/.git/post-checkout.args
 '
=20
 test_expect_success 'post-checkout args are correct with git checkout =
-b ' '
-        GIT_DIR=3Dclone1/.git git checkout -b new1 &&
-        old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-        new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-        flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old =3D $new -a $flag =3D 1
+	GIT_DIR=3Dclone1/.git git checkout -b new1 &&
+	old=3D$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+	new=3D$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+	flag=3D$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test $old =3D $new -a $flag =3D 1
 '
=20
 test_expect_success 'post-checkout receives the right args with HEAD c=
hanged ' '
-        GIT_DIR=3Dclone2/.git git checkout new2 &&
-        old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-        new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-        flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old !=3D $new -a $flag =3D 1
+	GIT_DIR=3Dclone2/.git git checkout new2 &&
+	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test $old !=3D $new -a $flag =3D 1
 '
=20
 test_expect_success 'post-checkout receives the right args when not sw=
itching branches ' '
-        GIT_DIR=3Dclone2/.git git checkout master b &&
-        old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-        new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-        flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old =3D $new -a $flag =3D 0
+	GIT_DIR=3Dclone2/.git git checkout master b &&
+	old=3D$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+	new=3D$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+	flag=3D$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test $old =3D $new -a $flag =3D 0
 '
=20
 if test "$(git config --bool core.filemode)" =3D true; then
--=20
1.7.3.1.256.g2539c.dirty
