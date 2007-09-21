From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Move the paragraph specifying where the .idx and .pack files should be
Date: Fri, 21 Sep 2007 06:43:44 -0700
Message-ID: <11903822243533-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 16:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYjIe-0003W3-R6
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 16:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXIUOPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 10:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758106AbXIUOPm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 10:15:42 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:55364 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbXIUOPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 10:15:41 -0400
X-Greylist: delayed 1911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2007 10:15:41 EDT
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1IYj3n-0002CW-J5; Fri, 21 Sep 2007 07:00:49 -0700
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1IYinI-0002gC-QJ; Fri, 21 Sep 2007 06:43:44 -0700
X-Mailer: git-send-email 1.5.3.1
X-Spam-Score: -4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58856>


Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/git-pack-objects.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 628f296..5237ab0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -25,16 +25,16 @@ is efficient to access.  The packed archive format (.pack) is
 designed to be unpackable without having anything else, but for
 random access, accompanied with the pack index file (.idx).
 
+Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
+any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
+enables git to read from such an archive.
+
 'git-unpack-objects' command can read the packed archive and
 expand the objects contained in the pack into "one-file
 one-object" format; this is typically done by the smart-pull
 commands when a pack is created on-the-fly for efficient network
 transport by their peers.
 
-Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
-any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-enables git to read from such an archive.
-
 In a packed archive, an object is either stored as a compressed
 whole, or as a difference from some other object.  The latter is
 often called a delta.
-- 
1.5.3.1
