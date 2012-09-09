From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 09/12] git p4: accept -v for --verbose
Date: Sun,  9 Sep 2012 16:16:10 -0400
Message-ID: <1347221773-12773-10-git-send-email-pw@padd.com>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 22:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnyW-0005P6-R7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 22:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab2IIUTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 16:19:18 -0400
Received: from honk.padd.com ([74.3.171.149]:53018 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2IIUTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 16:19:17 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id D821A5AF2;
	Sun,  9 Sep 2012 13:19:16 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 72F0A32112; Sun,  9 Sep 2012 16:19:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.176.gc22bed1
In-Reply-To: <1347221773-12773-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205099>

The short form "-v" is common in many git commands as an
alias for "--verbose".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt | 2 +-
 git-p4.py                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8228f33..4b03356 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -163,7 +163,7 @@ All commands except clone accept these options.
 --git-dir <dir>::
 	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
 
---verbose::
+--verbose, -v::
 	Provide more progress information.
 
 Sync options
diff --git a/git-p4.py b/git-p4.py
index 60012bc..464f64d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3028,7 +3028,7 @@ def main():
 
     args = sys.argv[2:]
 
-    options.append(optparse.make_option("--verbose", dest="verbose", action="store_true"))
+    options.append(optparse.make_option("--verbose", "-v", dest="verbose", action="store_true"))
     if cmd.needsGit:
         options.append(optparse.make_option("--git-dir", dest="gitdir"))
 
-- 
1.7.12.rc2.111.g96f7c73
