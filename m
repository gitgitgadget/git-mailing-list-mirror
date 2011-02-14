From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/7] push: describe --porcelain just like commit and status
Date: Mon, 14 Feb 2011 16:10:30 +0100
Message-ID: <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp085-0002oe-8c
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1BNPNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42748 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867Ab1BNPNo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:44 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AC23A20644
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:43 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 10:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=F3uiNe2OlFp9at/PRbCQXSVAnLg=; b=WSxLZTJpL5gsj+QTdMYgp+Osf/Nh6qb0E587JY2AZ5uqEjb619CAaD9nJhQpxfX54KoxAUCDMdkfib/nqP/FPwxL83law/W4PS1MqHr3hWbj9LWXN74n/MQq0pW5ALtoXItS8+kRe2WPUM8fkeYE6VBLWYmLJJNGJkaP8wrMt6U=
X-Sasl-enc: qrRlAq3hBBTKAWQKb+UkOJLKBWYkUVmJFgU4H6hAX7Ah 1297696423
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 34A02441C19;
	Mon, 14 Feb 2011 10:13:43 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166721>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..e4ff264 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -217,7 +217,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0, "delete", &deleterefs, "delete refs"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all or --mirror)"),
 		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
-		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
+		OPT_BIT( 0,  "porcelain", &flags, "show porcelain output format", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
-- 
1.7.4.1.74.gf39475
