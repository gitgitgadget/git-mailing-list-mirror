From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 1/2] Doc: remote set-head long options
Date: Sat, 21 Sep 2013 16:51:45 +0100
Message-ID: <1379778706-5664-2-git-send-email-philipoakley@iee.org>
References: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNPSN-0007nH-Vj
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab3IUPur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:50:47 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:46084 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab3IUPuq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:50:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArwGAEe/PVJOl3GZ/2dsb2JhbABbgweuV5QSgRoXdIImAQVWIxAISTkeBhOICbpgj2UHhB4DqXODJTs
X-IPAS-Result: ArwGAEe/PVJOl3GZ/2dsb2JhbABbgweuV5QSgRoXdIImAQVWIxAISTkeBhOICbpgj2UHhB4DqXODJTs
X-IronPort-AV: E=Sophos;i="4.90,952,1371078000"; 
   d="scan'208";a="441825693"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:50:45 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235125>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-remote.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9c3e3bf..2507c8b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
-'git remote set-head' <name> (-a | -d | <branch>)
+'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
@@ -101,9 +101,9 @@ branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
-With `-d`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
+With `-d` or `--delete`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
 +
-With `-a`, the remote is queried to determine its `HEAD`, then the
+With `-a` or `--auto`, the remote is queried to determine its `HEAD`, then the
 symbolic-ref `refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
 `HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
 the symbolic-ref `refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
-- 
1.8.1.msysgit.1
