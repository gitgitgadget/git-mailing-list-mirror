From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] RFC: add whitespace rule for no-eol-at-eof
Date: Thu,  3 Jun 2010 16:35:23 +0200
Message-ID: <5ef4da3db5914e9161edcf3933263f936ca56702.1275575236.git.git@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:36:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBWm-0005AQ-48
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab0FCOgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:36:00 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48620 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755536Ab0FCOf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:35:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6F282F8F06
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 10:35:52 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=uHi3hsDKNK+WAIIY7MPSWIBF1Ws=; b=GEwuCWKBlSaM+h3pBKMFhiPhP8sbv/4n3vFLTOkvhPZR58alIMS1gBJXnXe5zdl5Vhk4tgZbgLkUGiEpzWkn2zWgwbJewWZWRFnURs4LQ4l+amij12b6Nen5+Q+UAbxKeA4ajRuylcjq4qvPyWbFRnOW+S0zG0XLR4lRKbjGhMQ=
X-Sasl-enc: JyAvP5YFshi0ANrdvlYd+lftUu/L2BVBq0vXJzisAtOk 1275575751
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DA90B50EBF;
	Thu,  3 Jun 2010 10:35:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
In-Reply-To: <cover.1275575236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148324>

I really don't know if it's worth to do this one.

No doc so far.
Also, as it is, -no-eol-at-eof turns around the default for files but
not for symlinks.

I really don't know...

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 ws.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ws.c b/ws.c
index d7b8c33..73502c8 100644
--- a/ws.c
+++ b/ws.c
@@ -20,6 +20,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "no-eol-at-eof", WS_NO_EOL_AT_EOF, 0 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
-- 
1.7.1.351.ge2633e
