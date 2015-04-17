From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rev-list-options.txt: complete sentence about notes matching
Date: Fri, 17 Apr 2015 16:28:56 +0200
Message-ID: <2ff739260d94310b616eb4a0dd2bd8aac53fd762.1429280914.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 16:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7GV-000191-L6
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbbDQO3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:29:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54759 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932743AbbDQO26 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 10:28:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3F3C32079D
	for <git@vger.kernel.org>; Fri, 17 Apr 2015 10:28:58 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 17 Apr 2015 10:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=7OI4vh3BkkgjdLFvqelWwvwmiyM=; b=jPOSsN93ZOYNmbhGG6gT/c//slLk
	baoTJwCnuKUb3in8OF8KnNS3LI7Sn/ArmJC0uMGlUom5cmqrYVx6bprBzTm/f6TB
	1fuGp63fMj3UrIQ6K8c89sUtTzPUsycgyYBcNuzOhi9xTA0eutolyWnF9Jeb6M17
	kjHQDMYD9G2YOsM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7OI4vh3BkkgjdLFvqelWwvwmiy
	M=; b=NW3W4HW+NdcmH3cD/VCTfFr0iV/btWHJY2mpSoN46QTLdWS2+xDaxT7sYp
	xgu2pTCZlryFvsavrX8r1COu0Lf6J5RE+mB9wnfKD2PHA0hmmx9cj6+rnkh2EIRn
	0fXoepeOpU3C5UBt+/7lkNP9q4Tvk6Ku+OuU09NPdhHgqFCwU=
X-Sasl-enc: yV9gJU5yh9yKHWpV6QXRdzImBgjnrlTD8D0eHy0j4A1/ 1429280937
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D038DC00011;
	Fri, 17 Apr 2015 10:28:57 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc2.251.gab67463
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267358>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index f620ee4..77ac439 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -59,8 +59,8 @@ endif::git-rev-list[]
 	matches any of the given patterns are chosen (but see
 	`--all-match`).
 +
-When `--show-notes` is in effect, the message from the notes as
-if it is part of the log message.
+When `--show-notes` is in effect, the message from the notes is
+matched as if it were part of the log message.
 
 --all-match::
 	Limit the commits output to ones that match all given `--grep`,
-- 
2.4.0.rc2.251.gab67463
