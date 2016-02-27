From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] README.md: don't take 'commandname' literally
Date: Sat, 27 Feb 2016 11:46:12 +0100
Message-ID: <1456569972-860-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 27 11:46:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZcOK-00035y-5f
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 11:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbcB0KqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 05:46:23 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34856 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256AbcB0KqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 05:46:22 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1RAkGJw013017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 27 Feb 2016 11:46:16 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1RAkHQB020321;
	Sat, 27 Feb 2016 11:46:17 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 27 Feb 2016 11:46:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1RAkGJw013017
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1457174777.38536@VAym2eRUHzo2ZKhf+ovFNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287691>

The link to Documentation/git-commandname.txt was obviously broken.
Remove the link and make it clear that it is not a literal path name by
using *italics* in makdown.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sorry for the overeager change in the previous patch :-(.

 README.md | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index d1ffbb6..2087748 100644
--- a/README.md
+++ b/README.md
@@ -17,11 +17,11 @@ including full documentation and Git related tools.
 
 See [Documentation/gittutorial.txt][] to get started, then see
 [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
-[Documentation/git-commandname.txt][] for documentation of each command.
+Documentation/git-*commandname*.txt for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with "man gittutorial" or "git help tutorial", and the
-documentation of each command with "man git-commandname" or "git help
-commandname".
+documentation of each command with "man git-*commandname*" or "git help
+*commandname*".
 
 CVS users may also want to read [Documentation/gitcvs-migration.txt][]
 ("man gitcvs-migration" or "git help cvs-migration" if git is
@@ -57,6 +57,5 @@ and the name as (depending on your mood):
 [INSTALL]: INSTALL
 [Documentation/gittutorial.txt]: Documentation/gittutorial.txt
 [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
-[Documentation/git-commandname.txt]: Documentation/git-commandname.txt
 [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
 [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
-- 
2.7.2.334.g35ed2ae.dirty
