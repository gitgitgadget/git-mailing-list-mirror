From: Matthew L Daniel <mdaniel@gmail.com>
Subject: [PATCH] git-gui: Do not select Revert Changes by default
Date: Sat, 17 Mar 2012 15:12:55 +0000 (UTC)
Message-ID: <loom.20120317T161127-418@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 16:13:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8vJj-0005xA-7u
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 16:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab2CQPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 11:13:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:35495 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285Ab2CQPNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 11:13:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S8vJZ-0005pG-6Q
	for git@vger.kernel.org; Sat, 17 Mar 2012 16:13:05 +0100
Received: from 85-171-89-252.rev.numericable.fr ([85.171.89.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 16:13:05 +0100
Received: from mdaniel by 85-171-89-252.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 16:13:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.171.89.252 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.100 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193332>

Currently, if one activates the revert changes dialog,
it has the destructive button selected as the default.

This change moves the default action to "do nothing".
---
 git-gui/lib/index.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 8efbbdd..252aa33 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -437,7 +437,7 @@ proc revert_helper {txt paths} {
 
 [mc "Any unstaged changes will be permanently lost by the revert."]" \
 		question \
-		1 \
+		0 \
 		[mc "Do Nothing"] \
 		[mc "Revert Changes"] \
 		]
-- 
1.7.9.msysgit.0
