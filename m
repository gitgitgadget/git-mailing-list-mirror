From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] t1011 (sparse checkout): style nitpicks
Date: Sat, 31 Jul 2010 13:14:25 +0700
Message-ID: <1280556869-707-2-git-send-email-pclouds@gmail.com>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5Ld-000267-4V
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab0GaGOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:14:53 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34402 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaGOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:14:51 -0400
Received: by pvc7 with SMTP id 7so799856pvc.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oMXJUIdFmCrRXhXB/RQea+pmkNWSi3T8dwDn+gSU2Go=;
        b=GVB5/vWzJAd1r9XSbaZVFv8c4JUfHhETMeMcI3izraiE9ttd/1a71fIAz+SJtkkvb0
         FjB1dHFKYScxN+iFDU0n/hBx3arSxIwG6EQAKBQSwuRbIGuZUikIQoUSLmsr55dEZYXe
         u7aJUd7/GfEHAN4NDJ5MF6j+2vYNHLUOp+Xlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=T3jbFeASrMNVNBwIOeAINBQcRUC4lgwUu8HUw8uIZDlgXSaMlePDaMwQKOeZjYVBDb
         ooV78aS9us5AaILsB7nWJCLfyQk61aEbqh7obGlk3OV4sUsJh/SSAqCmkfybrFflqHju
         NiOIgRNxGEUeWdbWZlpFIFSSZC+M70x9j5+dg=
Received: by 10.115.15.18 with SMTP id s18mr3616760wai.5.1280556890579;
        Fri, 30 Jul 2010 23:14:50 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id 33sm5381313wad.6.2010.07.30.23.14.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:14:49 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:14:41 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152310>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

Tweak the rest of the script to more closely follow the test
style guide.  Guarding setup commands with test_expect_success
makes it easy to see the scope in which some particular data is
used; removal of whitespace after >redirection operators is just
for consistency.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh |  102 ++++++++++++++++++--------=
--------
 1 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 62246db..9189de8 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -1,16 +1,30 @@
 #!/bin/sh
=20
-test_description=3D'sparse checkout tests'
+test_description=3D'sparse checkout tests
+
+* (tag: removed, master) removed
+| D	sub/added
+* (HEAD, tag: top) modified and added
+| M	init.t
+| A	sub/added
+* (tag: init) init
+  A	init.t
+'
=20
 . ./test-lib.sh
=20
-cat >expected <<EOF
-100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
-EOF
 test_expect_success 'setup' '
+	cat >expected <<-\EOF &&
+	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+	EOF
+	cat >expected.swt <<-\EOF &&
+	H init.t
+	H sub/added
+	EOF
+
 	test_commit init &&
-	echo modified >> init.t &&
+	echo modified >>init.t &&
 	mkdir sub &&
 	touch sub/added &&
 	git add init.t sub/added &&
@@ -20,26 +34,22 @@ test_expect_success 'setup' '
 	git commit -m removed &&
 	git tag removed &&
 	git checkout top &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result
 '
=20
-cat >expected.swt <<EOF
-H init.t
-H sub/added
-EOF
 test_expect_success 'read-tree without .git/info/sparse-checkout' '
 	git read-tree -m -u HEAD &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result
 '
=20
 test_expect_success 'read-tree with .git/info/sparse-checkout but disa=
bled' '
-	echo > .git/info/sparse-checkout
+	echo >.git/info/sparse-checkout
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
@@ -47,9 +57,9 @@ test_expect_success 'read-tree with .git/info/sparse-=
checkout but disabled' '
=20
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/in=
fo/sparse-checkout and enabled' '
 	git config core.sparsecheckout true &&
-	echo > .git/info/sparse-checkout &&
+	echo >.git/info/sparse-checkout &&
 	git read-tree --no-sparse-checkout -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
@@ -57,92 +67,90 @@ test_expect_success 'read-tree --no-sparse-checkout=
 with empty .git/info/sparse-
=20
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
-	echo > .git/info/sparse-checkout &&
+	echo >.git/info/sparse-checkout &&
 	test_must_fail git read-tree -m -u HEAD &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-S init.t
-H sub/added
-EOF
 test_expect_success 'match directories with trailing slash' '
+	cat >expected.swt-noinit <<-\EOF &&
+	S init.t
+	H sub/added
+	EOF
+
 	echo sub/ > .git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t > result &&
-	test_cmp expected.swt result &&
+	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-H init.t
-H sub/added
-EOF
 test_expect_failure 'match directories without trailing slash' '
-	echo init.t > .git/info/sparse-checkout &&
-	echo sub >> .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
+	echo sub >>.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test ! -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-H init.t
-S sub/added
-EOF
 test_expect_success 'checkout area changes' '
-	echo init.t > .git/info/sparse-checkout &&
+	cat >expected.swt-nosub <<-\EOF &&
+	H init.t
+	S sub/added
+	EOF
+
+	echo init.t >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
-	test_cmp expected.swt result &&
+	git ls-files -t >result &&
+	test_cmp expected.swt-nosub result &&
 	test -f init.t &&
 	test ! -f sub/added
 '
=20
 test_expect_success 'read-tree updates worktree, absent case' '
-	echo sub/added > .git/info/sparse-checkout &&
+	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	git read-tree -m -u HEAD^ &&
 	test ! -f init.t
 '
=20
 test_expect_success 'read-tree updates worktree, dirty case' '
-	echo sub/added > .git/info/sparse-checkout &&
+	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	echo dirty > init.t &&
+	echo dirty >init.t &&
 	git read-tree -m -u HEAD^ &&
 	grep -q dirty init.t &&
 	rm init.t
 '
=20
 test_expect_success 'read-tree removes worktree, dirty case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	echo dirty > added &&
+	echo dirty >added &&
 	git read-tree -m -u HEAD^ &&
 	grep -q dirty added
 '
=20
 test_expect_success 'read-tree adds to worktree, absent case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	git read-tree -u -m HEAD^ &&
 	test ! -f sub/added
 '
=20
 test_expect_success 'read-tree adds to worktree, dirty case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
-	echo dirty > sub/added &&
+	echo dirty >sub/added &&
 	git read-tree -u -m HEAD^ &&
 	grep -q dirty sub/added
 '
--=20
1.7.1.rc1.69.g24c2f7
