From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Sun, 10 Feb 2013 10:10:28 -0500
Message-ID: <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YaU-0001QX-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360Ab3BJPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:17 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:59995 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab3BJPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:16 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000BCLFIBWMA0@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:00 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 919ED87926D; Sun,
 10 Feb 2013 10:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509059; bh=jijVL3j+ApiSwccS+uJGI5aWnn6qlVeM4aCOhBtey5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=NrWfxH7CfNTqEuL1rKBfUGUgMGPCQ6VVAs9lgetBTe401ONbY9Kbh0wcpgwmTSaJh
 C1IBGYtkwnZGSoiMmCCjXN4U8pbUykD2OJAKnM6JFPnmGboHAsK5upWEAjIWVp3Jm4
 IYnVoTMcHD6zL7fU36hXd6JxS7OzVxpGSpjwoNNM=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215920>

From: "W. Trevor King" <wking@tremily.us>

acd2a45 (Refuse updating the current branch in a non-bare repository
via push, 2009-02-11) changed the default to refuse such a push, but
it forgot to update the docs.

7d182f5 (Documentation: receive.denyCurrentBranch defaults to
'refuse', 2010-03-17) updated Documentation/config.txt, but forgot to
update the user manual.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 222545b..8524c08 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1988,8 +1988,10 @@ handling this case.
 Note that the target of a "push" is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
 repository that has a checked-out working tree, but the working tree
-will not be updated by the push.  This may lead to unexpected results if
-the branch you push to is the currently checked-out branch!
+will not be updated by the push.  To protect against this, pushes to
+the currently checked-out branch of a repository are denied by
+default.  See the description of the receive.denyCurrentBranch option
+in linkgit:git-config[1] for details.
 
 As with `git fetch`, you may also set up configuration options to
 save typing; so, for example, after
-- 
1.8.1.336.g94702dd
