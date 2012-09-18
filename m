From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 2/8] Doc: shallow clone deepens _to_ new depth
Date: Wed, 19 Sep 2012 00:25:28 +0100
Message-ID: <1348010734-664-3-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7AS-0005Mu-3F
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab2IRXZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:25:07 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25999 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903Ab2IRXYq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAMwBWVBZ8rU+/2dsb2JhbABFhSC3IYEJgn07gQIkE4gEmQmhTpILA58YhmyCZw
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="47757873"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:44 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205894>

Clarify that 'depth=' specifies the new depth from the remote's
branch tip. It does not add the depth to the existing shallow clone.
(details from pack-protocol.txt).
Clarify that tags are not fetched. (details from shallow.txt)

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..b4d6476 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -10,7 +10,8 @@
 --depth=<depth>::
 	Deepen the history of a 'shallow' repository created by
 	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
-	by the specified number of commits.
+	to the specified number of commits from the tip of each remote
+	branch history. Tags for the deepened commits are not fetched.
 
 ifndef::git-pull[]
 --dry-run::
-- 
1.7.8.msysgit.0
