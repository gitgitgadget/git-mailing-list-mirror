From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] grep.txt: document pathspec for --no-index
Date: Fri, 11 Feb 2011 16:06:47 +0100
Message-ID: <7150921343449bab0c43401ad204f090c111d7f0.1297436625.git.git@drmicha.warpmail.net>
References: <4D55500B.1070603@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 16:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnudD-0003EV-70
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 16:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab1BKPJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 10:09:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46128 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756617Ab1BKPJw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 10:09:52 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EB94D2040F;
	Fri, 11 Feb 2011 10:09:51 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 11 Feb 2011 10:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=EQdxWpHfVLG8Ufh3NlbFZzy9aDM=; b=Iq5wsbd5QAhQgXVOJdWZM4S6mUJ6HD+uSUl0LiBJtJSE8JXlOBkPigj1cCiiQxYfUsyZ2REymx4LXJ1mR2A1BS0Hy9RF7aOK8fZPaAiZeClkK+vFX7JQ5O6fNgivMPnUy4wvmnNnIl3W+kQvdUfUfxckpEiWIHA4XgdedZgjB2g=
X-Sasl-enc: OFTywuo60Zejk/U3BRTUg9ZFYxUhVxTextaXDpBoWq1o 1297436991
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8064E4444D2;
	Fri, 11 Feb 2011 10:09:51 -0500 (EST)
X-Mailer: git-send-email 1.7.4.91.g3d0bb
In-Reply-To: <4D55500B.1070603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166560>

because it allows leading path match only, no globs.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-grep.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dab0a78..ef01a57 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -186,7 +186,8 @@ OPTIONS
 
 <pathspec>...::
 	If given, limit the search to paths matching at least one pattern.
-	Both leading paths match and glob(7) patterns are supported.
+	Both leading paths match and glob(7) patterns are supported
+	unless `--no-index` is used, which supports only the former.
 
 Examples
 --------
-- 
1.7.4.91.g3d0bb
