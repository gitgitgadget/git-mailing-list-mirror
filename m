From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gittutorial: remove misleading note
Date: Fri, 23 Jan 2009 19:02:29 +0100
Message-ID: <1232733749-6120-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQNo-0002yb-Uk
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbZAWSCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756913AbZAWSCc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:02:32 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56448 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbZAWSCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:02:32 -0500
Received: from vmobile.example.net (dsl5400FA54.pool.t-online.hu [84.0.250.84])
	by yugo.frugalware.org (Postfix) with ESMTPA id 42728446CEA;
	Fri, 23 Jan 2009 19:02:30 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C3F244BDE2; Fri, 23 Jan 2009 19:02:29 +0100 (CET)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106897>

In the tutorial Alice initializes the repository, and Bob clones it. So
Bob can just do a 'git pull', but Alice will need 'git pull <url>
<branch>'.

The note suggested that the branch parameter is not necessary, which is
no longer true these days.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

The problem was reported by DanC on IRC.

 Documentation/gittutorial.txt |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 458fafd..c5d5596 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -308,9 +308,7 @@ alice$ git pull /home/bob/myrepo master
 
 This merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
-then she may need to manually fix any conflicts.  (Note that the
-"master" argument in the above command is actually unnecessary, as it
-is the default.)
+then she may need to manually fix any conflicts.
 
 The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
-- 
1.6.1
