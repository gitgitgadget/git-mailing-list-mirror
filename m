From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 03:43:51 -0700
Message-ID: <20070719104351.GA17182@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 12:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTUO-0008Pm-4y
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591AbXGSKny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbXGSKny
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:43:54 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:52184
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1756017AbXGSKnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:43:53 -0400
Received: (qmail 17272 invoked by uid 1001); 19 Jul 2007 10:43:51 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52963>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3fbfd45..4c4d174 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -417,7 +417,9 @@ other
 	See gitlink:git-merge[1]
 
 'GIT_PAGER'::
-	This environment variable overrides `$PAGER`.
+	This environment variable overrides `$PAGER`. If it is set
+	to an empty string or to the value "cat", git will not launch
+	a pager.
 
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
-- 
1.5.3.rc2.4.g726f9
