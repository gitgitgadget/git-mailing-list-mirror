From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 06/10] commit,status: describe -u likewise
Date: Tue, 15 Feb 2011 14:09:09 +0100
Message-ID: <992cdae518224eb1f26eac7c4941b850fa203ec2.1297775122.git.git@drmicha.warpmail.net>
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
	id 1PpKi5-0004O3-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab1BONMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:32 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50922 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1BONM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:28 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F1A220568;
	Tue, 15 Feb 2011 08:12:28 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 08:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=KdR+OMI52CMG/n/plwWe0g9n5A8=; b=uIHdSGXpNAu+DnhXKCBGQkbjIjp/cGorHHjdDDNCfajDxP8y/vTbnNLYjt98HvRFDcJIIZUhktSynZP5TNHf8Hh/Oad0VhelJkazxJQy/ooXqCXPveTqdrHw+zzB2Mg8wcx+lgbH4phc7B0qQt0i27rrwXRLfraMochm7nrveTg=
X-Sasl-enc: hJpHnRb9yrP5xmexp+5H/pAUQRODLCOMPEfYdri8HFTt 1297775547
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CDCDB405952;
	Tue, 15 Feb 2011 08:12:27 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166849>

They differ by one character only. Being exactly equal should help
translations.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0090571..d7f55e3 100644
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
1.7.4.1.74.gf39475.dirty
