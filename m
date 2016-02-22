From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] tests: remove unused full-svn-test target
Date: Mon, 22 Feb 2016 03:08:14 +0000
Message-ID: <20160222030814.GA18817@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 04:08:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgrD-000167-VB
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 04:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbcBVDIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 22:08:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:39578 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbcBVDIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 22:08:15 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BD0633817;
	Mon, 22 Feb 2016 03:08:14 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286875>

git-svn has not supported GIT_SVN_NO_OPTIMIZE_COMMITS for
the "set-tree" sub-command in 9 years since commit 490f49ea5899
("git-svn: remove optimized commit stuff for set-tree").

So remove this target to avoid confusion.

ref: http://mid.gmane.org/56C9B7B7.7030406@f2.dion.ne.jp

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 43b15e3..ad97a7e 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -77,11 +77,6 @@ aggregate-results:
 		echo "$$f"; \
 	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
-# we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
-full-svn-test:
-	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
-	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
-
 gitweb-test:
 	$(MAKE) $(TGITWEB)
 
-- 
EW
