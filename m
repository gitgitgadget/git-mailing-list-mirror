From: esr@thyrsus.com (Eric S. Raymond)
Subject: [PATCH] Remove the suggestion to use parsecvs, which is currently
 broken.
Date: Fri, 28 Dec 2012 11:20:25 -0500 (EST)
Message-ID: <20121228162025.8565E4413A@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 17:21:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TocgV-0001GC-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 17:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab2L1QVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 11:21:04 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:32813
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2L1QVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 11:21:03 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 8565E4413A; Fri, 28 Dec 2012 11:20:25 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212243>

The parsecvs code has been neglected for a long time, and the only
public version does not even build correctly.  I have been handed
control of the project and intend to fix this, but until I do it
cannot be recommended.

Also, the project URL given for Subversion needed to be updated
to follow their site move.
---
 Documentation/git-cvsimport.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 98d9881..9d5353e 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -213,11 +213,9 @@ Problems related to tags:
 * Multiple tags on the same revision are not imported.
 
 If you suspect that any of these issues may apply to the repository you
-want to import consider using these alternative tools which proved to be
-more stable in practice:
+want to imort, consider using cvs2git:
 
-* cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
-* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
+* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
 
 GIT
 ---
-- 
1.8.1.rc2



-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances...	-- IRS Strategic Plan, (May 1984)
