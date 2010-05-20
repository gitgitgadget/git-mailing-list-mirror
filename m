From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/config: describe status.submodulesummary
Date: Thu, 20 May 2010 17:55:42 +0200
Message-ID: <8dde28deb72eb473c9177bb212647b0976fa2458.1274370897.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 17:55:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF86G-0002np-5g
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 17:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab0ETPzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 11:55:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35659 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835Ab0ETPzv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 11:55:51 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9DD3FF7BA7
	for <git@vger.kernel.org>; Thu, 20 May 2010 11:55:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 20 May 2010 11:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=Jj5BPkBjYIVDNWEka9pTiVyFeFY=; b=gen/YbWqNGknKRYQldB43rrUaIQbAxOJ04s56WeWZ33M3WApJ9x1HeKLGr68Ulf4+bHXlY5vpU2maBm4RK8DX1r9XWCacQ8pSSsdqmH6tedBvmSZ96kgtxEf7Pja5Oy0aCCKv9JWXN9GTtbPdUvHMdpP9CjQjahuD879Ys5hhGw=
X-Sasl-enc: qUW0tNRLhfGBYWOaG+1YEZrc+umUJFn1CTKID6aCeC5B 1274370950
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 149D710A4A;
	Thu, 20 May 2010 11:55:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.259.g3aef8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147396>

ac8d5af (builtin-status: submodule summary support, 2008-04-12)
intoduced this variable and described it in git-status[1].

Include this description in git-config[1], as well.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 39140ba..100ac7c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1691,6 +1691,13 @@ If this variable is not specified, it defaults to 'normal'.
 This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
 
+status.submodulesummary::
+	Defaults to false.
+	If this is set to a non zero number or true (identical to -1 or an
+	unlimited number), the submodule summary will be enabled and a
+	summary of commits for modified submodules will be shown (see
+	--summary-limit option of linkgit:git-submodule[1]).
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
-- 
1.7.1.259.g3aef8
