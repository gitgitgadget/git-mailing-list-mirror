From: Garry Dolley <gdolley@ucla.edu>
Subject: [PATCH] Clarified gitattributes documentation regarding custom hunk header.
Date: Tue, 16 Sep 2008 23:20:39 -0700
Message-ID: <1221632439-31797-1-git-send-email-gdolley@ucla.edu>
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Garry Dolley <gdolley@ucla.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 08:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfqWd-0006aR-0U
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 08:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbYIQG1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 02:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYIQG1X
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 02:27:23 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:47330 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751072AbYIQG1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 02:27:22 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Sep 2008 02:27:22 EDT
Received: (qmail 25934 invoked from network); 17 Sep 2008 06:18:50 -0000
Received: from cpe-98-151-11-125.socal.res.rr.com (HELO garry-thinkpad) (gdolley@arpnetworks.com@98.151.11.125)
  by mail.arpnetworks.com with SMTP; 17 Sep 2008 06:18:50 -0000
Received: by garry-thinkpad (sSMTP sendmail emulation); Tue, 16 Sep 2008 23:20:39 -0700
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96067>

From: Garry Dolley <gdolley@arpnetworks.com>

The only part of the hunk header that we can change is the "TEXT"
portion.  Additionally, a few grammatical errors have been corrected.

Signed-off-by: Garry Dolley <gdolley@ucla.edu>
---
 Documentation/gitattributes.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6f3551d..e848c94 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -270,27 +270,27 @@ See linkgit:git[1] for details.
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Each group of changes (called "hunk") in the textual diff output
+Each group of changes (called a "hunk") in the textual diff output
 is prefixed with a line of the form:
 
 	@@ -k,l +n,m @@ TEXT
 
-The text is called 'hunk header', and by default a line that
-begins with an alphabet, an underscore or a dollar sign is used,
-which matches what GNU 'diff -p' output uses.  This default
-selection however is not suited for some contents, and you can
-use customized pattern to make a selection.
+This is called a 'hunk header'.  The "TEXT" portion is by default a line
+that begins with an alphabet, an underscore or a dollar sign; this
+matches what GNU 'diff -p' output uses.  This default selection however
+is not suited for some contents, and you can use a customized pattern
+to make a selection.
 
-First in .gitattributes, you would assign the `diff` attribute
+First, in .gitattributes, you would assign the `diff` attribute
 for paths.
 
 ------------------------
 *.tex	diff=tex
 ------------------------
 
-Then, you would define "diff.tex.funcname" configuration to
+Then, you would define a "diff.tex.funcname" configuration to
 specify a regular expression that matches a line that you would
-want to appear as the hunk header, like this:
+want to appear as the hunk header "TEXT", like this:
 
 ------------------------
 [diff "tex"]
-- 
1.6.0.1
