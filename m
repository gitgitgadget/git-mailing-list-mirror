From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Ignore section 5 man pages
Date: Mon, 23 Apr 2007 19:50:03 -0400
Message-ID: <20070423235003.GA29849@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 01:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8IO-0001wF-69
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXDWXuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbXDWXuI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:50:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59332 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964821AbXDWXuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:50:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id E8DB61FFC023
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 23:50:05 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45381>

We now have a gitattributes(5) file, so let git ignore that just like
all the other man pages.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Documentation/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index b98d21e..d067481 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,6 +1,7 @@
 *.xml
 *.html
 *.1
+*.5
 *.7
 *.made
 howto-index.txt
-- 
1.5.2.rc0.1.g2cc31
