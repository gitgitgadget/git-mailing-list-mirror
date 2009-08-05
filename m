From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] t6010-merge-base.sh: Depict the octopus test graph
Date: Wed,  5 Aug 2009 09:59:18 +0200
Message-ID: <1249459160-3931-2-git-send-email-git@drmicha.warpmail.net>
References: <1249459160-3931-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbPW-00031z-Sk
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933724AbZHEH7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933578AbZHEH7h
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:59:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42605 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933694AbZHEH7g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:59:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 26D623BCBA0;
	Wed,  5 Aug 2009 03:59:37 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Aug 2009 03:59:37 -0400
X-Sasl-enc: RRJwOlUcH9PwQ/vEZW3woa0lm7RpGtJu/sMqESeAUBDc 1249459176
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 638F42DE12;
	Wed,  5 Aug 2009 03:59:36 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
In-Reply-To: <1249459160-3931-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124874>

...so that it is easier to reuse it for other tests.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6010-merge-base.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 04e4b7c..79124ec 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -110,6 +110,18 @@ test_expect_success 'compute merge-base (all)' \
 
 # Another set to demonstrate base between one commit and a merge
 # in the documentation.
+#
+# * C (MMC) * B (MMB) * A  (MMA)
+# * o       * o       * o
+# * o       * o       * o
+# * o       * o       * o
+# * o       | _______/
+# |         |/
+# |         * 1 (MM1)
+# | _______/
+# |/
+# * root (MMR)
+
 
 test_expect_success 'merge-base for octopus-step (setup)' '
 	test_tick && git commit --allow-empty -m root && git tag MMR &&
-- 
1.6.4.70.g9c084
