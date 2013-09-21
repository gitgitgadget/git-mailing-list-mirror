From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/2] remote set-head: show long options in usage
Date: Sat, 21 Sep 2013 16:51:46 +0100
Message-ID: <1379778706-5664-3-git-send-email-philipoakley@iee.org>
References: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNPSg-0008Pe-NY
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab3IUPut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:50:49 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:21624 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979Ab3IUPus (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:50:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArwGAH6/PVJOl3GZ/2dsb2JhbABbgweuV5QSgRoXdIImAQVWIxAISTkeBhOICbpgj2UHhB4DqXODJTs
X-IPAS-Result: ArwGAH6/PVJOl3GZ/2dsb2JhbABbgweuV5QSgRoXdIImAQVWIxAISTkeBhOICbpgj2UHhB4DqXODJTs
X-IronPort-AV: E=Sophos;i="4.90,953,1371078000"; 
   d="scan'208";a="85771223"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:50:46 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235126>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index eaac3e2..4e14891 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -12,7 +12,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
-	N_("git remote set-head <name> (-a | -d | <branch>)"),
+	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
@@ -39,7 +39,7 @@ static const char * const builtin_remote_rm_usage[] = {
 };
 
 static const char * const builtin_remote_sethead_usage[] = {
-	N_("git remote set-head <name> (-a | -d | <branch>)"),
+	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
 	NULL
 };
 
-- 
1.8.1.msysgit.1
