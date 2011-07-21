From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH] Documentation: git-filter-branch honors replacement refs
Date: Thu, 21 Jul 2011 16:10:52 +0100
Message-ID: <1311261052-16178-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 17:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjvLs-0006DZ-9F
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 17:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab1GUPjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 11:39:42 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:59868 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab1GUPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 11:39:40 -0400
X-Greylist: delayed 1713 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jul 2011 11:39:40 EDT
Received: from dyn1214-93.wlan.ic.ac.uk ([129.31.214.93] helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Qjuu2-0006eE-UQ; Thu, 21 Jul 2011 16:11:07 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.72)
	(envelope-from <peter@pcc.me.uk>)
	id 1Qjutr-0004El-Ua; Thu, 21 Jul 2011 16:10:55 +0100
X-Mailer: git-send-email 1.7.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it clear that git-filter-branch will honor and make permanent
replacement refs as well as grafts.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-filter-branch.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9dc1f2a..0f2f117 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -32,8 +32,9 @@ changes, which would normally have no effect.  Nevertheless, this may be
 useful in the future for compensating for some git bugs or such,
 therefore such a usage is permitted.
 
-*NOTE*: This command honors `.git/info/grafts`. If you have any grafts
-defined, running this command will make them permanent.
+*NOTE*: This command honors `.git/info/grafts` and `.git/refs/replace/`.
+If you have any grafts or replacement refs defined, running this command
+will make them permanent.
 
 *WARNING*! The rewritten history will have different object names for all
 the objects and will not converge with the original branch.  You will not
-- 
1.7.5.3
