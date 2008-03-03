From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon,  3 Mar 2008 18:52:49 +0100
Message-ID: <1204566769-6585-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 03 19:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFWL-0000f4-CC
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbYCCSfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYCCSfe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:35:34 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:62137 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758789AbYCCSfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:35:33 -0500
X-Greylist: delayed 1804 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2008 13:35:33 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m23HqnQT006899;
	Mon, 3 Mar 2008 18:52:49 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWEqH-0002KO-CH; Mon, 03 Mar 2008 18:52:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWEqH-0001im-8T; Mon, 03 Mar 2008 18:52:49 +0100
X-Mailer: git-send-email 1.5.4.21.g82c44
In-Reply-To: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 03 Mar 2008 18:52:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75966>

A merge is not necessarily with a remote branch, it can be with any
commit object.

Thanks to Paolo Ciarrocchi for pointing out the problem, and to
Nicolas Pitre for pointing out the fact that a merge is not
necessarily with a branch head.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-merge.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0c9ad7f..193c9c0 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -68,7 +68,8 @@ HOW MERGE WORKS
 ---------------
 
 A merge is always between the current `HEAD` and one or more
-remote branch heads, and the index file must exactly match the
+commit objects (usually, branch head or tag), and the index file must
+exactly match the
 tree of `HEAD` commit (i.e. the contents of the last commit) when
 it happens.  In other words, `git-diff --cached HEAD` must
 report no changes.
-- 
1.5.4.21.g82c44

