From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] Documentation/git-reflog: Fix formatting of command lists
Date: Sun, 21 Mar 2010 18:30:16 +0100
Message-ID: <5f1de63293499e3f8362bfd0c6bf93046d771077.1269192495.git.git@drmicha.warpmail.net>
References: <cover.1269192495.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 18:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOyl-00035z-Ct
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab0CURaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:30:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53331 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752347Ab0CURaF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 13:30:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D10CFE9C58;
	Sun, 21 Mar 2010 13:30:04 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sun, 21 Mar 2010 13:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=5xQwR6kbjHdxGj5h+gmBUV7RiP0=; b=C7dYGwse3xmMr4zIEeN85R1OXbmyJG1y4ORlwItNSSJOMtaVmpj14vRfZJLzZdk1eM23O9cuykGxAN7QIeKCuV/bDJl/qditb5xbjn1FchvE/mLJv3Q/tG+JXzA37f2wQv25aBzxOb/HwHU9TH8noiIiK7nG1qYg/jkwig9Je4o=
X-Sasl-enc: b9OcLL/6+nl4dxDtCB9kN7b6Yc45Jh365V7aLotBuED5 1269192604
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0729D3FBE0;
	Sun, 21 Mar 2010 13:30:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
In-Reply-To: <cover.1269192495.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142841>

A misplaced list continuation mark appears literally in the
rendered doc. Fix this by removing it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reflog.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 802bd57..4eaa62b 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -18,9 +18,7 @@ depending on the subcommand:
 [verse]
 'git reflog expire' [--dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
-+
 'git reflog delete' ref@\{specifier\}...
-+
 'git reflog' ['show'] [log-options] [<ref>]
 
 Reflog is a mechanism to record when the tip of branches are
-- 
1.7.0.2.358.g30511
