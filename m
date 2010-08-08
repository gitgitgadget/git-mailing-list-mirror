From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/git-log: Clarify --full-diff
Date: Sun,  8 Aug 2010 17:31:34 +0200
Message-ID: <4acdfd58d0ff4aa6b55dab4d4233f55c1b753b5e.1281281303.git.git@drmicha.warpmail.net>
References: <yf9ocddut4h.fsf@chiyo.mc.pp.se>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>,
	Marcus Comstedt <marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 17:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi7qk-0002vA-D9
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 17:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab0HHPbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 11:31:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57026 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751562Ab0HHPbW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 11:31:22 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 61166199883;
	Sun,  8 Aug 2010 11:31:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 08 Aug 2010 11:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=9+rRii7Y0BnESk6yV1w1cKBKDnQ=; b=MrLAZPyIQ6S33+lBX/SYOogoOUui1UYQp4oF/0utQx4Yi81W5cdbdR/mADzKjKlIwBOSCSst5R5DMHdPLu1H7tAPVpiWdU/XQ9ljlGfSgVL91bB9S/WpA2OySkHxDA4tXs/EVI/CRnRFY8XXM0n5/Fb7wB7pcJMJ1GzQarL7tF4=
X-Sasl-enc: xvuCrxt6y4o6qLQD1tblZ/Rwf6qWQ/gRuVYFYKv9f4+N 1281281480
Received: from localhost (p54858FD1.dip0.t-ipconnect.de [84.133.143.209])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8DCD84E9D2D;
	Sun,  8 Aug 2010 11:31:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
In-Reply-To: <yf9ocddut4h.fsf@chiyo.mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152917>

The current description gives the impression that "--full-diff" affects
"log -p" only.

Make it clearer that it affects all diff-based output types.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-log.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e970664..c213bdb 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -55,6 +55,9 @@ OPTIONS
 	paths.  With this, the full diff is shown for commits that touch
 	the specified paths; this means that "<path>..." limits only
 	commits, and doesn't limit diff for those commits.
++
+Note that this affects all diff-based output types, e.g. those
+produced by --stat etc.
 
 --log-size::
 	Before the log message print out its size in bytes. Intended
-- 
1.7.2.1.52.g7f7860
