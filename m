From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] Makefile: remove some unnecessary curly braces
Date: Fri,  2 Jul 2010 11:50:28 -0700
Message-ID: <8YdP-GcDDflOVZnykNVIGZV2ru1dwSkd6psWipKx3nNQK-C4OmEK2ZwFAj1tSIK1LUawtXDhUrxEeO95yG3lXQ@cipher.nrlssc.navy.mil>
References: <80typu1ozt.fsf@tiny.isode.net>
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, PWalker752@aol.com,
	newsletter@dirk.my1.cc, bruce.stephens@isode.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 02 20:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlGv-0008AS-7G
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759815Ab0GBSrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 14:47:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48374 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759798Ab0GBSrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 14:47:13 -0400
Received: by mail.nrlssc.navy.mil id o62IkVgn010094; Fri, 2 Jul 2010 13:46:31 -0500
In-Reply-To: <80typu1ozt.fsf@tiny.isode.net>
X-OriginalArrivalTime: 02 Jul 2010 18:46:31.0011 (UTC) FILETIME=[E2FE4B30:01CB1A16]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150145>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 9aca8a1..527d872 100644
--- a/Makefile
+++ b/Makefile
@@ -2079,19 +2079,19 @@ endif
 		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
 		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
 		cp "$$bindir/git$X" "$$execdir/git$X"; } ; } && \
-	{ for p in $(BUILT_INS); do \
+	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
-	  done; } && \
+	done && \
 	{ test x"$(REMOTE_CURL_ALIASES)" = x || \
-		{ for p in $(REMOTE_CURL_ALIASES); do \
+		for p in $(REMOTE_CURL_ALIASES); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-	  done; } ; } && \
+	done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
-- 
1.7.2.rc1
