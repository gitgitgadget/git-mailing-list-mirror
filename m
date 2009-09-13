From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCH] git-commit: Only describe --dry-run once
Date: Sun, 13 Sep 2009 15:35:05 +0200
Message-ID: <1252848905-19115-1-git-send-email-heipei@hackvalue.de>
Cc: Johannes Gilger <heipei@hackvalue.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmpFB-0001gq-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 15:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZIMNev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 09:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbZIMNeu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 09:34:50 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:50276 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZIMNeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 09:34:50 -0400
Received: from u-4-240.vpn.rwth-aachen.de ([137.226.100.240]:59936 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MmpE5-00058a-RP; Sun, 13 Sep 2009 15:34:45 +0200
X-Mailer: git-send-email 1.6.5.rc1
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.100.240
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128361>

Junio described the option in 3a5d13a and then again in 60c2993.
Also fix a small typo in the documentation for git-clone.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
 Documentation/git-clone.txt  |    2 +-
 Documentation/git-commit.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f23100e..aacf4fd 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -130,7 +130,7 @@ objects from the source repository into a pack in the cloned repository.
 --branch <name>::
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repositoroy's HEAD, point to <name> branch
+	to by the cloned repository's HEAD, point to <name> branch
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 64f94cf..b2817b4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
+'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--dry-run]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
-- 
1.6.5.rc1
