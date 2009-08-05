From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git-rev-list.txt: Correct description for multiple arguments
Date: Wed,  5 Aug 2009 09:58:36 +0200
Message-ID: <1249459117-3853-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbOn-0002hr-T5
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933650AbZHEH6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933578AbZHEH6w
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:58:52 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59432 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933355AbZHEH6w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:58:52 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7CF033BDF6B;
	Wed,  5 Aug 2009 03:58:52 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 05 Aug 2009 03:58:52 -0400
X-Sasl-enc: uv7uZQ5355SWW8TGQb1HSnC1vFivbUKNpFsSR9DmnRkA 1249459131
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 576DB2B6B;
	Wed,  5 Aug 2009 03:58:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124870>

"git rev-list A B" really lists those commits which are included in A or
B, i.e. it lists those in A and those in B. Say so, because saying
"which are included in A and B" would mean those who are in both A and
B.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Patch against master.

The current description is simply wrong, which is why I strongly suggest this fix.
The upcoming suggests an extra paragraph for clarifying the use of multiple
revision arguments.

 Documentation/git-rev-list.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index a765cfa..847cc7d 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -63,7 +63,7 @@ command:
 	$ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
 
-means "list all the commits which are included in 'foo' and 'bar', but
+means "list all the commits which are included in 'foo' or 'bar', but
 not in 'baz'".
 
 A special notation "'<commit1>'..'<commit2>'" can be used as a
-- 
1.6.4.70.g9c084
