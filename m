From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] git-submodule: wrap branch option with "<>" in usage strings.
Date: Tue, 23 Oct 2012 17:00:21 -0400
Message-ID: <6332cbbfccd24f9d1ed37de424372ca354e9a4da.1351026021.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQlcC-0003Qx-5d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965428Ab2JWVCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 17:02:05 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:22644 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965121Ab2JWVCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 17:02:01 -0400
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD00GI46F6LZ60@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 16:01:56 -0500 (CDT)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 2607C67EAB6; Tue,
 23 Oct 2012 17:01:54 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.2.g09b91ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208250>

From: "W. Trevor King" <wking@tremily.us>

Use "-b <branch>" instead of "-b branch".  This brings the usage
strings in line with other options, e.g. "--reference <repository>".

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 2 +-
 git-submodule.sh                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4683bb..a65f38e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch] [-f|--force]
+'git submodule' [--quiet] add [-b <branch>] [-f|--force]
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..02f82e9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
-- 
1.8.0.2.g09b91ca
