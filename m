From: Marcus Fritzsch <m@fritschy.de>
Subject: [PATCH] Fixed a formulation mistake in
	Documentation/user-manual.txt
Date: Fri, 6 Jul 2007 09:02:20 +0200
Message-ID: <20070706070220.GA13920@znephf.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 09:03:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6hqt-0004bz-Jj
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 09:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759990AbXGFHDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758960AbXGFHDg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 03:03:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:49397 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820AbXGFHDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 03:03:36 -0400
Received: from [89.59.98.102] (helo=localhost)
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis),
	id 0MKwtQ-1I6hqV20Yg-0003CH; Fri, 06 Jul 2007 09:03:33 +0200
Received: from m by localhost with local (Exim 4.67)
	(envelope-from <m@fritschy.de>)
	id 1I6hpc-00046C-Gd; Fri, 06 Jul 2007 09:02:20 +0200
Content-Disposition: inline
X-Cool: Debian GNU/Linux
X-Operating-System: Debian GNU/Linux lenny/sid (Kernel 2.6.21.5-b0)
X-Link: http://www.notcpa.de
X-Message-Flag: Outlook is terribly insecure, please have a look at for
	example Thunderbird. http://www.mozilla.org
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Provags-ID: V01U2FsdGVkX18UjJ3Z0gJFI2bt/vVvJNI6of1+5g+IXXnxuxZ
 cgumCNzV0a4nY81azFbq8ZNX4OxsnMuR23PsgJJc+lHWNW6jRi
 pySbx71c1+kOovQtIOGlw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51726>

This one fixes a small formulation weirdness in
Documentation/user-manual.txt

Signed-off-by: Marcus Fritzsch <m@fritschy.de>
---
 Documentation/user-manual.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ff7c71d..c23077c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2957,13 +2957,13 @@ developed.  If you blow the directory cache away entirely, you generally
 haven't lost any information as long as you have the name of the tree
 that it described.
 
-At the same time, the index is at the same time also the
-staging area for creating new trees, and creating a new tree always
-involves a controlled modification of the index file.  In particular,
-the index file can have the representation of an intermediate tree that
-has not yet been instantiated.  So the index can be thought of as a
-write-back cache, which can contain dirty information that has not yet
-been written back to the backing store.
+At the same time, the index is also the staging area for creating
+new trees, and creating a new tree always involves a controlled
+modification of the index file.  In particular, the index file can
+have the representation of an intermediate tree that has not yet been
+instantiated.  So the index can be thought of as a write-back cache,
+which can contain dirty information that has not yet been written back
+to the backing store.
 
 
 
-- 
1.5.3.rc0.31.g39f17
