From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/2] push: add '--delete' flag to synopsis
Date: Wed, 16 Dec 2015 09:16:51 +0100
Message-ID: <1450253812-17230-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 09:17:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a97Go-00051h-IL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 09:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbbLPIRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 03:17:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54751 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbbLPIRE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 03:17:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1476720CB9
	for <git@vger.kernel.org>; Wed, 16 Dec 2015 03:17:03 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 16 Dec 2015 03:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=U/lVjJongDX0p4wkzW5hIhdOHj
	k=; b=itjNu6Tj9XqDImBFim4ezkE/6P8U1qQXcuTbO5csfs1sA8UjKyMG2pWV2H
	Sx+SCwy9daoLqv55WhjSx8/cKEfjbJLrl2OYnG+GhbxLAFndfWqlCUA3L6YvCVkP
	x27bhor7YDNdItJrNXPaL8nqEaW0bC5C4NTGLvSO48LNX8pFs=
X-Sasl-enc: XGB2srTr/eHWtrfRY7NX+eSm6pNY/6zh5ZGIxYs6sCPA 1450253822
Received: from localhost (x5ce0fb64.dyn.telefonica.de [92.224.251.100])
	by mail.messagingengine.com (Postfix) with ESMTPA id 83750C016F2;
	Wed, 16 Dec 2015 03:17:02 -0500 (EST)
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282543>

The delete flag is not mentioned in the synopsis of `git-push`.
Add the flag to make it more discoverable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Only change to version 1 [1] is a slightly altered commit message
of the second commit. Previously, it suggested that '--delete' is
the only way to delete a remote ref with `git-push`, while there
is also `git push origin :ref`.

[1]: http://article.gmane.org/gmane.comp.version-control.git/282364

 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 85a4d7d..e830c08 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [--delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream]
 	   [--[no-]signed|--sign=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
-- 
2.6.4
