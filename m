From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-checkout.txt: clarify that <branch> applies when no path is given.
Date: Tue,  7 Apr 2009 12:20:43 +0200
Message-ID: <1239099643-11959-1-git-send-email-Matthieu.Moy@imag.fr>
References: <e2b179460904070241y493ef876xc628d35b606e4032@mail.gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 12:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr8V6-0006ra-Nk
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 12:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZDGKYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 06:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbZDGKYQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 06:24:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:33002 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbZDGKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 06:24:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n37AKpxH015283
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Apr 2009 12:20:51 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lr8Q8-0005Of-Q0; Tue, 07 Apr 2009 12:20:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lr8Q8-00037Q-Ni; Tue, 07 Apr 2009 12:20:44 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <e2b179460904070241y493ef876xc628d35b606e4032@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 07 Apr 2009 12:20:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115944>

Otherwise, the sentence "Defaults to HEAD." can be mis-read to mean
that "git checkout -- hello.c" checks-out from HEAD.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> s/path are/paths are/g

Right.

I'm not 100% sure about "no paths are given" Vs "no path is given",
but my understanding of english grammar is that since there could have
been several paths, the absence of path is still plural (French would
be singular here).

> Sorry if I come across as picking on your grammar, I think your
> documentation improvements are very worthwhile.

No harm ;-).

 Documentation/git-checkout.txt |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 0b5485b..7eafcdf 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -126,9 +126,14 @@ the conflicted merge in the specified paths.
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
 +
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
-- 
1.6.2.2.449.g92961.dirty
