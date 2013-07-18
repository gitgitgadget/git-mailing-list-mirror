From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH v2 2/2] Documentation: fix git-prune example usage
Date: Thu, 18 Jul 2013 09:53:55 -0700
Message-ID: <707B830A-C628-432A-9B89-2D39EA2927CC@JonathonMah.com>
References: <0A7070DB-118A-44B2-A554-246459D0CEF3@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 18:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzrT3-00016V-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 18:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108Ab3GRQyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 12:54:09 -0400
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:49321 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757578Ab3GRQyI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 12:54:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvkTAIYc6FEyiIWrPGdsb2JhbAANTYtLuQOBKAMBAQEBOIJaAQEEOk9RQxQGE6wWkj6OS4FLgw5uA4koozSBSA
Received: from c-50-136-133-171.hsd1.ca.comcast.net (HELO [192.168.120.50]) ([50.136.133.171])
  by ipmail04.adl6.internode.on.net with ESMTP; 19 Jul 2013 02:23:55 +0930
In-Reply-To: <0A7070DB-118A-44B2-A554-246459D0CEF3@JonathonMah.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230702>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 Documentation/git-prune.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 80d01b0..bf82410 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -59,7 +59,7 @@ borrows from your repository via its
 `.git/objects/info/alternates`:
 
 ------------
-$ git prune $(cd ../another && $(git rev-parse --all))
+$ git prune $(cd ../another && git rev-parse --all)
 ------------
 
 Notes
-- 
1.8.3.3.754.g9c3c367



Jonathon Mah
me@JonathonMah.com
