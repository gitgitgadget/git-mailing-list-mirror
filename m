From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 1/4] Documentation: minor grammatical fixes in git-archive.txt.
Date: Mon, 16 Mar 2009 23:16:14 -0700
Message-ID: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 17 07:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjSfC-0004Lb-JN
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240AbZCQGSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076AbZCQGSt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:18:49 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:52011 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbZCQGSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:18:48 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 9F188488008;
	Mon, 16 Mar 2009 23:18:45 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 5ECCC38E755B;
	Mon, 16 Mar 2009 23:18:45 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id E93F417A4B; Mon, 16 Mar 2009 23:16:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113421>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-archive.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 0eeefe0..c1adf59 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -23,7 +23,7 @@ prepended to the filenames in the archive.
 
 'git-archive' behaves differently when given a tree ID versus when
 given a commit ID or tag ID.  In the first case the current time is
-used as modification time of each file in the archive.  In the latter
+used as the modification time of each file in the archive.  In the latter
 case the commit time as recorded in the referenced commit object is
 used instead.  Additionally the commit ID is stored in a global
 extended pax header if the tar format is used; it can be extracted
@@ -52,11 +52,11 @@ OPTIONS
 	Write the archive to <file> instead of stdout.
 
 <extra>::
-	This can be any options that the archiver backend understand.
+	This can be any options that the archiver backend understands.
 	See next section.
 
 --remote=<repo>::
-	Instead of making a tar archive from local repository,
+	Instead of making a tar archive from the local repository,
 	retrieve a tar archive from a remote repository.
 
 --exec=<git-upload-archive>::
@@ -109,7 +109,7 @@ EXAMPLES
 git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
 
 	Create a tar archive that contains the contents of the
-	latest commit on the current branch, and extracts it in
+	latest commit on the current branch, and extract it in the
 	`/var/tmp/junk` directory.
 
 git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
-- 
1.6.2.1
