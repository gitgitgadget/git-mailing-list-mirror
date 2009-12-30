From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] SubmittingPatches: hints to know the status of a submitted patch.
Date: Wed, 30 Dec 2009 15:51:22 +0100
Message-ID: <1262184682-9440-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 30 15:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPzwG-0000TE-NN
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 15:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZL3OyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 09:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZL3OyM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 09:54:12 -0500
Received: from imag.imag.fr ([129.88.30.1]:53551 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbZL3OyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 09:54:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nBUEpPGf006352
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 30 Dec 2009 15:51:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NPztV-0005q4-Hb; Wed, 30 Dec 2009 15:51:25 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NPztV-0002Sv-Gb; Wed, 30 Dec 2009 15:51:25 +0100
X-Mailer: git-send-email 1.6.6.71.gcc720.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 30 Dec 2009 15:51:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135903>

"What happened to my patch" is pretty much a FAQ on the Git mailing list,
it deserves a few paragraphs in SubmittingPatches...

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

(I had already sent this patch as a draft RFC, admitedly rather well
hidden within another thread. Let's retry a bit more explicitly ;-) )

 Documentation/SubmittingPatches |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 76fc84d..c686f86 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -280,6 +280,20 @@ people play with it without having to pick up and apply the patch to
 their trees themselves.
 
 ------------------------------------------------
+Know the status of your patch after submission
+
+* You can use Git itself to find out when your patch is merged in
+  master. 'git pull --rebase' will automatically skip already-applied
+  patches, and will let you know. This works only if you rebase on top
+  of the branch in which your patch has been merged (i.e. it will not
+  tell you if your patch is merged in pu if you rebase on top of
+  master).
+
+* Read the git mailing list, the maintainer regularly posts messages
+  entitled "What's cooking in git.git" and "What's in git.git" giving
+  the status of various proposed changes.
+
+------------------------------------------------
 MUA specific hints
 
 Some of patches I receive or pick up from the list share common
-- 
1.6.6.71.gcc720.dirty
