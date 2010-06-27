From: Robert Spanton <rspanton@zepler.net>
Subject: [PATCH] Clarify that git-cherry-pick applies patches to HEAD
Date: Sun, 27 Jun 2010 14:52:25 +0100
Message-ID: <1277646745.13370.711.camel@zarniwoop.blob>
Reply-To: rspanton@zepler.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 27 15:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSsHn-00049G-MY
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 15:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab0F0Nwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 09:52:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55126 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab0F0Nwe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 09:52:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7B0E0FA9BC;
	Sun, 27 Jun 2010 09:52:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 27 Jun 2010 09:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:reply-to:to:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=Z42aEm6EI0+8PdSQ+G0/EEo2l+M=; b=T/0s4VSb0CYLusW2SyjHKqYjFbiVI7/TTFKq4MBn2WmPzrmGx+rNWJZRsvLi58oX9JpctQwnLIirJ6ggm6oOA8n/W12GREBAeuf9h7Dbm/9+ko5Tdi4fA+mDO2Z5meTL9/bzkaPht+tktk5EkhDNJqz/hOmXATXUNt70WOnOhJc=
X-Sasl-enc: E0n5/GqZfsSBZUXtzOc/ILbVnbArKHHoz3aRPPPvga6k 1277646752
Received: from [192.168.0.11] (87-194-128-93.bethere.co.uk [87.194.128.93])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DBC764E042D;
	Sun, 27 Jun 2010 09:52:31 -0400 (EDT)
X-Mailer: Evolution 2.30.1.2 (2.30.1.2-8.fc13) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149793>

Change the description of cherry-pick to state that the given commits
are applied to the current HEAD.  It was unclear exactly where
cherry-pick ends up sticking the given commits.

Signed-off-by: Robert Spanton <rspanton@zepler.net>
---
 Documentation/git-cherry-pick.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bcb4c75..2d52445 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -13,8 +13,9 @@ DESCRIPTION
 -----------
 
 Given one or more existing commits, apply the change each one
-introduces, recording a new commit for each.  This requires your
-working tree to be clean (no modifications from the HEAD commit).
+introduces to the current HEAD, recording a new commit for each.
+This requires your working tree to be clean (no modifications from
+the HEAD commit).
 
 OPTIONS
 -------
-- 
1.7.0.1
