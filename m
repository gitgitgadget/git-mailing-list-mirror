From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] test-suite: Make test script numbers unique
Date: Fri, 13 Mar 2009 13:23:26 +0100
Message-ID: <1236947006-16827-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 13:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6Sl-0004Y1-Mg
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbZCMMYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 08:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755071AbZCMMYX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:24:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4646 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbZCMMYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 08:24:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Li6Qr-0006FD-8V; Fri, 13 Mar 2009 13:24:13 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 35C6E6EF; Fri, 13 Mar 2009 13:24:09 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id EC0CCFA46; Fri, 13 Mar 2009 13:24:08 +0100 (CET)
X-Mailer: git-send-email 1.6.2.127.g9cd69
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113175>

In order to selectively skip tests, the environment variable GIT_SKIP_TESTS
can be set like this:

  $ GIT_SKIP_TESTS='t1301 t4150.18' make test

That is, its value can contain only the test script numbers, but not the
full script name. Therefore, it is important that the test scripts are
uniquely numbered. This makes it so.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This applies to master.  Today's next and pu do not have any new
 duplicated numbers.

 -- Hannes

 t/{t3409-rebase-hook.sh => t3413-rebase-hook.sh}   |    0
 t/{t4017-quiet.sh => t4035-diff-quiet.sh}          |    0
 ...r-mime.sh => t4036-format-patch-signer-mime.sh} |    0
 t/{t4203-patch-id.sh => t4204-patch-id.sh}         |    0
 t/{t5521-pull-symlink.sh => t5522-pull-symlink.sh} |    0
 ...me-nocruft.sh => t6034-merge-rename-nocruft.sh} |    0
 t/{t7502-status.sh => t7508-status.sh}             |    0
 ...n-multi-glob.sh => t9109-git-svn-multi-glob.sh} |    0
 ....sh => t9137-git-svn-dcommit-clobber-series.sh} |    0
 9 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t3409-rebase-hook.sh => t3413-rebase-hook.sh} (100%)
 rename t/{t4017-quiet.sh => t4035-diff-quiet.sh} (100%)
 rename t/{t4021-format-patch-signer-mime.sh => t4036-format-patch-signer-mime.sh} (100%)
 rename t/{t4203-patch-id.sh => t4204-patch-id.sh} (100%)
 rename t/{t5521-pull-symlink.sh => t5522-pull-symlink.sh} (100%)
 rename t/{t6023-merge-rename-nocruft.sh => t6034-merge-rename-nocruft.sh} (100%)
 rename t/{t7502-status.sh => t7508-status.sh} (100%)
 rename t/{t9108-git-svn-multi-glob.sh => t9109-git-svn-multi-glob.sh} (100%)
 rename t/{t9106-git-svn-dcommit-clobber-series.sh => t9137-git-svn-dcommit-clobber-series.sh} (100%)

diff --git a/t/t3409-rebase-hook.sh b/t/t3413-rebase-hook.sh
similarity index 100%
rename from t/t3409-rebase-hook.sh
rename to t/t3413-rebase-hook.sh
diff --git a/t/t4017-quiet.sh b/t/t4035-diff-quiet.sh
similarity index 100%
rename from t/t4017-quiet.sh
rename to t/t4035-diff-quiet.sh
diff --git a/t/t4021-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
similarity index 100%
rename from t/t4021-format-patch-signer-mime.sh
rename to t/t4036-format-patch-signer-mime.sh
diff --git a/t/t4203-patch-id.sh b/t/t4204-patch-id.sh
similarity index 100%
rename from t/t4203-patch-id.sh
rename to t/t4204-patch-id.sh
diff --git a/t/t5521-pull-symlink.sh b/t/t5522-pull-symlink.sh
similarity index 100%
rename from t/t5521-pull-symlink.sh
rename to t/t5522-pull-symlink.sh
diff --git a/t/t6023-merge-rename-nocruft.sh b/t/t6034-merge-rename-nocruft.sh
similarity index 100%
rename from t/t6023-merge-rename-nocruft.sh
rename to t/t6034-merge-rename-nocruft.sh
diff --git a/t/t7502-status.sh b/t/t7508-status.sh
similarity index 100%
rename from t/t7502-status.sh
rename to t/t7508-status.sh
diff --git a/t/t9108-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
similarity index 100%
rename from t/t9108-git-svn-multi-glob.sh
rename to t/t9109-git-svn-multi-glob.sh
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
similarity index 100%
rename from t/t9106-git-svn-dcommit-clobber-series.sh
rename to t/t9137-git-svn-dcommit-clobber-series.sh
-- 
1.6.2.127.g9cd69
