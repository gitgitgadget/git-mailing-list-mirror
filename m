From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-commit.txt: Reword the description of git commit.
Date: Thu, 16 Apr 2009 18:59:34 +0200
Message-ID: <1239901174-30072-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 19:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuV1z-0004XO-Ae
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 19:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023AbZDPREJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 13:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbZDPREI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 13:04:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:40700 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757776AbZDPREG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 13:04:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3GH0Fx8001105
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 19:00:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuUwT-00059B-Hv; Thu, 16 Apr 2009 19:00:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuUwT-0007px-FY; Thu, 16 Apr 2009 19:00:01 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 19:00:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116713>

"Record changes" insists on recording the _delta_ between the parent
commit and the new revision, which can be mis-leading, since Git is
really snapshot-oriented. The new wording may be less misleading.
---
I'm actually resurecting a new thread :

http://thread.gmane.org/gmane.comp.version-control.git/68647/focus=68823

where a user was not understanding why custom diff drivers were not
used by "commit" to tell whether the tree had changed ("I keep doing
git diff's and it says there is no difference, but then git commit
keeps telling me there is").

 Documentation/git-commit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b5d81be..c7f728f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -3,7 +3,7 @@ git-commit(1)
 
 NAME
 ----
-git-commit - Record changes to the repository
+git-commit - Record a new revision in the repository
 
 SYNOPSIS
 --------
-- 
1.6.2.2.449.g92961.dirty
