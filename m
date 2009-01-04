From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH next] git-cherry usage: correct nesting of commit-ish options
Date: Sun, 4 Jan 2009 17:11:22 +0100
Message-ID: <200901041711.23026.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 17:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJVaN-0002Zj-8I
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 17:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZADQK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZADQK4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 11:10:56 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:54166 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZADQKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 11:10:55 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 25ACDFB63403;
	Sun,  4 Jan 2009 17:10:53 +0100 (CET)
Received: from [89.59.126.169] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LJVYy-0003oz-00; Sun, 04 Jan 2009 17:10:53 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19UzZvVnzFQ+eDOrCWOucW8Qxf/5IIEc7xV12X9
	4klN0OMPYu4eadtAmQd7mEAw/yfLe1EMF0YXr3mle+nTa7l5Qg
	EoUYgYaKAtKp4Mv8dmtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104522>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

What is the preferred way to say the patch is against next? In the
subject like this?
Another question: should this patch be split up into two, one for
maint/master and another for next?

 Documentation/git-cherry.txt |    2 +-
 builtin-log.c                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 556ea23..7deefda 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] [<upstream>] [<head>] [<limit>]
+'git cherry' [-v] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
diff --git a/builtin-log.c b/builtin-log.c
index 243f857..7e9616e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1071,7 +1071,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 }
 
 static const char cherry_usage[] =
-"git cherry [-v] [<upstream>] [<head>] [<limit>]";
+"git cherry [-v] [<upstream> [<head> [<limit>]]]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-- 
1.6.1.35.g0c23
