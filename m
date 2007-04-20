From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] document --index-version for index-pack and pack-objects
Date: Thu, 19 Apr 2007 22:16:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704192214010.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 04:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeigW-0006Dx-I5
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 04:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbXDTCQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 22:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbXDTCQy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 22:16:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13991 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbXDTCQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 22:16:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGR00K3FYC57UE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Apr 2007 22:16:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45057>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 2229ee8..b7a49b9 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -68,6 +68,11 @@ OPTIONS
 	message can later be searched for within all .keep files to
 	locate any which have outlived their usefulness.
 
+--index-version=<version>[,<offset>]::
+	This is intended to be used by the test suite only. It allows
+	to force the version for the generated pack index, and to force
+	64-bit index entries on objects located above the given offset.
+
 
 Note
 ----
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index fdc6f97..d9e11c6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -138,6 +138,11 @@ base-name::
 	length, this option typically shrinks the resulting
 	packfile by 3-5 per-cent.
 
+--index-version=<version>[,<offset>]::
+	This is intended to be used by the test suite only. It allows
+	to force the version for the generated pack index, and to force
+	64-bit index entries on objects located above the given offset.
+
 
 Author
 ------
