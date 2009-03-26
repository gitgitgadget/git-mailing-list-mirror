From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH] Documentation: Remove spurious uses of "you" in git-bisect.txt.
Date: Wed, 25 Mar 2009 20:44:44 -0700
Message-ID: <1238039084-4810-1-git-send-email-dmellor@whistlingcat.com>
References: <20090324220201.GM19389@fieldses.org>
Cc: git@vger.kernel.org, bfields@fieldses.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 26 04:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgXq-00078E-7c
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbZCZDor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbZCZDor
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:44:47 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:47247 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZCZDoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:44:46 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id E568E488006;
	Wed, 25 Mar 2009 20:44:44 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id A357838E7584;
	Wed, 25 Mar 2009 20:44:44 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 6606C17A4B; Wed, 25 Mar 2009 20:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <20090324220201.GM19389@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114718>

These were added by accident in a42dea3.

This patch also rewords the description of how ranges of commits can be
skipped.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-bisect.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index a356a2b..ffc02c7 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -151,7 +151,7 @@ $ git reset --hard HEAD~3		# try 3 revisions before what
 					# was suggested
 ------------
 
-Then you compile and test the chosen revision. Afterwards you mark
+Then compile and test the chosen revision, and afterwards mark
 the revision as good or bad in the usual manner.
 
 Bisect skip
@@ -175,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. For example:
 $ git bisect skip v2.5..v2.6
 ------------
 
-This tells the bisect process that no commit between `v2.5` excluded and
-`v2.6` included should be tested.
+This tells the bisect process that no commit after `v2.5`, up to and
+including `v2.6`, should be tested.
 
 Note that if you also want to skip the first commit of the range you
 would issue the command:
-- 
1.6.2.1
