From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation: list git-credential in plumbing commands
Date: Wed,  8 Aug 2012 09:58:27 +0200
Message-ID: <1344412707-22356-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 08 09:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz1AD-0003wY-Un
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 09:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757848Ab2HHH6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 03:58:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58832 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757369Ab2HHH6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 03:58:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q787tPxX014543
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Aug 2012 09:55:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sz19z-00027m-AC; Wed, 08 Aug 2012 09:58:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sz19z-0005pN-7k; Wed, 08 Aug 2012 09:58:31 +0200
X-Mailer: git-send-email 1.7.12.rc1.183.gb94da76
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Aug 2012 09:55:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q787tPxX014543
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1345017328.67569@onsj21roIT56/ViqIKuVCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203068>

Commit e30b2feb1b (Jun 24 2012, add 'git credential' plumbing command)
forgot to add git-credential to command-list.txt, hence the command was
not appearing in the documentation, making it hard for users to discover
it.

While we're there, capitalize the description line for git-crendential
for consistancy with other commands.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-credential.txt | 2 +-
 command-list.txt                 | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 53adee3..810e957 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -3,7 +3,7 @@ git-credential(1)
 
 NAME
 ----
-git-credential - retrieve and store user credentials
+git-credential - Retrieve and store user credentials
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index 14ea67a..ec64cac 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -25,6 +25,7 @@ git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
+git-credential                          purehelpers
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
-- 
1.7.12.rc1.183.gb94da76
