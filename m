From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 17/40] whitespace: remediate t5403-post-checkout-hook.sh
Date: Sat,  6 Aug 2011 18:44:31 +1000
Message-ID: <1312620294-18616-17-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVy-000510-TT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab1HFIpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1HFIpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:45 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mbDh9jufICh4uXFDnqipuFfWgzgYxZe0isHqG383rGc=;
        b=YrQB9RhNDTAEmI4vrSCGi7j7cOZEiHZw/Jh/djGdV23oKbGnaJgkpHibOp5MADnyZ9
         TbeZ+FEX4pZobLqWsDGw7NXSsET+gTe9YQOOq4Low1ZfvlQH0vx4YARW7Xrhggf6+Hco
         2DHfFB3zuz9EvYSNVs75OURFVejS7b3RLyBLc=
Received: by 10.231.24.7 with SMTP id t7mr938722ibb.31.1312620345068;
        Sat, 06 Aug 2011 01:45:45 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178843>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5403-post-checkout-hook.sh |   46 ++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index d05a913..1753ef2 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -31,44 +31,44 @@ EOF
 done
 
 test_expect_success 'post-checkout runs as expected ' '
-        GIT_DIR=clone1/.git git checkout master &&
-        test -e clone1/.git/post-checkout.args
+	GIT_DIR=clone1/.git git checkout master &&
+	test -e clone1/.git/post-checkout.args
 '
 
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
-        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-        flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag = 1
+	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
-        GIT_DIR=clone1/.git git checkout master &&
-        test -e clone1/.git/post-checkout.args
+	GIT_DIR=clone1/.git git checkout master &&
+	test -e clone1/.git/post-checkout.args
 '
 
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
-        GIT_DIR=clone1/.git git checkout -b new1 &&
-        old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-        new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-        flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag = 1
+	GIT_DIR=clone1/.git git checkout -b new1 &&
+	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
+	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
+	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
-        GIT_DIR=clone2/.git git checkout new2 &&
-        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-        flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old != $new -a $flag = 1
+	GIT_DIR=clone2/.git git checkout new2 &&
+	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test $old != $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-        GIT_DIR=clone2/.git git checkout master b &&
-        old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-        new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-        flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old = $new -a $flag = 0
+	GIT_DIR=clone2/.git git checkout master b &&
+	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
+	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
+	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	test $old = $new -a $flag = 0
 '
 
 if test "$(git config --bool core.filemode)" = true; then
-- 
1.7.6.362.gf0e6
