From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-ls-files.txt: clarify what "other files" mean for --other
Date: Thu,  6 Aug 2009 17:11:48 +0200
Message-ID: <1249571508-21897-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 17:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4de-0006s0-25
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbZHFPMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbZHFPMA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:12:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54451 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755792AbZHFPL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 11:11:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n76FB2BY015887
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 17:11:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZ4dD-0008A2-MU; Thu, 06 Aug 2009 17:11:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZ4dC-0005hr-Rd; Thu, 06 Aug 2009 17:11:50 +0200
X-Mailer: git-send-email 1.6.4.55.gc63c6.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Aug 2009 17:11:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n76FB2BY015887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250176264.27434@tZTVi7iBKZDvBQkJ9rKP0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125078>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Actually, if it was not about backward compatibility, I'd just replace
-o, --other with -u, --untracked and talk about "untracked" everywhere,
but compatibility matters more than consistancy for plumbing.

 Documentation/git-ls-files.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 057a021..021066e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -44,7 +44,7 @@ OPTIONS
 
 -o::
 --others::
-	Show other files in the output
+	Show other (i.e. untracked) files in the output
 
 -i::
 --ignored::
-- 
1.6.4.55.gc63c6.dirty
