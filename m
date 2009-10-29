From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Make t9150 and t9151 test scripts executable
Date: Thu, 29 Oct 2009 16:26:20 +0100
Message-ID: <2cd5f4dcea8c36732de402caa0b8721b7b4a786f.1256829775.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 16:26:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WtW-0008ME-7h
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbZJ2P0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZJ2P0X
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:26:23 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56270 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754959AbZJ2P0W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 11:26:22 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B6628B5860;
	Thu, 29 Oct 2009 11:26:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 29 Oct 2009 11:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=FY1WHdU/mDg6sJu8xA/+XwA+nEs=; b=TjHUBu58uxSMiLEbLRoeb29a+wVpUmA7rH5FkCv2s3VT5pgmiecX2VjbWonrYD4T7rMXo7fZ/wukR4AkuMALjVhVmdhr41IYPjloCnlCYERSUNvYFgzhopgGZBEAt/aZuqMhCatWhrA6TPmQHlB5ock29v3N1jb9XEHZ0phrRzc=
X-Sasl-enc: KB1ZA6/2O++LByv/e71NAgaPChjZrl1UNANdADDs7qoT 1256829986
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29660BF8;
	Thu, 29 Oct 2009 11:26:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.86.g0056e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131600>

so that they can be run individually as
(cd t && ./t9150-svk-mergetickets.sh)
etc. just like all other test scripts.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Not much more to say. Wanted to be a good boy and run the new tests.
One can use sh, of course, but there's a reason all other tests are executable.

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/t9150-svk-mergetickets.sh
 mode change 100644 => 100755 t/t9151-svn-mergeinfo.sh

diff --git a/t/t9150-svk-mergetickets.sh b/t/t9150-svk-mergetickets.sh
old mode 100644
new mode 100755
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
old mode 100644
new mode 100755
-- 
1.6.5.86.g0056e
