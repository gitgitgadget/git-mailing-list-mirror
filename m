From: Cliff Frey <cliff@meraki.com>
Subject: [PATCH] documentation: git-config minor cleanups
Date: Sun, 17 Oct 2010 20:10:45 -0700
Message-ID: <1287371445-26134-1-git-send-email-cliff@meraki.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 05:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7gCp-0000iA-GD
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 05:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab0JRDP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 23:15:58 -0400
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38414 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751131Ab0JRDP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 23:15:58 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Oct 2010 23:15:57 EDT
Received: from source ([74.125.83.45]) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTLu77cVCuccHVRzXPOlnTVbL9bOgZUHP@postini.com; Sun, 17 Oct 2010 20:15:58 PDT
Received: by mail-gw0-f45.google.com with SMTP id 16so151850gwj.32
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 20:15:57 -0700 (PDT)
Received: by 10.236.95.9 with SMTP id o9mr6863099yhf.2.1287371448742;
        Sun, 17 Oct 2010 20:10:48 -0700 (PDT)
Received: from localhost.localdomain ([208.72.143.2])
        by mx.google.com with ESMTPS id z33sm4600975yhc.33.2010.10.17.20.10.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 20:10:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159227>

Change push.default's description to add hyphens between values and
descriptions to make the manpage easier to read.  The html version is
readable either way.

Change status.showUntrackedFiles to make item descriptions be
sentences and to use the same asciidoc format as push.default.  The
only visual change is the additions of "."

Signed-off-by: Cliff Frey <cliff@meraki.com>
---
 Documentation/config.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71ddb6c..1cd820d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1560,12 +1560,12 @@ push.default::
 	no refspec is implied by any of the options given on the command
 	line. Possible values are:
 +
-* `nothing` do not push anything.
-* `matching` push all matching branches.
+* `nothing` - do not push anything.
+* `matching` - push all matching branches.
   All branches having the same name in both ends are considered to be
   matching. This is the default.
-* `tracking` push the current branch to its upstream branch.
-* `current` push the current branch to a branch of the same name.
+* `tracking` - push the current branch to its upstream branch.
+* `current` - push the current branch to a branch of the same name.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
@@ -1765,9 +1765,9 @@ status.showUntrackedFiles::
 	the untracked files. Possible values are:
 +
 --
-	- 'no'     - Show no untracked files
-	- 'normal' - Shows untracked files and directories
-	- 'all'    - Shows also individual files in untracked directories.
+* `no` - Show no untracked files.
+* `normal` - Shows untracked files and directories.
+* `all` - Shows also individual files in untracked directories.
 --
 +
 If this variable is not specified, it defaults to 'normal'.
-- 
1.7.3.1.120.g38a18
