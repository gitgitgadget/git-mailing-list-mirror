From: Martin Nordholts <enselic@gmail.com>
Subject: [PATCH] Clarify the git-branch documentation of default start-point
Date: Thu, 18 Jun 2009 07:41:13 +0200
Message-ID: <1245303673.24201.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 07:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHALI-00066V-41
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 07:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbZFRFjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 01:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbZFRFjJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 01:39:09 -0400
Received: from iph1.telenor.se ([195.54.127.132]:65212 "EHLO iph1.telenor.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbZFRFjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 01:39:08 -0400
X-SMTPAUTH: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArMCAA5wOUrDNmV6mWdsb2JhbACYYAEBAQEBCAsKBxOmGJImhAgF
X-IronPort-AV: E=Sophos;i="4.42,241,1243807200"; 
   d="scan'208";a="21990319"
Received: from ironport2.bredband.com ([195.54.101.122])
  by iph1.telenor.se with ESMTP; 18 Jun 2009 07:39:09 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlleAEpwOUrVcX8QPGdsb2JhbAAIiVSOegEBAQE3piiSJoQIBQ
X-IronPort-AV: E=Sophos;i="4.42,241,1243807200"; 
   d="scan'208";a="503437027"
Received: from c-107f71d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.127.16])
  by ironport2.bredband.com with ESMTP; 18 Jun 2009 07:39:09 +0200
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121794>

For someone not deeply into git it is easy to assume that start-point
of git-branch will deafult to origin/remotebranch when executing the
following command sequence:

  git checkout origin/remotebranch
  git branch localbranch

This change clarifies the git-branch documentation regarding this.
---
 Documentation/git-branch.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ae201de..426f707 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -148,7 +148,10 @@ start-point is either a local or remote branch.
 <start-point>::
 	The new branch will be created with a HEAD equal to this.  It may
 	be given as a branch name, a commit-id, or a tag.  If this option
-	is omitted, the current branch is assumed.
+	is omitted, the current branch is assumed.  Note that checking
+	out a remote branch does not make it the current branch.  If a
+	remote branch is desired as start-point it must be an explicity
+	specified.
 
 <oldbranch>::
 	The name of an existing branch to rename.
-- 
1.6.0.6
