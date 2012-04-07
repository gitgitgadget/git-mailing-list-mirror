From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] remote: update builtin usage
Date: Sat, 07 Apr 2012 16:25:52 +0200
Message-ID: <4F804E70.2020106@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 16:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGWcQ-0001p5-J2
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 16:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab2DGO1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 10:27:23 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:44525 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab2DGO1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 10:27:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 7BFC7DE7F1;
	Sat,  7 Apr 2012 16:27:20 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2SuteuFg3Zc; Sat,  7 Apr 2012 16:27:20 +0200 (CEST)
Received: from [10.0.1.2] (f052150113.adsl.alicedsl.de [78.52.150.113])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 42E80DE7F0;
	Sat,  7 Apr 2012 16:27:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120406 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194951>

Add missing options "--tags|--no-tags" and "--push".

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/remote.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index fec92bc..b5645fe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -9,7 +9,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror=<fetch|push>] <name> <url>",
+	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote set-head <name> (-a | -d | <branch>)",
@@ -17,7 +17,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]",
 	"git remote set-branches [--add] <name> <branch>...",
-	"git remote set-url <name> <newurl> [<oldurl>]",
+	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
 	"git remote set-url --delete <name> <url>",
 	NULL
-- 
1.7.10.dirty
