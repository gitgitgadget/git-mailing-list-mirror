From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 3/8] git-p4: add missing newline in initial import message
Date: Sat, 19 Feb 2011 08:17:56 -0500
Message-ID: <1298121481-7005-4-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqmho-0001Jr-9y
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab1BSNSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:20 -0500
Received: from honk.padd.com ([74.3.171.149]:51178 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1BSNSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:17 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 09D7220C5;
	Sat, 19 Feb 2011 05:18:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E80CE31A35; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167274>

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-By: Tor Arvid Lund <torarvid@gmail.com>
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
1.7.4.1
