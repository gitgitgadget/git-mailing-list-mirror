From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 07/40] whitespace: remediate t3200-branch.sh
Date: Sat,  6 Aug 2011 18:44:21 +1000
Message-ID: <1312620294-18616-7-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXQ-0005kJ-Nd
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab1HFIrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:47:15 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab1HFIpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:21 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yYaN76top7oKhJrvgcBn1FzuXAQZww/vjwMqlkPS7PY=;
        b=wlAqFz90yfiiP4BG7NqH40jAnZG9Hy4GIiUhWXXm2g272z9g7d6+W+SWI+enBIbAYZ
         wFBVOl0Xr3L2EWz+Ho4NduJ8jW4LJ+JqM90SDZZ17fhORIE9Zcx/q0cHQzbt7Zut+QS6
         zzp8PD+qQiBuP8yFDVOXAWTkAPaRiu/9B8fuw=
Received: by 10.231.35.13 with SMTP id n13mr926385ibd.57.1312620320720;
        Sat, 06 Aug 2011 01:45:20 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178870>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3200-branch.sh |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e69c8c..67d683d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -65,30 +65,30 @@ test_expect_success \
 test_expect_success \
     'git branch j/k should work after branch j has been deleted' \
        'git branch j &&
-        git branch -d j &&
-        git branch j/k'
+	git branch -d j &&
+	git branch j/k'
 
 test_expect_success \
     'git branch l should work after branch l/m has been deleted' \
        'git branch l/m &&
-        git branch -d l/m &&
-        git branch l'
+	git branch -d l/m &&
+	git branch l'
 
 test_expect_success \
     'git branch -m m m/m should work' \
        'git branch -l m &&
-        git branch -m m m/m &&
-        test -f .git/logs/refs/heads/m/m'
+	git branch -m m m/m &&
+	test -f .git/logs/refs/heads/m/m'
 
 test_expect_success \
     'git branch -m n/n n should work' \
        'git branch -l n/n &&
-        git branch -m n/n n
-        test -f .git/logs/refs/heads/n'
+	git branch -m n/n n
+	test -f .git/logs/refs/heads/n'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
-        git branch o/p &&
+	git branch o/p &&
 	test_must_fail git branch -m o/o o
 '
 
@@ -112,12 +112,12 @@ git config branch.s/s.dummy Hello
 test_expect_success \
     'git branch -m s/s s should work when s/t is deleted' \
        'git branch -l s/s &&
-        test -f .git/logs/refs/heads/s/s &&
-        git branch -l s/t &&
-        test -f .git/logs/refs/heads/s/t &&
-        git branch -d s/t &&
-        git branch -m s/s s &&
-        test -f .git/logs/refs/heads/s'
+	test -f .git/logs/refs/heads/s/s &&
+	git branch -l s/t &&
+	test -f .git/logs/refs/heads/s/t &&
+	git branch -d s/t &&
+	git branch -m s/s s &&
+	test -f .git/logs/refs/heads/s'
 
 test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
-- 
1.7.6.362.gf0e6
