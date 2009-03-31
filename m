From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Cleanup warning about known issues in cvsimport
	documentation
Date: Tue, 31 Mar 2009 18:45:03 +0200
Message-ID: <20090331164503.GB72569@macbook.lan>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net> <20090330223646.GC68118@macbook.lan> <7v4oxaa506.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loh6n-0000pH-3i
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762215AbZCaQpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759803AbZCaQpI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:45:08 -0400
Received: from darksea.de ([83.133.111.250]:49216 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758768AbZCaQpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:45:07 -0400
Received: (qmail 14282 invoked from network); 31 Mar 2009 18:44:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 18:44:52 +0200
Content-Disposition: inline
In-Reply-To: <7v4oxaa506.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115283>

Not all statements were complete sentences.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-cvsimport.txt |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index e1fd047..ba6a50b 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -173,24 +173,26 @@ ISSUES
 Problems related to timestamps:
 
  * If timestamps of commits in the cvs repository are not stable enough
-   to be used for ordering commits
+   to be used for ordering commits changes may show up in the wrong
+   order.
  * If any files were ever "cvs import"ed more than once (e.g., import of
-   more than one vendor release)
+   more than one vendor release) the HEAD will be incorrect.
  * If the timestamp order of different files cross the revision order
-   within the commit matching time window
+   within the commit matching time window the order of commits may be
+   wrong.
 
 Problems related to branches:
 
- * Branches on which no commits have been made are not imported
+ * Branches on which no commits have been made are not imported.
  * All files from the branching point are added to a branch even if
-   never added in cvs
- * files added to the source branch *after* a daughter branch was
-   created: If previously no commit was made on the daugther branch they
-   will erroneously be added to the daughter branch in git
+   never added in cvs.
+ * This applies to files added to the source branch *after* a daughter
+   branch was created: If previously no commit was made on the daugther
+   branch they will erroneously be added to the daughter branch in git.
 
 Problems related to tags:
 
-* Multiple tags on the same revision are not imported
+* Multiple tags on the same revision are not imported.
 
 If you suspect that any of these issues may apply to the repository you
 want to import consider using these alternative tools which proved to be
-- 
1.6.1.2.390.gba743
