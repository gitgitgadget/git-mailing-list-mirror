From: Marco Colombo <m.colombo@ed.ac.uk>
Subject: [PATCH] gitk: Use a different background color for the active head.
Date: Fri, 09 Nov 2007 11:21:48 +0000
Message-ID: <473442CC.3050907@ed.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010306010900000505090401"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 12:57:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqSUG-0005nB-5P
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXKIL5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXKIL5H
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:57:07 -0500
Received: from lmtp1.ucs.ed.ac.uk ([129.215.149.64]:52585 "EHLO
	lmtp1.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbXKIL5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:57:06 -0500
X-Greylist: delayed 2116 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2007 06:57:06 EST
Received: from [129.215.104.171] (newton.maths.ed.ac.uk [129.215.104.171])
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id lA9BLmIO014849
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 11:21:48 GMT
User-Agent: Thunderbird 1.5.0.12 (X11/20071018)
X-Edinburgh-Scanned: at lmtp1.ucs.ed.ac.uk
    with MIMEDefang 2.52, Sophie, Sophos Anti-Virus
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64169>

This is a multi-part message in MIME format.
--------------010306010900000505090401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010306010900000505090401
Content-Type: text/x-patch;
 name*0="0001-gitk-Use-a-different-background-color-for-the-activ.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-gitk-Use-a-different-background-color-for-the-activ.pat";
 filename*1="ch"

>From 7c7a8f6dbe5c4f96ddbc508fa4ab9c2dbae56d82 Mon Sep 17 00:00:00 2001
From: Marco Colombo <m.colombo@ed.ac.uk>
Date: Fri, 9 Nov 2007 10:19:01 +0000
Subject: [PATCH] gitk: Use a different background color for the active head.

Currently the background color of all heads is green. The active head is
distinguished only by the use of a bold font. This patch changes the
background color of the active head to orange, thus making it
visually more separate from the other heads.

Signed-off-by: Marco Colombo <m.colombo@ed.ac.uk>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1da0b0a..dacbc31 100755
--- a/gitk
+++ b/gitk
@@ -4038,6 +4038,7 @@ proc drawtags {id x xt y1} {
 	    if {[incr nheads -1] >= 0} {
 		set col green
 		if {$tag eq $mainhead} {
+		    set col orange
 		    set font mainfontbold
 		}
 	    } else {
-- 
1.5.3.4


--------------010306010900000505090401--
