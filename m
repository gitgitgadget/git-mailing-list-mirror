From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix searchbox positioning
Date: Sun, 26 Aug 2007 21:31:32 +0200
Message-ID: <20070826193131.27412.66843.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 21:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPNq8-0007Xz-37
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 21:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbXHZTbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXHZTbe
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 15:31:34 -0400
Received: from rover.dkm.cz ([62.24.64.27]:59090 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbXHZTbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 15:31:33 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id B45118B487;
	Sun, 26 Aug 2007 21:31:32 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56711>

Currently, searchbox is CSS'd to have position: absolute, which has the
unfortunate consequence that if the viewport is too small and can't fit
into the page width together with the navbar, it gets overlapped and part
of the navbar gets obscured. This makes searchbox float: right instead,
thus the navbar simply gets wrapped.

Discovered and fix pointed out by Michael Olson <mwolson@gnu.org>.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.css |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 4e93a1a..f3a468e 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -430,7 +430,7 @@ div.search {
 	font-size: 100%;
 	font-weight: normal;
 	margin: 4px 8px;
-	position: absolute;
+	float: right;
 	top: 56px;
 	right: 12px
 }
