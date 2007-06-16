From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11/11] Document git commit --untracked-files and --verbose
Date: Sat, 16 Jun 2007 21:03:47 +0200
Message-ID: <11820206363507-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU5-0007JN-W3
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbXFPS6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbXFPS6a
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:8308 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbXFPS6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101921ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iYRX/hybbYvrHFR2zjZPc+F7KMRv4kjlBPjHVJBULEK/Kbp6+CzvTDi3zrXHcb7zIpb7YQp3+/DpJdj6XkI+Rl6yuT4cxgmBzRa2KF3klsq10ayTEmaBK/NO4KUsPz3AuqGZC6d76Hg/5pMvFDKpTnMsXLhx8x9bxBH+Yqs2BF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rkznK95pN3s8X48YTEa9J6RMnJzrboeUG5RS2SMQIXLcc1Y3/RdwZWX07guT/5Mz/VrPlC4EYGzpRIvGUzyH4LiYShjFlmMgoBOqzFoJMmyxmQn+qU6LX0gOdYzdHworV3TkCBT7+pq3IKcuwZTu6p5PzZRKiz4605SRCdWMN6E=
Received: by 10.82.186.5 with SMTP id j5mr8128204buf.1182020295032;
        Sat, 16 Jun 2007 11:58:15 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875833nfh.2007.06.16.11.58.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3u2A004266;
	Sat, 16 Jun 2007 21:03:56 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3u12004265;
	Sat, 16 Jun 2007 21:03:56 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50299>

Note that those options apply also to git-status.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-commit.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 352a494..cd2d4c7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v]
+'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
@@ -115,6 +115,14 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
+-u|--untracked-files::
+	Show all untracked files, also those in uninteresting
+	directories.
+
+-v|--verbose::
+	Show the diff output between the HEAD commit and what
+	would be committed.
+
 -q|--quiet::
 	Suppress commit summary message.
 
-- 
1.5.2
