From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Improve documentation for --dirstat diff option
Date: Mon, 1 Sep 2008 13:13:34 +0300
Message-ID: <20080901101334.GA4544@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 12:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6Qj-0001Ps-LV
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbYIAKNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757746AbYIAKNh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:13:37 -0400
Received: from zakalwe.fi ([80.83.5.154]:50563 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757152AbYIAKNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:13:36 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 80B362BC68; Mon,  1 Sep 2008 13:13:34 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94558>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
My earlier version of the patch already gave an example of use. This 
version changes the word "damage" to "impact" (Jakub Narebski's 
suggestion).

 Documentation/diff-options.txt |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1759386..150debb 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -59,12 +59,11 @@ endif::git-format-patch[]
 	lines.
 
 --dirstat[=limit]::
-	Output only the sub-directories that are impacted by a diff,
-	and to what degree they are impacted.  You can override the
-	default cut-off in percent (3) by "--dirstat=limit".  If you
-	want to enable "cumulative" directory statistics, you can use
-	the "--cumulative" flag, which adds up percentages recursively
-	even when they have been already reported for a sub-directory.
+	Output the distribution of relative impact (number of lines added or
+	removed) for each sub-directory. Directories with impact below
+	a cut-off percent (3% by default) are not shown. The cut-off percent
+	can be set with "--dirstat=limit". Child directory impact is not
+	counted for the parent directory, unless "--cumulative" is used.
 
 --summary::
 	Output a condensed summary of extended header information
-- 
1.6.0.1
