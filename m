From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Document --quiet option to git-diff
Date: Sun, 25 Mar 2007 01:55:43 +0100
Message-ID: <20070325005543.GD11507@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 01:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVH1Q-0005lp-Hi
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 01:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbXCYAzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbXCYAzp
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 20:55:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:13486 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbXCYAzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 20:55:45 -0400
Received: from tigra.home (Fc89f.f.strato-dslnet.de [195.4.200.159])
	by post.webmailer.de (fruni mo61) (RZmta 5.4)
	with ESMTP id D057c0j2P0KN8O ; Sun, 25 Mar 2007 01:55:43 +0100 (MET)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 52F0C277B6;
	Sun, 25 Mar 2007 01:55:43 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 33A9ABF79; Sun, 25 Mar 2007 01:55:43 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a4mM=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43025>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/diff-options.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 77a3f78..1689c74 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -164,5 +164,8 @@
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
 
+--quiet::
+	Disable all output of the program. Implies --exit-code.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
-- 
1.5.1.rc1.63.g59cc5
