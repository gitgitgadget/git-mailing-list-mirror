From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Update git-add.txt according to the new possibilities of 'git add -p'.
Date: Thu, 16 Apr 2009 18:46:23 +0200
Message-ID: <1239900383-29628-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqiql4tuov.fsf@bauges.imag.fr>
 <1239900383-29628-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 18:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuUok-0006xA-DA
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 18:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbZDPQu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbZDPQu2
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 12:50:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:38654 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259AbZDPQu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 12:50:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3GGkd27028369
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2009 18:46:39 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LuUjW-0004w4-Eu; Thu, 16 Apr 2009 18:46:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LuUjW-0007iV-CV; Thu, 16 Apr 2009 18:46:38 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <1239900383-29628-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 16 Apr 2009 18:46:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116710>

The text is merely cut-and-pasted from git-add--interactive.perl. The
cut-and-paste also fixes a typo.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-add.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 709e04b..d938b42 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -245,9 +245,11 @@ patch::
 
        y - stage this hunk
        n - do not stage this hunk
-       q - quite, do not stage this hunk nor any of the remaining ones
+       q - quit, do not stage this hunk nor any of the remaining ones
        a - stage this and all the remaining hunks in the file
        d - do not stage this hunk nor any of the remaining hunks in the file
+       g - select a hunk to go to
+       / - search for a hunk matching the given regex
        j - leave this hunk undecided, see next undecided hunk
        J - leave this hunk undecided, see next hunk
        k - leave this hunk undecided, see previous undecided hunk
-- 
1.6.2.2.449.g92961.dirty
