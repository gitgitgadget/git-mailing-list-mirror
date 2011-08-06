From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 29/40] whitespace: remediate t9107-git-svn-migrate.sh
Date: Sat,  6 Aug 2011 18:44:43 +1000
Message-ID: <1312620294-18616-29-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWW-0005FS-JP
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab1HFIqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:19 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1HFIqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:13 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w+yzGiVHIAaS6zKJg2lqrpjtwDP/OFQ2uXLFTg7QG68=;
        b=fJVcXch8+kjV8PUTDt25MJMqnXhub8qUI3bwL5eBmnrutDM0C//i8b7br2zxUI3grr
         Gseuey/6E88e7fjguyr6maSQ874MP+GHvb7kOsiN8AlVkXmhazHIq2EZiQc1wkXtkGyN
         gMtz9aXZWAIFieirt6Gud2fXrCh5TzEZ9JhQU=
Received: by 10.42.155.200 with SMTP id v8mr3067274icw.130.1312620372961;
        Sat, 06 Aug 2011 01:46:12 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178855>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9107-git-svn-migrate.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 289fc31..789d2b9 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -37,7 +37,7 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 	git rev-parse --verify refs/remotes/svn^0 &&
 	test "$(git config --get svn-remote.svn.url)" = "$svnrepo" &&
 	test `git config --get svn-remote.svn.fetch` = \
-             ":refs/${remotes_git_svn}"
+	     ":refs/${remotes_git_svn}"
 	'
 
 test_expect_success 'initialize a multi-repository repo' '
@@ -45,18 +45,18 @@ test_expect_success 'initialize a multi-repository repo' '
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/trunk$" fetch.out &&
 	test -n "`git config --get svn-remote.svn.branches \
-	            "^branches/\*:refs/remotes/\*$"`" &&
+		    "^branches/\*:refs/remotes/\*$"`" &&
 	test -n "`git config --get svn-remote.svn.tags \
-	            "^tags/\*:refs/remotes/tags/\*$"`" &&
+		    "^tags/\*:refs/remotes/tags/\*$"`" &&
 	git config --unset svn-remote.svn.branches \
-	                        "^branches/\*:refs/remotes/\*$" &&
+				"^branches/\*:refs/remotes/\*$" &&
 	git config --unset svn-remote.svn.tags \
-	                        "^tags/\*:refs/remotes/tags/\*$" &&
+				"^tags/\*:refs/remotes/tags/\*$" &&
 	git config --add svn-remote.svn.fetch "branches/a:refs/remotes/a" &&
 	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/b" &&
 	for i in tags/0.1 tags/0.2 tags/0.3; do
 		git config --add svn-remote.svn.fetch \
-		                 $i:refs/remotes/$i || exit 1; done &&
+				 $i:refs/remotes/$i || exit 1; done &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/trunk$" fetch.out &&
 	grep "^branches/a:refs/remotes/a$" fetch.out &&
@@ -78,7 +78,7 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 	  for j in trunk a b tags/0.1 tags/0.2 tags/0.3; do
 		if test \$j != \$i; then continue; fi
 	    test -z \"\`git diff refs/remotes/\$i \
-	                         refs/remotes/\$j\`\" ||exit 1; done; done
+				 refs/remotes/\$j\`\" ||exit 1; done; done
 	"
 
 test_expect_success 'migrate --minimize on old inited layout' '
-- 
1.7.6.362.gf0e6
