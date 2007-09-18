From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 3/4] Mention the parameters that git-pull would need to be
	equivalent to a --track in the git-checkout docs
Date: Mon, 17 Sep 2007 20:11:21 -0500
Message-ID: <1190077881.22387.63.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:08:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRaB-0006tU-Rs
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbXIRBIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbXIRBIw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:08:52 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:19948 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbXIRBIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:08:51 -0400
Received: from [164.99.193.124] ([164.99.193.124])
	by jericho.provo.novell.com with ESMTP; Mon, 17 Sep 2007 19:08:40 -0600
In-Reply-To: <1190077493.22387.54.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58519>

To be consistent with the git-branch docs.

Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 Documentation/git-checkout.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 734928b..6f22626 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -50,7 +50,8 @@ OPTIONS
 --track::
 	When -b is given and a branch is created off a remote branch,
 	set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Set the
+	retrieve data from the remote branch, otherwise you'll have to
+	use "git pull <url>" explicitly.  Set the
 	branch.autosetupmerge configuration variable to true if you
 	want git-checkout and git-branch to always behave as if
 	'--track' were given.
-- 
1.5.2.4
