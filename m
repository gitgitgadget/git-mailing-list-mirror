From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-merge: at least one <remote> not two
Date: Fri, 02 Jan 2009 02:41:08 +0800
Message-ID: <87d4f6vph7.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 01 19:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LISex-0006vw-IA
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 19:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbZAASuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 13:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZAASut
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 13:50:49 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:53633
	"EHLO homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753376AbZAASus (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 13:50:48 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 33D36C590E;
	Thu,  1 Jan 2009 10:50:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104308>

Make SYNOPSIS match usage message

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-merge.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f7be584..a3ac828 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote> <remote>...
+	[-m <msg>] <remote>...
 'git merge' <msg> HEAD <remote>...
 
 DESCRIPTION
-- 
1.6.0.6
