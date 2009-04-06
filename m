From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-checkout.txt: clarify that <branch> applies when no path is given.
Date: Mon,  6 Apr 2009 22:45:22 +0200
Message-ID: <1239050722-1227-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1239050722-1227-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 22:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqvln-0007Lm-KN
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZDFUsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZDFUsl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 16:48:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:36100 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbZDFUsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 16:48:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n36Kk6DS017158
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Apr 2009 22:46:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lqvhm-0001sv-Qs; Mon, 06 Apr 2009 22:46:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lqvhm-0000KT-OZ; Mon, 06 Apr 2009 22:46:06 +0200
X-Mailer: git-send-email 1.6.2.1.427.g061ea
In-Reply-To: <1239050722-1227-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Apr 2009 22:46:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115878>

Otherwise, the sentence "Defaults to HEAD." can be mis-read to mean
that "git checkout -- hello.c" checks-out from HEAD.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

This may be a bit too verbose, but I've been biten by this (reading
the doc not carrefully enough, I really thought git checkout would
take HEAD, then I thought it was actually a documentation bug, and
then I realized I miss-read). This patch would have saved me time. But
if other disagree, I won't fight ;-).

 Documentation/git-checkout.txt |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 0b5485b..58bf508 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -126,9 +126,14 @@ the conflicted merge in the specified paths.
 <new_branch>::
 	Name for the new branch.
 
+<tree-ish>::
+	Tree to checkout from (when path are given). If not specified,
+	the index will be used.
+
 <branch>::
-	Branch to checkout; may be any object ID that resolves to a
-	commit.  Defaults to HEAD.
+	Branch to checkout (when no path are given); may be any object
+	ID that resolves to a commit.  Defaults to HEAD.
+
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
-- 
1.6.2.1.427.g061ea
