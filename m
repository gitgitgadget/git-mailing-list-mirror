From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-rev-parse.txt: Document ":path" specifier
Date: Fri, 25 Jun 2010 16:32:16 +0200
Message-ID: <633f42d1967049780d66cf72552b22ae17bbbead.1277476258.git.git@drmicha.warpmail.net>
References: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 16:33:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS9xo-00009V-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab0FYOdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:33:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46277 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932087Ab0FYOc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 10:32:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 34455107A12;
	Fri, 25 Jun 2010 10:32:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 25 Jun 2010 10:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=HjPNnUY3po5le929qqZU8gNCQw8=; b=o/baiPmwT2XAcx8WbgNq7RKOve+HgsF1SIT64KjzSJq0/L/tC93OKvpBqK5nCIAA583XN5S1SGx0ajsuSwNLfsIq0CwxDDyJJ9N3WiCQhM119VC2JQaXGTzKunI+kNQhW4VCi8EJD1+X+4e8yNmKTeXzqxDuQnmsPSnv5rnRjVw=
X-Sasl-enc: WSUxqLQvgZZtMdyCFD5+vfUv8632AiTB5lM9u3dVBwzb 1277476378
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8D3DF4A57F3;
	Fri, 25 Jun 2010 10:32:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149687>

The empty treeish in ":path" means "index". Document this.

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
