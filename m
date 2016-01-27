From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 16/20] mingw: mark t9100's test cases with appropriate
 prereqs
Date: Wed, 27 Jan 2016 17:20:08 +0100 (CET)
Message-ID: <4c963d60edda50c110ba01150d745a2b8ebc66e0.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1704809497-1453911609=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpW-0002o1-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934035AbcA0QUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:55137 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933980AbcA0QUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:18 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LhOO8-1ZkiDJ1kjQ-00maF0; Wed, 27 Jan 2016 17:20:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:8AfXXITWLBb2mOGAXL889UXs8uaBuh744MLHD+HRnA6kSwRtHPz
 g4OGiSzPdJ79FW4dwWEzRQMdqjZGZGuKPIFDFH4Ihr3sWGJSyiQ8SqBAOpFmPDeRfcaeKx0
 ka1tpyd1hpguM6g6vQxWxaezBn9Dp+DIVt9kCdDxI7W1eenC7DMVhRlRLn26wEOTz3qsJmp
 DIpnV9R8krgRH+pWumjwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NHInq5ceVVM=:M6ifWW2ajot+2lEhl4y0gR
 OXfmfiotHSjNnnFMdYh/5QnCffEoucYp0V82Hh5M0N/vuj4X1SS+K868/6Sc5v9NnEaZsp11G
 Rxh6DgAZSZwItCgBHr15hyBpfaCQhNrPVXDj8/ierzPWG7yFmj2KRzKaT4FX0xJuFseWgcrBu
 PYM7yTD4IAyx9U7guiTB8oJYn6nmubJeZfYKVRxyA86+uueskOLMtl+DISyMcp5ntzdZKhjPP
 9DXy8UkPdLt54+CPYgJ4Hl8Obz0HWENvqq5ZBhHd0vWttmPy7i/hIOkdA1giSDZkowCwjl7nV
 gTVMm0pkVCWVFBx0aNvDlf0hVEvULSskGplRualhYyu+0m9jDNGZ1bEYTwM9bEdAh5vXj2neW
 fqQXYaoVj1T/N+RhQQ93UbuS2r24oqhD8x1+ZYtWodNVngoRBkZp8xFWDHhLVjbu/vq26qxeJ
 SJzPx5IB3ylKKbcpuOGYKyZ16DrL1Ste3CXEWLrSR6A0I47b38yxCrhjAidEcIs54RFMhDTA5
 +OwJevAt0RX8xzNHbcUCDUcKXI/XdQsrG+RvhhxSYxiJWnR5fqqbAA2hWcYP9D3DWNBpQVFlg
 GBgY7eByM4NUnEzh/17a5IHkpy0Y0fc4cHos4Sa2Ha2Op95p499uIviZZY+su9EaQrUEWPkXe
 JDUUqAIc4UmCogyyYdETo8LrrBJci73rbRLrGO/3sNhFjuDcTUl72yvno0sMSn+gvqom6HwYe
 DORaWij3hrs/kmm12UJ9tt46mPcqPr4R5ihxFO1OuT8MdJtJRfv7A4sTR3q0Osa/PiUaJyMZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284933>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1704809497-1453911609=:2964
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Many a test requires either POSIXPERM (to change the executable bit) or
SYMLINKS, and neither are available on Windows.

This lets t9100-git-svn-basic.sh pass in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9100-git-svn-basic.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 258d9b8..56acc1e 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -30,8 +30,7 @@ test_expect_success \
 =09=09echo "deep dir" >dir/a/b/c/d/e/file &&
 =09=09mkdir bar &&
 =09=09echo "zzz" >bar/zzz &&
-=09=09echo "#!/bin/sh" >exec.sh &&
-=09=09chmod +x exec.sh &&
+=09=09write_script exec.sh </dev/null &&
 =09=09svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 =09) &&
 =09rm -rf import &&
@@ -117,7 +116,7 @@ test_expect_success "$name" '
=20
=20
 name=3D'remove executable bit from a file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM "$name" '
 =09rm -f "$GIT_DIR"/index &&
 =09git checkout -f -b mybranch5 ${remotes_git_svn} &&
 =09chmod -x exec.sh &&
@@ -130,7 +129,7 @@ test_expect_success "$name" '
=20
=20
 name=3D'add executable bit back file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM "$name" '
 =09chmod +x exec.sh &&
 =09git update-index exec.sh &&
 =09git commit -m "$name" &&
@@ -141,7 +140,7 @@ test_expect_success "$name" '
=20
=20
 name=3D'executable file becomes a symlink to file'
-test_expect_success "$name" '
+test_expect_success SYMLINKS "$name" '
 =09rm exec.sh &&
 =09ln -s file exec.sh &&
 =09git update-index exec.sh &&
@@ -153,7 +152,7 @@ test_expect_success "$name" '
=20
 name=3D'new symlink is added to a file that was also just made executable'
=20
-test_expect_success "$name" '
+test_expect_success POSIXPERM,SYMLINKS "$name" '
 =09chmod +x file &&
 =09ln -s file exec-2.sh &&
 =09git update-index --add file exec-2.sh &&
@@ -165,7 +164,7 @@ test_expect_success "$name" '
 =09test -h "$SVN_TREE"/exec-2.sh'
=20
 name=3D'modify a symlink to become a file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM,SYMLINKS "$name" '
 =09echo git help >help &&
 =09rm exec-2.sh &&
 =09cp help exec-2.sh &&
@@ -181,7 +180,8 @@ test_expect_success "$name" '
 name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
 LC_ALL=3D"$GIT_SVN_LC_ALL"
 export LC_ALL
-test_expect_success UTF8 "$name" "
+# This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
+test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
 =09echo '# hello' >> exec-2.sh &&
 =09git update-index exec-2.sh &&
 =09git commit -m '=C3=A9=C3=AF=E2=88=8F' &&
@@ -214,7 +214,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
=20
-test_expect_success "$name" "test_cmp a expected"
+test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
=20
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
--=20
2.7.0.windows.1.7.g55a05c8


--8323329-1704809497-1453911609=:2964--
