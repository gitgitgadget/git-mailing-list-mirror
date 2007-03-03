From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 2/2] git-branch: document new --no-abbrev option
Date: Sat,  3 Mar 2007 00:31:17 +0000
Message-ID: <11728818773390-git-send-email-julian@quantumfyre.co.uk>
References: <11728818772136-git-send-email-julian@quantumfyre.co.uk> <11728818771064-git-send-email-julian@quantumfyre.co.uk>
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 01:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNI9l-00013T-9D
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992799AbXCCAbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992800AbXCCAbU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:31:20 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:47308 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992799AbXCCAbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:31:19 -0500
Received: (qmail 6460 invoked by uid 103); 3 Mar 2007 00:31:17 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2691. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.129922 secs); 03 Mar 2007 00:31:17 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 3 Mar 2007 00:31:17 +0000
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11728818771064-git-send-email-julian@quantumfyre.co.uk>
Message-Id: <4a1baac35d2826499a1fa4c1439b7740be23e7b5.1172881822.git.julian@quantumfyre.co.uk>
In-Reply-To: <028df363480685d1fe1ab84a99b2573dda853440.1172881822.git.julian@quantumfyre.co.uk>
References: <028df363480685d1fe1ab84a99b2573dda853440.1172881822.git.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add the new --no-abbrev option to the man page for the git-branch command.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Documentation/git-branch.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index aa1fdd4..3ea3b80 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,8 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git-branch' [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]
+'git-branch' [--color | --no-color] [-r | -a]
+	   [-v [--abbrev=<length> | --no-abbrev]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
@@ -80,6 +81,9 @@ OPTIONS
 	Alter minimum display length for sha1 in output listing,
 	default value is 7.
 
+--no-abbrev::
+	Display the full sha1s in output listing rather than abbreviating them.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
-- 
1.5.0.2
