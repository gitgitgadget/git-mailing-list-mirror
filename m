From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Ignore git-init and git-remote
Date: Tue, 9 Jan 2007 00:27:33 -0500
Message-ID: <20070109052721.GA27927@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 06:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49WM-0007iV-ER
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXAIF1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbXAIF1f
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:27:35 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:51888 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXAIF1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:27:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id CA7841FFD296
	for <git@vger.kernel.org>; Tue,  9 Jan 2007 05:27:34 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36310>

These new commands weren't added to .gitignore.  Add them so we don't
end up with copies of them in the repo.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2904f12..6da1cdb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ git-http-fetch
 git-http-push
 git-imap-send
 git-index-pack
+git-init
 git-init-db
 git-instaweb
 git-local-fetch
@@ -92,6 +93,7 @@ git-rebase
 git-receive-pack
 git-reflog
 git-relink
+git-remote
 git-repack
 git-repo-config
 git-request-pull
-- 
1.4.4.4.g4083
