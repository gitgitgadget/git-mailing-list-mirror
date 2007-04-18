From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-tar-tree: complete deprecation conversion message
Date: Thu, 19 Apr 2007 11:51:21 +1200
Message-ID: <11769402811235-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 02:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeKJD-0003Dc-L0
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 02:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993020AbXDSAPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 20:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993021AbXDSAPL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 20:15:11 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:39036 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993020AbXDSAPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 20:15:10 -0400
X-Greylist: delayed 1426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2007 20:15:10 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HeJvl-0007sU-3E; Thu, 19 Apr 2007 11:51:21 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 0ED0DCB9E1; Thu, 19 Apr 2007 11:51:21 +1200 (NZST)
X-Mailer: git-send-email 1.5.1.1.175.g31e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44970>

The syntax for git-archive is different; warn about it in the
deprecation message on the manual page.
---
 Documentation/git-tar-tree.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 5959405..7bde73b 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 THIS COMMAND IS DEPRECATED.  Use `git-archive` with `--format=tar`
-option instead.
+option instead (and move the <base> argument to `--prefix=base/`).
 
 Creates a tar archive containing the tree structure for the named tree.
 When <base> is specified it is added as a leading path to the files in the
-- 
1.5.1.1.175.g31e4
