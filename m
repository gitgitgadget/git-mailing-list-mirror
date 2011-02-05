From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/8] git-p4: add missing newline in initial import message
Date: Sat, 5 Feb 2011 17:51:55 -0500
Message-ID: <20110205225155.GD30963@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlqzD-0006Nh-9U
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab1BEWwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:52:06 -0500
Received: from honk.padd.com ([74.3.171.149]:33458 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab1BEWwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:52:05 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id A873AEF;
	Sat,  5 Feb 2011 14:52:03 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C673831ADE; Sat,  5 Feb 2011 17:51:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110205224848.GA30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166123>

The commit message looks wrong without the newline.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2fefea4..d2ba215 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1429,7 +1429,7 @@ class P4Sync(Command):
         print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
 
         details = { "user" : "git perforce import user", "time" : int(time.time()) }
-        details["desc"] = ("Initial import of %s from the state at revision %s"
+        details["desc"] = ("Initial import of %s from the state at revision %s\n"
                            % (' '.join(self.depotPaths), revision))
         details["change"] = revision
         newestRevision = 0
-- 
1.7.2.3
