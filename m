From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] Document core.excludesfile for git-add
Date: Wed, 16 May 2007 23:08:50 -0600
Message-ID: <1179378530822-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 07:09:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoYEn-0007kS-PQ
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760716AbXEQFIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760462AbXEQFIy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:08:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45182 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760365AbXEQFIx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 01:08:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B5A9821FC18
	for <git@vger.kernel.org>; Thu, 17 May 2007 01:10:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 May 2007 01:08:53 -0400
X-Sasl-enc: CF7d0d856US2dR/7PLdBoxSh/dLD9LhQ30fZvtVnU7ym 1179378533
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id CE7221D055;
	Thu, 17 May 2007 01:08:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.rc3.39.gaf9b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47500>

During the discussion of core.excludesfile in the user-manual, I realized
that the configuration wasn't mentioned in the man pages.

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 Documentation/git-add.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 27b9c0f..a0c9f68 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -69,6 +69,15 @@ OPTIONS
 	for command-line options).
 
 
+Configuration
+-------------
+
+The optional configuration variable 'core.excludesfile' indicates a path to a
+file containing patterns of file names to exclude from git-add, similar to
+$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
+those in info/exclude.  See link:repository-layout.html[repository layout].
+
+
 EXAMPLES
 --------
 git-add Documentation/\\*.txt::
-- 
1.5.2.rc3.39.gaf9b-dirty
