From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] git-checkout.txt: clarify that <branch> applies when no path is given.
Date: Tue,  7 Apr 2009 14:43:53 +0200
Message-ID: <1239108233-20924-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1239099643-11959-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 14:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrAin-0000qB-Od
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 14:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZDGMqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZDGMqa
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 08:46:30 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:54305 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbZDGMqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 08:46:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n37Ci67V022029;
	Tue, 7 Apr 2009 14:44:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LrAeq-0008ST-Oy; Tue, 07 Apr 2009 14:44:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LrAeq-0005SH-Lw; Tue, 07 Apr 2009 14:44:04 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <1239099643-11959-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 07 Apr 2009 14:44:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115953>

Otherwise, the sentence "Defaults to HEAD." can be mis-read to mean
that "git checkout -- hello.c" checks-out from HEAD.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sorry, patch v1 was introducing a spurious newline, which broke
asciidoc syntax. This fixes it, but Junio, if you already applied v1,
just remove the empty line after <branch>:: and before +.

 Documentation/git-checkout.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 0b5485b..223ea9c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -126,9 +126,13 @@ the conflicted merge in the specified paths.
 <new_branch>::
 	Name for the new branch.
 
+<tree-ish>::
+	Tree to checkout from (when paths are given). If not specified,
+	the index will be used.
+
 <branch>::
-	Branch to checkout; may be any object ID that resolves to a
-	commit.  Defaults to HEAD.
+	Branch to checkout (when no paths are given); may be any object
+	ID that resolves to a commit.  Defaults to HEAD.
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
-- 
1.6.2.2.449.g92961.dirty
