From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] rerere.txt: Document forget subcommand
Date: Mon,  5 Jul 2010 15:15:20 +0200
Message-ID: <4d2171a1aeb40321f5956da48f2a36e7709a8a7c.1278333908.git.git@drmicha.warpmail.net>
References: <7vljaeg9wt.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 15:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVlX1-0005Ze-IK
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 15:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab0GENQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 09:16:13 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58122 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790Ab0GENQN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 09:16:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 15BBE113EA7;
	Mon,  5 Jul 2010 09:16:12 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 05 Jul 2010 09:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=NrOpt2j2WHL7UOHmU9tBOoLxbow=; b=tKRpkutSo5Mq4LQE/Hk0qT7blQH0EqMY/cDEmzxq/5Xvg8Kf16wiNNWzM6nfH4GHdwtBMJr/d6bzPUIEXtkO2nWN73+b3GTB2MVOefZTXFTvpWdgE3GNkf0I0nLJizx79BXikEgwTcXvQh23MQGMxGqErGVmqBwwGOg8/p2VNAE=
X-Sasl-enc: Kdy0VCQTO1PCt09NZTsTEBEbkYqnmCAPJvEZVxIBCvTW 1278335771
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 710826C883;
	Mon,  5 Jul 2010 09:16:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <7vljaeg9wt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150268>

dea4562 (rerere forget path: forget recorded resolution, 2009-12-25)
introduced the forget subcommand for rerere.

Document it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This somewhat fell under all radars.

v2 takes into account suggestions by Junio and Jay.

 Documentation/git-rerere.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index acc220a..db99d47 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
-'git rerere' ['clear'|'diff'|'status'|'gc']
+'git rerere' ['clear'|'forget' [<pathspec>]|'diff'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -40,6 +40,11 @@ This resets the metadata used by rerere if a merge resolution is to be
 aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
 will automatically invoke this command.
 
+'forget' <pathspec>::
+
+This resets the conflict resolutions which rerere has recorded for the current
+conflict in <pathspec>.  The <pathspec> is optional.
+
 'diff'::
 
 This displays diffs for the current state of the resolution.  It is
-- 
1.7.1.621.g01d76
