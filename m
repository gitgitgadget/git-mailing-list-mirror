From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 16/19] mingw: mark t9100's test cases with appropriate
 prereqs
Date: Tue, 26 Jan 2016 15:35:30 +0100 (CET)
Message-ID: <49a0657c42cba813c4cf0c17169b28031c6d4312.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4ir-00052g-Un
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966151AbcAZOfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:60445 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965226AbcAZOfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:34 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LaGfK-1ZgX1R1riw-00m35s; Tue, 26 Jan 2016 15:35:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KlzMg9ncQZfceMFYRmSMMtJ0ZB+mMx/+bfH2kK8B1CPsGlKc0xZ
 C++nrfGcacemWQylyHgHYauvI4NwgPxZOakTlgRZzqrNxHwCzgYdbcZvI6kgzbRxSYikMVF
 21PgM02ePx6E1pWwQNXHSiKOFDg+Lw7PhY5V4PO2ARuOeGWJqVLLFoN42MYjOzwjjQgeCeu
 ASKF9hR6ULlCVDzOxdeqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZM525YLoD9s=:PWOBVrzwjV+Vg+4YQX3OM5
 r8iSG9SDYoGoSo6bt0/2U/Op/vGradTz7SWTCBG7ugctAU3Gn6K4bjc3lMiTndG4P0aEfy2ld
 fcaeGc35x2CPwgy8ZVtlCUJQkv2SaUzQUa+sTTLpBG8a1vYWk1bBjOe1If8rDhJmYE8wultpa
 /dAuDfGn+VgNKcesCvmBemGGYIfZ4QY3r/X1/JLcKzcaYKrQSb/7d1exRG9NzXR4UQaNwwgJk
 nNY8x0wvPuYyUBRO/YuMwlf3nbtES3HFaI6fQhfGu8UodhLJE4kuOWOsLStepvQHuRiyscJe3
 TRLyhanh+xxEF6mG3k2gKXlc7cZEIuvYrkWt1Y+OeEUY55GG6tzHoJ4BXgBMWUs04xowWrlwx
 fMteh4ykIiMr5AuW1bA1hcPXLyny5c8usM6hF3iDPqDavt96opvZFDJpEHOjO+IWS58JoJfmW
 ZkdYJ0+N9Jh7dxbHy3/phOdNEpV/3l/zuTZzVMxlEH9Ls4JnGzQvG9ToG1GrFIBTYyl6vuMA0
 j+Xw6EkCZ9V5VdLR3BXuUMaiZUCVPENoxtJEscQC7rThzBYZ77I1SF50jhyVVRALXgZnmhLK9
 fGQezaDVm9GOMx7i36YAdAOCyQlQG/sh4h+E+8Vyz0ku6WVRZ+DvLZyINPjIyGkfG1qggAS1h
 q346eREQKX7dvjmejVx0WZGkqjQV2yigA07WT9mBaQOJ+bjMicF6zf9LLeTL5lP7PNbp3WuX/
 DOTrL5qEBtQE73YxZM5j8EKGYwq5dDdL7orwoxBNFw+SS0/ehBMM8zo5mJbRkOqR5TVWNrwY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284828>

Many a test requires either POSIXPERM (to change the executable bit) or
SYMLINKS, and neither are available on Windows.

This lets t9100-git-svn-basic.sh pass in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9100-git-svn-basic.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 258d9b8..5b32a3b 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -30,8 +30,7 @@ test_expect_success \
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
 		echo "zzz" >bar/zzz &&
-		echo "#!/bin/sh" >exec.sh &&
-		chmod +x exec.sh &&
+		printf "" | write_script exec.sh &&
 		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 	) &&
 	rm -rf import &&
@@ -117,7 +116,7 @@ test_expect_success "$name" '
 
 
 name='remove executable bit from a file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM "$name" '
 	rm -f "$GIT_DIR"/index &&
 	git checkout -f -b mybranch5 ${remotes_git_svn} &&
 	chmod -x exec.sh &&
@@ -130,7 +129,7 @@ test_expect_success "$name" '
 
 
 name='add executable bit back file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM "$name" '
 	chmod +x exec.sh &&
 	git update-index exec.sh &&
 	git commit -m "$name" &&
@@ -141,7 +140,7 @@ test_expect_success "$name" '
 
 
 name='executable file becomes a symlink to file'
-test_expect_success "$name" '
+test_expect_success SYMLINKS "$name" '
 	rm exec.sh &&
 	ln -s file exec.sh &&
 	git update-index exec.sh &&
@@ -153,7 +152,7 @@ test_expect_success "$name" '
 
 name='new symlink is added to a file that was also just made executable'
 
-test_expect_success "$name" '
+test_expect_success POSIXPERM,SYMLINKS "$name" '
 	chmod +x file &&
 	ln -s file exec-2.sh &&
 	git update-index --add file exec-2.sh &&
@@ -165,7 +164,7 @@ test_expect_success "$name" '
 	test -h "$SVN_TREE"/exec-2.sh'
 
 name='modify a symlink to become a file'
-test_expect_success "$name" '
+test_expect_success POSIXPERM,SYMLINKS "$name" '
 	echo git help >help &&
 	rm exec-2.sh &&
 	cp help exec-2.sh &&
@@ -181,7 +180,8 @@ test_expect_success "$name" '
 name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
 LC_ALL="$GIT_SVN_LC_ALL"
 export LC_ALL
-test_expect_success UTF8 "$name" "
+# This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
+test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
 	echo '# hello' >> exec-2.sh &&
 	git update-index exec-2.sh &&
 	git commit -m '???????' &&
@@ -214,7 +214,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-test_expect_success "$name" "test_cmp a expected"
+test_expect_success POSIXPERM,SYMLINKS "$name" "test_cmp a expected"
 
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
-- 
2.7.0.windows.1.7.g55a05c8
