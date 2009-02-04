From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] Missing && in t/t7001.sh.
Date: Wed,  4 Feb 2009 10:32:06 +0100
Message-ID: <1233739928-19895-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 04 10:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUeCW-0001sn-2T
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbZBDJgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZBDJgP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:36:15 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:37585 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbZBDJgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:36:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n149WHoD025086;
	Wed, 4 Feb 2009 10:32:17 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUe76-0006SX-WB; Wed, 04 Feb 2009 10:32:09 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUe76-0005BU-Tp; Wed, 04 Feb 2009 10:32:08 +0100
X-Mailer: git-send-email 1.6.1.2.321.g68da9
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 04 Feb 2009 10:32:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108326>

Without this, the exit status is only the one of the last line.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7001-mv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index ef2e78f..e4dfe95 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -55,7 +55,7 @@ test_expect_success \
      git mv -k untracked1 untracked2 path0 &&
      test -f untracked1 &&
      test -f untracked2 &&
-     test ! -f path0/untracked1
+     test ! -f path0/untracked1 &&
      test ! -f path0/untracked2'
 
 # clean up the mess in case bad things happen
-- 
1.6.1.2.321.g68da9
