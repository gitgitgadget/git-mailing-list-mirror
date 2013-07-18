From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH 2/2] Documentation: fix git-prune example usage
Date: Thu, 18 Jul 2013 00:12:35 -0700
Message-ID: <E676323F-CEDD-4072-B4FF-737143354401@JonathonMah.com>
References: <19D1767A-4C36-4A89-A9BB-9FED33289CD9@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 09:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UziOQ-0003QB-TX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 09:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354Ab3GRHMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 03:12:47 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:51852 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087Ab3GRHMq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 03:12:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvUWADqT51EyiIWrPGdsb2JhbAANTYtKuH+BKAMBAQEBOIJZAQEEOk9RQxQGE6wVkkSONoFLg3sDiSejNIFI
Received: from c-50-136-133-171.hsd1.ca.comcast.net (HELO [192.168.120.50]) ([50.136.133.171])
  by ipmail07.adl2.internode.on.net with ESMTP; 18 Jul 2013 16:42:34 +0930
In-Reply-To: <19D1767A-4C36-4A89-A9BB-9FED33289CD9@JonathonMah.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230679>

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
