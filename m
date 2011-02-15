From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 01/10] commit,tag: use same wording for -F
Date: Tue, 15 Feb 2011 14:09:04 +0100
Message-ID: <bf5f004bd55e91e5491b0ac68237d8b98ef0c691.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKhd-00043h-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab1BONMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44241 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1BONMU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:20 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C67B420347;
	Tue, 15 Feb 2011 08:12:19 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 08:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=QWpdPwyrWsM5gNgk0EpFO99/+J4=; b=F7m8nYEFnpErZL5pSf897ZXWGBRerNl5q1uhjnlQ735HQ9z2ztaBiaotvg5Fd6mGM1/AwumLDeKyBtVe1IQjI6uGEZHfERgq6UTOBqZ1VdPQDiRJ1Y99MJLSB2vipZBnOgb3QWXrx0fmBiSto9Tl+BvRcHjjXkQ5c3Ayu+BhxrY=
X-Sasl-enc: ADq8RLTsOQ6c3X3VBiW/BLOmR1FS4FzPd1jOaIRT3Yjw 1297775539
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4EBA1443B97;
	Tue, 15 Feb 2011 08:12:19 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166844>

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
1.7.4.1.74.gf39475.dirty
