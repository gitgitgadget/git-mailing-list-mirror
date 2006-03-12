From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] annotate-tests: override VISUAL when running tests.
Date: Sun, 12 Mar 2006 14:00:30 +0000
Message-ID: <20060312140030.25272.9782.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 12 15:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIR7b-0005uN-62
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 15:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWCLOAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 09:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCLOAc
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 09:00:32 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:31175 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751278AbWCLOAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 09:00:32 -0500
Received: (qmail 25291 invoked from network); 12 Mar 2006 14:00:31 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 12 Mar 2006 14:00:31 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17513>

From: Mark Wooding <mdw@distorted.org.uk>

The tests hang for me waiting for Emacs with its output directed
somewhere strage, because I hedged my bets and set both EDITOR and
VISUAL to run Emacs.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 t/annotate-tests.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 9c5a15a..114938c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -94,7 +94,7 @@ test_expect_success \
 test_expect_success \
     'merge-setup part 4' \
     'echo "evil merge." >>file &&
-     EDITOR=: git commit -a --amend'
+     EDITOR=: VISUAL=: git commit -a --amend'
 
 test_expect_success \
     'Two lines blamed on A, one on B, two on B1, one on B2, one on A U Thor' \
