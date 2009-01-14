From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 3/3] mark fixed breakage as expect pass for "git mv -k" multiple files
Date: Wed, 14 Jan 2009 18:03:23 +0100
Message-ID: <1231952603-32527-4-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
 <1231952603-32527-1-git-send-email-git@drmicha.warpmail.net>
 <1231952603-32527-2-git-send-email-git@drmicha.warpmail.net>
 <1231952603-32527-3-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 18:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9Bg-0006nq-5G
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764244AbZANREL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764202AbZANREI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:04:08 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56870 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764171AbZANREH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 12:04:07 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7790D211796;
	Wed, 14 Jan 2009 12:04:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 14 Jan 2009 12:04:06 -0500
X-Sasl-enc: qBUTKzfszb4SiUYEnHfQu7nwEi6PqaBYLmxMSArthw6q 1231952645
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BFCFC30FF5;
	Wed, 14 Jan 2009 12:04:05 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1231952603-32527-3-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105660>

The new tests pass now so mark them as such.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7001-mv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 5c1485d..ef2e78f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -49,7 +49,7 @@ test_expect_success \
      test -f untracked1 &&
      test ! -f path0/untracked1'
 
-test_expect_failure \
+test_expect_success \
     'checking -k on multiple untracked files' \
     'touch untracked2 &&
      git mv -k untracked1 untracked2 path0 &&
-- 
1.6.0.6
