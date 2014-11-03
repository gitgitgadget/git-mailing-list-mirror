From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] RelNotes/2.2.0.txt: fix minor typos
Date: Mon,  3 Nov 2014 16:12:00 +0100
Message-ID: <1415027520-28410-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 03 16:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlJfT-0006vF-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 16:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbaKCPff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 10:35:35 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52185 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbaKCPfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 10:35:34 -0500
X-Greylist: delayed 1406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2014 10:35:33 EST
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sA3FC0va013277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2014 16:12:01 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sA3FC2XI016961;
	Mon, 3 Nov 2014 16:12:02 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XlJIY-0007QW-C5; Mon, 03 Nov 2014 16:12:02 +0100
X-Mailer: git-send-email 2.0.2.737.gfb43bde
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 03 Nov 2014 16:12:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sA3FC0va013277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1415632321.30491@9sZmeA9sp7iOvRrs7U2yNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/RelNotes/2.2.0.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.0.txt
index 741e14e..a50896f 100644
--- a/Documentation/RelNotes/2.2.0.txt
+++ b/Documentation/RelNotes/2.2.0.txt
@@ -40,7 +40,7 @@ UI, Workflows & Features
    diff backend when it exits with a non-zero status.
 
  * "git grep" allows to paint (or not paint) partial matches on
-   context lines whenshowing "grep -C<num>" output in color.
+   context lines when showing "grep -C<num>" output in color.
 
  * "log --date=iso" uses a slight variant of ISO 8601 format that is
    made more human readable.  A new "--date=iso-strict" option gives
@@ -62,7 +62,7 @@ UI, Workflows & Features
    e.g. "hello_BASE_4321.c").
 
  * The temporary files "git mergetools" uses can be placed in a newly
-   creted temporary directory, instead of the current directory, by
+   created temporary directory, instead of the current directory, by
    setting the mergetool.writeToTemp configuration variable.
 
  * "git mergetool" understands "--tool bc" now, as version 4 of
@@ -292,6 +292,6 @@ notes for details).
    (merge b12d045 da/mergetool-meld later to maint).
 
  * "git pack-objects" forgot to disable the codepath to generate
-   object recheability bitmap when it needs to split the resulting
+   object reachability bitmap when it needs to split the resulting
    pack.
    (merge 2113471 jk/pack-objects-no-bitmap-when-splitting later to maint).
-- 
2.0.2.737.gfb43bde
