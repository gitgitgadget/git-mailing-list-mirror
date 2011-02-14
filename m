From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 6/7] commit,status: describe -u likewise
Date: Mon, 14 Feb 2011 16:10:34 +0100
Message-ID: <959cfaee441413401ddb7ad7fd29f4a98f668bec.1297695910.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp087-0002oe-VN
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab1BNPN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:56 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36980 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755584Ab1BNPNu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:50 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6F1EA203CA
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:50 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 14 Feb 2011 10:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=m18TGAHgncqHJJ/gEnrZ/r2igpk=; b=SjVItnZ+//P97/x6pRTTVbvLe5Wv6oRuub8W6yx6G/IruOhUV+T1KDofsEikwLuNhY4sRp9eoobpd6jcc6MkV0eQLjtv8XscSFrv9Wfzcm6vA31ya89BM3NF9YiMdoZ9BkxMPXXjssA5DrcDboxABAM5Rqwh/3EtpbRITpbJDRI=
X-Sasl-enc: 3XzvRVki3Bb4ZlakBC31yDdOHas8KoydVwufPjiVHjaw 1297696429
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE4A1442264;
	Mon, 14 Feb 2011 10:13:49 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166723>

They differ by one character only. Being exactly equal should help
translations.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8a534de..ef2114b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -150,7 +150,7 @@ static struct option builtin_commit_options[] = {
 		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
-	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	/* end commit contents options */
 
 	{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
-- 
1.7.4.1.74.gf39475
