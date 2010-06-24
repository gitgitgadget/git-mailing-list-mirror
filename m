From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-rev-parse.txt: Document ":path" specifier
Date: Thu, 24 Jun 2010 15:02:27 +0200
Message-ID: <2f6ddf1fa551acf6074140865fbc2940ab45ed83.1277384506.git.git@drmicha.warpmail.net>
References: <4C2355EF.7030604@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 15:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORm5M-0005Z4-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0FXNDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 09:03:10 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53728 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754810Ab0FXNDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 09:03:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0B4F3107337;
	Thu, 24 Jun 2010 09:03:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 24 Jun 2010 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=tHBP8InpumQS9lxaNdhCNXh2WAs=; b=BoeZuKkmOg4flrt7fpZnjCDZUg12ks4s4O6Mj1AVCFY4/TFLyKOwaBQMZFlb4Tdvnnes/JXq+wFnbjTiXZRYcrSwCmjAFjXFMWpcriXbPazKR0odbyKbEQvJQN3HCmImY9YrdwITiN+TOgCPCZ8LtteWv71zo94i8OKx2jfFImY=
X-Sasl-enc: gz0iquwW0h8E38wMOiWBU+p93rQnE4TCxTK9Wmc4rN/Z 1277384588
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4364C4BB713;
	Thu, 24 Jun 2010 09:03:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <4C2355EF.7030604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149590>

The empty treeish in ":path" means "index", not "HEAD" like in probably
every other place.

Don't even try to change this, but at least document it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-parse.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8db600f..f964de4 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -290,8 +290,9 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   followed by something else than '!' is reserved for now.
 
 * A suffix ':' followed by a path; this names the blob or tree
-  at the given path in the tree-ish object named by the part
-  before the colon.
+  at the given path in the tree-ish object named by the ref
+  before the colon. An empty ref before ':' denotes the content
+  recorded in the index at the given path.
 
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
-- 
1.7.1.621.g01d76
