From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-checkout.txt: fix incorrect statement about HEAD and index
Date: Mon,  6 Apr 2009 22:45:21 +0200
Message-ID: <1239050722-1227-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 22:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqvoC-00083n-Kb
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbZDFUvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 16:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbZDFUvN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 16:51:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:36561 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbZDFUvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 16:51:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n36Kjfoo017087
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Apr 2009 22:45:41 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LqvhL-0001ss-Sx; Mon, 06 Apr 2009 22:45:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LqvhL-0000KO-Pt; Mon, 06 Apr 2009 22:45:39 +0200
X-Mailer: git-send-email 1.6.2.1.427.g061ea
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Apr 2009 22:45:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115879>

The command "git checkout" checks out from the index by default, not
HEAD (the introducing comment were correct, but the detailled
explanation added below were not).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1a6c19e..0b5485b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -191,7 +191,7 @@ $ git checkout hello.c            <3>
 +
 <1> switch branch
 <2> take a file out of another commit
-<3> restore hello.c from HEAD of current branch
+<3> restore hello.c from the index
 +
 If you have an unfortunate branch that is named `hello.c`, this
 step would be confused as an instruction to switch to that branch.
-- 
1.6.2.1.427.g061ea
