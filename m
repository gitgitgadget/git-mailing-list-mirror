From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 1/6] t9200: use "git cvsexportcommit" without dash
Date: Wed, 10 Sep 2008 06:25:24 +0900
Message-ID: <20080910062524.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAk8-0007HH-FF
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbYIIV0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYIIV0S
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:18 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33440 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbYIIV0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:18 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 1FB33C89D9;
	Tue,  9 Sep 2008 16:26:08 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id GVK1QMS19133; Tue, 09 Sep 2008 16:26:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=kukzkVaGuvzDPsT9TqhRuBABmOTMWYEx+1fgyI+cNgp8ruEu4xnA5YpmdL80jLRzsVGgOzjMx9KvwN6TbrMo6m1EDJb2UBK7IDfPNHFMBbIOelJWU8dv7Lctyh1I0WzFca3thud+9vygcp2TcEX2QPyKKO2Cbb/77VniZfgy/xE=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id:Signed-off-by;
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95434>

---
 t/t9200-git-cvsexportcommit.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index 988c3ac..245a7c3 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -9,7 +9,7 @@ test_description=3D'Test export of commits to CVS'
 cvs >/dev/null 2>&1
 if test $? -ne 1
 then
-    test_expect_success 'skipping git-cvsexportcommit tests, cvs not f=
ound' :
+    test_expect_success 'skipping git cvsexportcommit tests, cvs not f=
ound' :
     test_done
     exit
 fi
@@ -91,7 +91,7 @@ test_expect_success \
      diff F/newfile6.png ../F/newfile6.png
      )'
=20
-# Should fail (but only on the git-cvsexportcommit stage)
+# Should fail (but only on the git cvsexportcommit stage)
 test_expect_success \
     'Fail to change binary more than one generation old' \
     'cat F/newfile6.png >>D/newfile4.png &&
@@ -165,7 +165,7 @@ test_expect_success \
       git commit -a -m "With spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id &&
+      git cvsexportcommit -c $id &&
       check_entries "G g" "with spaces.png/1.1/-kb|with spaces.txt/1.1=
/"
       )'
=20
@@ -177,7 +177,7 @@ test_expect_success \
       git commit -a -m "Update with spaces" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c $id
+      git cvsexportcommit -c $id
       check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2=
/"
       )'
=20
@@ -202,7 +202,7 @@ test_expect_success \
       git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -v -c $id &&
+      git cvsexportcommit -v -c $id &&
       check_entries \
       "=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=
=C3=A5/=C3=A4/=C3=B6" \
       "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb|g=C3=A5rdets=C3=A5g=C3=
=A5rdet.txt/1.1/"
@@ -222,7 +222,7 @@ test_expect_success \
       git commit -a -m "Update two" &&
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
-      test_must_fail git-cvsexportcommit -c $id
+      test_must_fail git cvsexportcommit -c $id
       )'
=20
 case "$(git config --bool core.filemode)" in
@@ -239,7 +239,7 @@ test_expect_success \
       git add G/off &&
       git commit -a -m "Execute test" &&
       (cd "$CVSWORK" &&
-      git-cvsexportcommit -c HEAD
+      git cvsexportcommit -c HEAD
       test -x G/on &&
       ! test -x G/off
       )'
--=20
1.6.0.1


--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
