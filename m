From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 03/10] clone,init: describe --template using the same wording
Date: Tue, 15 Feb 2011 14:09:06 +0100
Message-ID: <731361315447fab6e18f5ab582bca97de479019e.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi3-0004O3-Ve
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab1BONM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50934 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1BONMX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:23 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 35E6320847;
	Tue, 15 Feb 2011 08:12:23 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 08:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=HUoQ3gniumGaDpwEfYk2EwtsFHk=; b=cNan9SclTOiTFerfwzeT2/omngL3K7O7gmlNRL7lrvxEtfnboqljJbtwu+fRNT5yGvbnKT47r/6Pn3bk5nYLovtt6aG0iiU7B+rIslPTwJiiw3boFNV2Z4mcbdwDarzNp4EeSXP4r29/pCvnwvXPQ29Upm13IPoYIqEOJEqaO3E=
X-Sasl-enc: R+NWd8okVS43tf8DoSOTwIDTnvevNBRb3Mk25atbN6Sf 1297775542
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B27B7443B97;
	Tue, 15 Feb 2011 08:12:22 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166846>

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
1.7.4.1.74.gf39475.dirty
