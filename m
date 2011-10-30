From: Mark Dominus <mjd@plover.com>
Subject: [PATCH] document 'T' status from git-status
Date: Sat, 29 Oct 2011 20:06:44 -0400
Message-ID: <1319933204-21587-1-git-send-email-mjd@plover.com>
Cc: Mark Dominus <mjd@icgroup.com>, Mark Dominus <mjd@plover.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 30 02:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKJ4A-000420-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 02:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab1J3APy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Oct 2011 20:15:54 -0400
Received: from lab.pobox.com ([74.115.168.32]:58249 "EHLO lab.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547Ab1J3APx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 20:15:53 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Oct 2011 20:15:53 EDT
Received: by lab.pobox.com (Postfix, from userid 2616)
	id 5193645C46; Sat, 29 Oct 2011 20:06:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184459>

From: Mark Dominus <mjd@icgroup.com>

Signed-off-by: Mark Dominus <mjd@plover.com>
---
 Documentation/git-status.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 3d51717..e7fc5c3 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -122,6 +122,8 @@ codes can be interpreted as follows:
 * 'R' = renamed
 * 'C' = copied
 * 'U' = updated but unmerged
+* 'T' = file type changed
+  (typically from plain file to symlink, or vice versa)
 
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.
@@ -134,9 +136,11 @@ in which case `XY` are `!!`.
     D         [ M]   deleted from index
     R        [ MD]   renamed in index
     C        [ MD]   copied in index
+    T        [ MD]   file type changed in index
     [MARC]           index and work tree matches
     [ MARC]     M    work tree changed since index
     [ MARC]     D    deleted in work tree
+    [ MARC]     T    file type changed in work tree
     -------------------------------------------------
     D           D    unmerged, both deleted
     A           U    unmerged, added by us
-- 
1.7.7.dirty
