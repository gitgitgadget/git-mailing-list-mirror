From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation: git-rev-list's "patterns"
Date: Sat, 19 May 2007 01:21:53 +0200
Message-ID: <20070518232153.13058.30392.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 01:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBlp-0004RK-W2
	for gcvg-git@gmane.org; Sat, 19 May 2007 01:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbXERXVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbXERXVz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 19:21:55 -0400
Received: from rover.dkm.cz ([62.24.64.27]:41103 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbXERXVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 19:21:54 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id B46038B6ED;
	Sat, 19 May 2007 01:21:53 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47682>

git-rev-list(1) talks about patterns as values for the
--grep, --committed etc. parameters, without going into detail.
This patch mentions that these patterns are actually regexps.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-rev-list.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ab90a22..c3c2043 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -207,12 +207,12 @@ limiting may be applied.
 --author='pattern', --committer='pattern'::
 
 	Limit the commits output to ones with author/committer
-	header lines that match the specified pattern.
+	header lines that match the specified pattern (regular expression).
 
 --grep='pattern'::
 
 	Limit the commits output to ones with log message that
-	matches the specified pattern.
+	matches the specified pattern (regular expression).
 
 --remove-empty::
 
