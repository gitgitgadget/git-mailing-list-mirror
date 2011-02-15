From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 05/10] add: describe --patch like checkout, reset
Date: Tue, 15 Feb 2011 14:09:08 +0100
Message-ID: <01b5c355c401f327af34cf518955f87737d4a38a.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi4-0004O3-HB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab1BONM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:28 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44392 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab1BONM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:27 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9A4D0208A7;
	Tue, 15 Feb 2011 08:12:26 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 15 Feb 2011 08:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=w0Ia2gWtAmS9A7vZZVvQbTTmreQ=; b=DxxqA2CsiDylihx+qsMSp0n+ld0ypl2YmpkUQ95ZNfpxIl28u0WFYJNREqMNpETVzC2unRZ4wKPuksYrEfmv0o7EwQ+coh+al866Gtlxx4lT9TsLHn3mJIgo/TvP9IFUeCmL8GWH6CAoJW/6WsHV/arX3ePZFK5ra6nNf6gGMCE=
X-Sasl-enc: H0p6Rue7MtpULHfyZeNFHn1kOTebCAEJYUd8MD6YSrUH 1297775546
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 25A4B443C13;
	Tue, 15 Feb 2011 08:12:26 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166848>

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
1.7.4.1.74.gf39475.dirty
