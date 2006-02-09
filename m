From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Add --diff-filter= documentation paragraph
Date: Thu, 09 Feb 2006 09:12:11 -0600
Message-ID: <E1F7DSt-0001q8-PV@jdl.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 16:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7DTF-0003tZ-5W
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 16:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWBIPMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 10:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWBIPMa
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 10:12:30 -0500
Received: from colo.jdl.com ([66.118.10.122]:57216 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932527AbWBIPMa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 10:12:30 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1F7DSt-0001q8-PV
	for git@vger.kernel.org; Thu, 09 Feb 2006 09:12:12 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15812>


Signed-off-by: Jon Loeliger <jdl@jdl.com>

----

So, I don't know what the "*" selection flag does.
It is called "AON" in the source.  Anyone?


diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 5c85167..e00dd6c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -35,6 +35,13 @@
 -C::
	Detect copies as well as renames.

+--diff-filter=[ACDMRTUX*B]::
+	Select only files that are Added (A), Copied (C), Deleted (D),
+	Modified (M), Renamed (R), have their Type (mode) changed,
+	are Unmerged (U), are Unknown (X), are "AON" (*),
+	or have had their pairing Broken (B).  Any combination of
+	the filter characters may be used.
+
 --find-copies-harder::
	For performance reasons, by default, -C option finds copies only
	if the original file of the copy was modified in the same
