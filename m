From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH v2] Documentation: Fix misspellings
Date: Fri, 22 Jun 2012 16:03:01 -0400
Message-ID: <1340395381-19952-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 22:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiA4W-0004xM-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab2FVUDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 16:03:06 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33636 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab2FVUDF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 16:03:05 -0400
X-Greylist: delayed 6047 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2012 16:03:05 EDT
Received: by qcmv28 with SMTP id v28so1317102qcm.11
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=137CzeDcvb3pvmSD5y7fFE1Q9tZ91ineBGJ7svpK3/U=;
        b=fcHv3pVvZXKfpJ6Re7GPtCQ5Kjh0s/IxGFzdsf9iuj/+o9xgxKUUFC/CIiYowTcXwk
         LoMcgAIWCsLoinricMcAai1xNaCD4RiTIkN7re8iw2JKWh40T9OPwQvVOFPqJF3ECpw6
         GRYlEqrGO+YubjT+HDFIsCvHmy9tIHxB7r9cxPe8pKv8MX8JU1eLxpVJvkUfjmzJ3qqJ
         cxoTZj6W+edUXo+Y1lD8/flDdIeK1sMh5NoSKlHVpgqFFin6ZM13vbBKCjKIqNrLdmtD
         C9CoeOj7tDM4CV/jeANYidnwtMr6Y04gCkEjGNyHTwXsQGVfhoGNxQQuRPVEHkstIdXj
         NI6g==
Received: by 10.224.177.201 with SMTP id bj9mr8872030qab.9.1340395383515;
        Fri, 22 Jun 2012 13:03:03 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id ei10sm124511qab.20.2012.06.22.13.03.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 13:03:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200463>


Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
 Documentation/diff-options.txt  |    2 +-
 Documentation/git-submodule.txt |    2 +-
 compat/nedmalloc/Readme.txt     |    2 +-
 t/t4253-am-keep-cr-dos.sh       |    4 ++--
 t/t9300-fast-import.sh          |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cfedd8..cf4b216 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -59,7 +59,7 @@ endif::git-format-patch[]
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
 	part. Maximum width defaults to terminal width, or 80 columns
-	if not connected to a terminal, and can be overriden by
+	if not connected to a terminal, and can be overridden by
 	`<width>`. The width of the filename part can be limited by
 	giving another width `<name-width>` after a comma. The width
 	of the graph part can be limited by using
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9e488c0..fbbbcb2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -140,7 +140,7 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overriden by specifying
+	`rebase`, `merge` or `none`. `none` can be overridden by specifying
 	`--checkout`.
 +
 If the submodule is not yet initialized, and you just want to use the
diff --git a/compat/nedmalloc/Readme.txt b/compat/nedmalloc/Readme.txt
index 8763656..e46d8f1 100644
--- a/compat/nedmalloc/Readme.txt
+++ b/compat/nedmalloc/Readme.txt
@@ -100,7 +100,7 @@ v1.04alpha_svn915 7th October 2006:
 Thanks to Dmitry Chichkov for reporting this. Futher thanks to Aleksey Sanin.
  * Fixed realloc(0, <size>) segfaulting. Thanks to Dmitry Chichkov for
 reporting this.
- * Made config defines #ifndef so they can be overriden by the build system.
+ * Made config defines #ifndef so they can be overridden by the build system.
 Thanks to Aleksey Sanin for suggesting this.
  * Fixed deadlock in nedprealloc() due to unnecessary locking of preferred
 thread mspace when mspace_realloc() always uses the original block's mspace
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 735e55d..553fe3e 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -62,7 +62,7 @@ test_expect_success 'am with dos files config am.keepcr' '
 	git diff --exit-code master
 '
 
-test_expect_success 'am with dos files config am.keepcr overriden by --no-keep-cr' '
+test_expect_success 'am with dos files config am.keepcr overridden by --no-keep-cr' '
 	git config am.keepcr 1 &&
 	git checkout -b dosfiles-conf-keepcr-override initial &&
 	git format-patch -k initial..master &&
@@ -83,7 +83,7 @@ test_expect_success 'am with dos files with --keep-cr continue' '
 	git diff --exit-code master
 '
 
-test_expect_success 'am with unix files config am.keepcr overriden by --no-keep-cr' '
+test_expect_success 'am with unix files config am.keepcr overridden by --no-keep-cr' '
 	git config am.keepcr 1 &&
 	git checkout -b unixfiles-conf-keepcr-override initial &&
 	cp -f file1 file &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2aa1824..c17f52e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2117,7 +2117,7 @@ test_expect_success \
     grep :1 git.marks'
 
 test_expect_success \
-    'R: export-marks options can be overriden by commandline options' \
+    'R: export-marks options can be overridden by commandline options' \
     'cat input | git fast-import --export-marks=other.marks &&
     grep :1 other.marks'
 
-- 
1.7.7.5 (Apple Git-26)
