From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/7] add: describe --patch like checkout, reset
Date: Mon, 14 Feb 2011 16:10:33 +0100
Message-ID: <569a9ad6f3392cc3a2a46375237032ce411666aa.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp087-0002oe-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab1BNPNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:51 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40563 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755232Ab1BNPNt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:49 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB321203CA
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:48 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 14 Feb 2011 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=HS1ZahMH30TPy0k1D1nAYaCFWwc=; b=L77LyAiv6wFranixzHUfojmt/RaCbhh1thGq8xpdSx5uepa5hpBIOP21WhO/BIGEn7r+5Ujvfi76klFkMAKtBorPGIXPWatEuoDfnUIPwnNWcf4eopXM/VTEOkqfmSg9fQmqz7drfPlcSUM0c9LYYK3x7EsAU8qPcLn6/lWkceY=
X-Sasl-enc: LROnYbSTmZrMs/h0gwrI7oUu8YP7WbIR/XIWi4xWal1+ 1297696428
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4710140D1AD;
	Mon, 14 Feb 2011 10:13:48 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166722>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/add.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 5f817ad..f8e51f9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -317,7 +317,7 @@ static struct option builtin_add_options[] = {
 	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
-	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "select hunks interactively"),
 	OPT_BOOLEAN('e', "edit", &edit_interactive, "edit current diff and apply"),
 	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
-- 
1.7.4.1.74.gf39475
