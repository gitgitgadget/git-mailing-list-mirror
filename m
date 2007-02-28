From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH] Correct ordering in git-cvsimport's option documentation
Date: Tue, 27 Feb 2007 22:27:44 -0500
Message-ID: <87r6sb6jwv.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 04:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFt3-0002jW-8X
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXB1Dxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXB1Dxp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:53:45 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:54722
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408AbXB1Dxp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Feb 2007 22:53:45 -0500
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 22:53:45 EST
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 1F9FB89C03B; Tue, 27 Feb 2007 22:27:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40887>

A pair of commits on January 8th added option documentation (for -a,
-S and -L) in the middle of the documentation for the -A option.  This
makes -A's documentation contiguous again.

Signed-off-by: Michael Poole <mdpoole@troilus.org>

---
 git-cvsimport.txt |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index f5450de..0d59c06 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -96,11 +96,6 @@ If you need to pass multiple options, separate them with a comma.
 -s <subst>::
 	Substitute the character "/" in branch names with <subst>
 
--A <author-conv-file>::
-	CVS by default uses the Unix username when writing its
-	commit logs. Using this option and an author-conv-file
-	in this format
-
 -a::
 	Import all commits, including recent ones. cvsimport by default
 	skips commits that have a timestamp less than 10 minutes ago.
@@ -112,6 +107,10 @@ If you need to pass multiple options, separate them with a comma.
 	Limit the number of commits imported. Workaround for cases where
 	cvsimport leaks memory.
 
+-A <author-conv-file>::
+	CVS by default uses the Unix username when writing its
+	commit logs. Using this option and an author-conv-file
+	in this format
 +
 ---------
 	exon=Andreas Ericsson <ae@op5.se>
