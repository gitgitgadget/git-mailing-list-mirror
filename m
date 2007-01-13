From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git-remote: no longer silent on unknown commands.
Date: Sat, 13 Jan 2007 22:55:21 +1100
Message-ID: <45A8C8A9.2030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 13 12:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5hUL-0001cx-LV
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 12:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbXAMLzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 06:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXAMLzh
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 06:55:37 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:50850 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964785AbXAMLzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 06:55:36 -0500
Received: from [220.233.69.95] (helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1H5hTn-0004p1-3s
	for git@vger.kernel.org; Sat, 13 Jan 2007 22:55:34 +1100
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36751>



Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git-remote.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 059c141..fc055b6 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -274,4 +274,9 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2]);
 }
-
+else {
+	print STDERR "Usage: git remote\n";
+	print STDERR "       git remote add <name> <url>\n";
+	print STDERR "       git remote show <name>\n";
+	exit(1);
+}
-- 
1.5.0.rc1
