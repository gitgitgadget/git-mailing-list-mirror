From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 02/11] log: name --debug-grep option like in the commit message
Date: Fri, 14 Sep 2012 11:46:34 +0200
Message-ID: <c9a4c5337142ff53105dfc7346f0fecfbb6bbf30.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUO-00076D-0h
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2INJqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40835 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753347Ab2INJqt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:49 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CFCFE20943;
	Fri, 14 Sep 2012 05:46:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 14 Sep 2012 05:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=qO
	3QH7XodPmKfQ57UP8g36WGnQI=; b=Jl5LebJCNJifaD7X/QKVdBSEV4yF423ZJE
	0/7EFVCG8V0RPpyERmdIiG96sqyk8QRssluzJ6uxyCbe03osb6PwFIaaHmyrLfd1
	fSlVYB3Pnc7icukY3VNx6pEHcowP+T08PWTltAdYcjTxEyg8jVwjVaYFOgQ4aUtR
	DNJ6j/1a8=
X-Sasl-enc: HrsxpFoJrzX1KtmXEzePQdwAt3ECISMYmFPO/0nGEYpQ 1347616008
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7527E48260B;
	Fri, 14 Sep 2012 05:46:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205468>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 90376e8..fad8040 100644
--- a/revision.c
+++ b/revision.c
@@ -1578,7 +1578,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
-	} else if (!strcmp(arg, "--grep-debug")) {
+	} else if (!strcmp(arg, "--debug-grep")) {
 		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
-- 
1.7.12.592.g41e7905
