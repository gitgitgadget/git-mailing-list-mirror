From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-shortlog.txt: fix example about .mailmap
Date: Fri, 30 Jan 2009 17:55:24 +0100
Message-ID: <200901301755.24662.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 21:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT0Az-0005NE-7a
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbZA3Ujz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbZA3Ujz
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:39:55 -0500
Received: from smtp.katamail.com ([62.149.157.154]:46792 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753228AbZA3Ujz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:39:55 -0500
Received: (qmail 22030 invoked by uid 89); 30 Jan 2009 20:39:45 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host193-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.193)
  by smtp2-pc with SMTP; 30 Jan 2009 20:39:44 -0000
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107872>

In the example, Joe Developer has <joe@example.com> as his email,
but in the .mailmap is <joe@random.com>. Use example.com instead.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/git-shortlog.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 8f7c0e2..498bd28 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -82,7 +82,7 @@ her family name fully spelled out, a proper `.mailmap` file would look like:
 # Note how we don't need an entry for <jane@laptop.(none)>, because the
 # real name of that author is correct already, and coalesced directly.
 Jane Doe <jane@desktop.(none)>
-Joe R. Developer <joe@random.com>
+Joe R. Developer <joe@example.com>
 ------------
 
 Author
-- 
1.6.1.20.g0ddd
