From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 8/8] Update git-http-fetch documentation
Date: Fri, 27 Apr 2007 00:10:03 -0500
Message-ID: <20070427051002.GG9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIl2-0001JI-IK
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbXD0FMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbXD0FMd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:12:33 -0400
Received: from www.aeruder.net ([65.254.53.245]:4601 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340AbXD0FMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:12:33 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 6BDA240EC7;
	Fri, 27 Apr 2007 00:12:32 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45695>

Documentation/git-http-fetch.txt: --recover to resume a failed fetch
operation.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-http-fetch.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 7dc2df3..4deabc3 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -39,6 +39,10 @@ commit-id::
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--recover::
+	Verify that everything reachable from target is fetched.  Used after
+	an earlier fetch is interrupted.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.5.2.rc0.64.g8476
