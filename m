From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] builtin-commit.c: add -u as short name for --untracked-files
Date: Fri, 9 May 2008 22:42:55 +0530
Message-ID: <20080509171258.6257E406A1@sita-laptop.atc.tcs.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 19:27:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuWMX-0008A8-9R
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 19:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765098AbYEIRZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765020AbYEIRZa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 13:25:30 -0400
Received: from 61.11.49.253.static-hyderabad.vsnl.net.in ([61.11.49.253]:42867
	"EHLO sita-laptop.atc.tcs.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1764761AbYEIRZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2008 13:25:29 -0400
X-Greylist: delayed 745 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2008 13:25:29 EDT
Received: by sita-laptop.atc.tcs.com (Postfix, from userid 500)
	id 6257E406A1; Fri,  9 May 2008 22:42:58 +0530 (IST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81626>

This makes the C code consistent with the documentation and the old shell
code.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 256181a..b79ff9c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -101,7 +101,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
-	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
+	OPT_BOOLEAN('u', "untracked-files", &untracked_files, "show all untracked files"),
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
-- 
1.5.5.1.178.g1f811.dirty
