From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Forgotten 'tracking' -> 'remote-tracking'
Date: Tue,  2 Nov 2010 21:32:41 +0100
Message-ID: <1288729961-23827-1-git-send-email-Matthieu.Moy@imag.fr>
References: <AANLkTinwdDJKQMPx=Z_F7H9Nj=m0MYjQ8SnOjPV2J5x1@mail.gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 21:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDNXx-0004Oi-RT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab0KBUd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 16:33:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39643 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab0KBUd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 16:33:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA2KQM8W021517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 21:26:22 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDNXG-00073q-OO; Tue, 02 Nov 2010 21:32:50 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDNXG-0006DD-MN; Tue, 02 Nov 2010 21:32:50 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <AANLkTinwdDJKQMPx=Z_F7H9Nj=m0MYjQ8SnOjPV2J5x1@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Nov 2010 21:26:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2KQM8W021517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289334386.77152@0f0AJ1Fh/mHpHplllnxh1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160552>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> You missed a tracking branch -> remote-tracking branch substitution in
> the third/fourth line.

Oops, right. Junio, can you either add this or (better) squash this in my PATCH 5/10?

Thanks,

 Documentation/glossary-content.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index ba96b32..f04b48e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -351,7 +351,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A regular git <<def_branch,branch>> that is used to follow changes from
-	another <<def_repository,repository>>. A tracking
+	another <<def_repository,repository>>. A remote-tracking
 	branch should not contain direct modifications or have local commits
 	made to it. A remote-tracking branch can usually be
 	identified as the right-hand-side <<def_ref,ref>> in a Pull:
-- 
1.7.3.2.183.g2e7b0
