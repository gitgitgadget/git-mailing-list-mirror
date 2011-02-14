From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/7] commit,tag: use same wording for -F
Date: Mon, 14 Feb 2011 16:10:29 +0100
Message-ID: <bf5f004bd55e91e5491b0ac68237d8b98ef0c691.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp07X-0002Pc-NB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab1BNPNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39127 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391Ab1BNPNm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:42 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 027F020545
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:42 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 10:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=lhXkKxqqAEKRDZdQkXs/NUmR4DA=; b=Nn6yyyskSCuDxOnLnAI629jz39LlIeOTA0dOXJQ9KmvlTKaaSovv6KX0gc00YTGv9yYiR/lDZBeEsPkkyo3qn43seW4TgUw1ziG0rCH9HsI6q/JBR5nZ4SbVD4nj+Zei2QPMVKsPeKSrnHdcQ2Z8y04Q6wHF/2MOGIcU81Gi9/c=
X-Sasl-enc: YvB1ROSxTGgzy2kPymHylkaK8kbAo8H6gA8CDUlQrQLQ 1297696421
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 80FA4441C19;
	Mon, 14 Feb 2011 10:13:41 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166719>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c |    2 +-
 builtin/tag.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 03cff5a..8a534de 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -118,7 +118,7 @@ static struct option builtin_commit_options[] = {
 	OPT__VERBOSE(&verbose, "show diff in commit message template"),
 
 	OPT_GROUP("Commit message options"),
-	OPT_FILENAME('F', "file", &logfile, "read log from file"),
+	OPT_FILENAME('F', "file", &logfile, "read message from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_STRING(0, "date", &force_date, "DATE", "override date for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
diff --git a/builtin/tag.c b/builtin/tag.c
index aa1f87d..6408171 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -378,7 +378,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					"annotated tag, needs a message"),
 		OPT_CALLBACK('m', NULL, &msg, "msg",
 			     "message for the tag", parse_msg_arg),
-		OPT_FILENAME('F', NULL, &msgfile, "message in a file"),
+		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
-- 
1.7.4.1.74.gf39475
