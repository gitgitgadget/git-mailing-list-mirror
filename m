From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Fix unmatched emphasis tag in git-tutorial
Date: Wed, 18 Apr 2007 22:03:31 -0500
Message-ID: <20070419030331.GC19402@bowser.ruder>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 05:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMy3-0005Wo-Nv
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 05:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031076AbXDSDFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 23:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031077AbXDSDFn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 23:05:43 -0400
Received: from www.aeruder.net ([65.254.53.245]:3026 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031076AbXDSDFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 23:05:42 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 4081040164;
	Wed, 18 Apr 2007 22:05:42 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44983>

In asciidoc 7.1.2 and prior there is no obvious way to get:

'add'ing

to emphasize only the "add", instead it treats the first apostrophe as the
beginning of an emphasis, and the second apostrophe as a regular
apostrophe and makes the rest of the line an emphasis since there is no
closing apostrophe.  In the newer asciidoc you can do it pretty easily
with __add__ing but I'm not sure it would be best to make that a prereq
for something as silly as this.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 129c5c5..e978562 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -111,7 +111,7 @@ make it real.
 Note: don't forget to 'add' a file again if you modified it after the
 first 'add' and before 'commit'. Otherwise only the previous added
 state of that file will be committed. This is because git tracks
-content, so what you're really 'add'ing to the commit is the *content*
+content, so what you're really 'adding' to the commit is the *content*
 of the file in the state it is in when you 'add' it.
 
 2) By using 'git commit -a' directly
-- 
1.5.1.1.116.g8c4c
