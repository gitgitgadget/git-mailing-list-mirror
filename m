From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/7] clone,init: describe --template using the same wording
Date: Mon, 14 Feb 2011 16:10:31 +0100
Message-ID: <4f337165179d071d7c54b442b7d3dd72406239b2.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp086-0002oe-AP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab1BNPNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57185 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755229Ab1BNPNp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:45 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D8FA208B1
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:45 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Feb 2011 10:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=sv7RKV9r8k4A9nFKVlU7qWHF9h4=; b=FUCMsPgJ2qr7mbNy/JyNj+uS1OaXAQuVrB8S0JUt8Glx41Mz5mZUngAJZf/rcaipQeJpdyagyqeukwOBO2wj+uNEZclUmZnW1YzYiQPDeBE7EV0AUvxMA/bH/u2ALcbLaUg0jIWytdBiDUUS2MH7HYLiwZgU9VLlj8evPx4clZI=
X-Sasl-enc: NO5p19DTArgmw/dyGiR7STdHkQK+tSpbPLTsvSFyysSn 1297696424
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DCB5B40D1A8;
	Mon, 14 Feb 2011 10:13:44 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166720>

This also corrects a wrong description for clone.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/clone.c   |    4 ++--
 builtin/init-db.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 82a6938..60d9a64 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -68,8 +68,8 @@ static struct option builtin_clone_options[] = {
 		    "initialize submodules in the clone"),
 	OPT_BOOLEAN(0, "recurse-submodules", &option_recursive,
 		    "initialize submodules in the clone"),
-	OPT_STRING(0, "template", &option_template, "path",
-		   "path the template repository"),
+	OPT_STRING(0, "template", &option_template, "template-directory",
+		   "directory from which templates will be used"),
 	OPT_STRING(0, "reference", &option_reference, "repo",
 		   "reference repository"),
 	OPT_STRING('o', "origin", &option_origin, "branch",
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e3af9ea..4f5348e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -419,7 +419,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, "template-directory",
-				"provide the directory from which templates will be used"),
+				"directory from which templates will be used"),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
 				"create a bare repository", 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-- 
1.7.4.1.74.gf39475
