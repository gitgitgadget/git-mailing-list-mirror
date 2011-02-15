From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 02/10] commit,status: describe --porcelain just like push
Date: Tue, 15 Feb 2011 14:09:05 +0100
Message-ID: <63efeb23823550448978cf9adb2ee9fdc6469877.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi3-0004O3-FD
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab1BONMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33508 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466Ab1BONMV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:21 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 794052054B;
	Tue, 15 Feb 2011 08:12:21 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 15 Feb 2011 08:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=/dLr/kyDDqecH9v9eTX7p4dZWbU=; b=h7fGuEYeL1IhW+1OASIQBUk6OjZ8KswXl8o4cOhhc6UafgYytbtAKePltJxlJfNY9y+Y6LKX4oTZwbP6itLo9rTSs1RKPLfAbprM1M62w+bAODB3/iBXx6L7ycUHBwo2JXWVrGGtJGIkABgp26JLFTti5Z4nKwClKr29yUhBq8Y=
X-Sasl-enc: YRH8S8Vn16xKi461bacIkXhpiuK2B7TxrrItyba061bp 1297775541
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 03CEA4009D2;
	Tue, 15 Feb 2011 08:12:20 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166845>

Push has the clearer description, so take that one for all.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8a534de..0245d9f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -145,7 +145,7 @@ static struct option builtin_commit_options[] = {
 		    STATUS_FORMAT_SHORT),
 	OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
 	OPT_SET_INT(0, "porcelain", &status_format,
-		    "show porcelain output format", STATUS_FORMAT_PORCELAIN),
+		    "machine-readable output", STATUS_FORMAT_PORCELAIN),
 	OPT_BOOLEAN('z', "null", &null_termination,
 		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
@@ -1092,7 +1092,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('b', "branch", &status_show_branch,
 			    "show branch information"),
 		OPT_SET_INT(0, "porcelain", &status_format,
-			    "show porcelain output format",
+			    "machine-readable output",
 			    STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &null_termination,
 			    "terminate entries with NUL"),
-- 
1.7.4.1.74.gf39475.dirty
