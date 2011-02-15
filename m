From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 08/10] Make <identifier> lowercase as per CodingGuidelines
Date: Tue, 15 Feb 2011 14:09:11 +0100
Message-ID: <c3d06219aaea4f0b08aeef8fa2ef360939476a8e.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKj4-00053u-PA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab1BONMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:35 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60398 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396Ab1BONMb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:31 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 945B5208A3;
	Tue, 15 Feb 2011 08:12:31 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 08:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=VJiHTuY3S3KH6TmUXSymNn6jJxU=; b=HJXD+J2D8FyqlR/BIGk9lH4LqV+DkYeHSOt7GEX4VShtaovV9sHwaAKvpiO3zCeQ8OrS0k0V6qEBOqOtNV69OmhH7PTN0KV4t3XylQ603xlj+nP3QRBL3VDd4PwVYXYKrKD+KgpbWejOYH8h3x7u16xutsnKAN9PVyEeJMotxAM=
X-Sasl-enc: MR6u6lc4Z8Nz56qBZRUDJoQGFzjP25GKWHA/S0dRenEP 1297775551
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20B1E405B7E;
	Tue, 15 Feb 2011 08:12:31 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166853>

parse-options part

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 parse-options.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 31ec5d2..d1b12fe 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -141,7 +141,7 @@ struct option {
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
-				       "FILE", (h) }
+				       "file", (h) }
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
-- 
1.7.4.1.74.gf39475.dirty
