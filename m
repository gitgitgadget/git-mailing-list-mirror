From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] Cleanup warning about known issues in cvsimport
	documentation
Date: Wed, 1 Apr 2009 22:24:28 +0200
Message-ID: <20090401202415.GA90837@macbook.lan>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net> <20090330223646.GC68118@macbook.lan> <7v4oxaa506.fsf@gitster.siamese.dyndns.org> <20090331164503.GB72569@macbook.lan> <20090331194940.GB23184@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp71P-00046H-P3
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934235AbZDAUYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 16:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933759AbZDAUYc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 16:24:32 -0400
Received: from darksea.de ([83.133.111.250]:33107 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934015AbZDAUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 16:24:32 -0400
Received: (qmail 16855 invoked from network); 1 Apr 2009 22:24:15 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 1 Apr 2009 22:24:15 +0200
Content-Disposition: inline
In-Reply-To: <20090331194940.GB23184@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115413>

Not all statements were complete sentences.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

I corrected the typos. This is the interdiff:

 diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
 index ba6a50b..d7bab13 100644
 --- a/Documentation/git-cvsimport.txt
 +++ b/Documentation/git-cvsimport.txt
 @@ -176,7 +176,7 @@ Problems related to timestamps:
     to be used for ordering commits changes may show up in the wrong
     order.
   * If any files were ever "cvs import"ed more than once (e.g., import of
 -   more than one vendor release) the HEAD will be incorrect.
 +   more than one vendor release) the HEAD contains the wrong content.
   * If the timestamp order of different files cross the revision order
     within the commit matching time window the order of commits may be
     wrong.
 @@ -187,7 +187,7 @@ Problems related to branches:
   * All files from the branching point are added to a branch even if
     never added in cvs.
   * This applies to files added to the source branch *after* a daughter
 -   branch was created: If previously no commit was made on the daugther
 +   branch was created: if previously no commit was made on the daughter
     branch they will erroneously be added to the daughter branch in git.
  
  Problems related to tags:


 Documentation/git-cvsimport.txt |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index e1fd047..d7bab13 100644
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
+   more than one vendor release) the HEAD contains the wrong content.
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
+   branch was created: if previously no commit was made on the daughter
+   branch they will erroneously be added to the daughter branch in git.
 
 Problems related to tags:
 
-* Multiple tags on the same revision are not imported
+* Multiple tags on the same revision are not imported.
 
 If you suspect that any of these issues may apply to the repository you
 want to import consider using these alternative tools which proved to be
-- 
1.6.2.1.424.g0b27.dirty
