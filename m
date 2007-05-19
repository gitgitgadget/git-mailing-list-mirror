From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Update bash completion to ignore some more plumbing commands
Date: Sat, 19 May 2007 23:35:21 +0200
Message-ID: <20070519213521.GA32221@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 23:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpWaJ-0007xk-CT
	for gcvg-git@gmane.org; Sat, 19 May 2007 23:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbXESVfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbXESVfZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 17:35:25 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:47999 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324AbXESVfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 17:35:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 24253770014;
	Sat, 19 May 2007 23:35:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W+nBdpF3a+cN; Sat, 19 May 2007 23:35:22 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 0E61977000D;
	Sat, 19 May 2007 23:35:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E0B806DF8AC; Sat, 19 May 2007 23:33:36 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E5EB562A5D; Sat, 19 May 2007 23:35:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47776>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

 I am not sure if it is OK to exclude checkout-index as it is
 the only method of exporting the source as a directory. Also,
 I don't understand why git-diff-* is not excluded.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 46356e8..e758242 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -262,7 +262,9 @@ __git_commands ()
 		applypatch)       : ask gittus;;
 		archimport)       : import;;
 		cat-file)         : plumbing;;
+		check-attr)       : plumbing;;
 		check-ref-format) : plumbing;;
+		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
 		convert-objects)  : plumbing;;
 		cvsexportcommit)  : export;;
@@ -271,8 +273,10 @@ __git_commands ()
 		daemon)           : daemon;;
 		fast-import)      : import;;
 		fsck-objects)     : plumbing;;
+		fetch--tool)      : plumbing;;
 		fetch-pack)       : plumbing;;
 		fmt-merge-msg)    : plumbing;;
+		for-each-ref)     : plumbing;;
 		hash-object)      : plumbing;;
 		http-*)           : transport;;
 		index-pack)       : plumbing;;
-- 
1.5.2.rc3.800.ga489e-dirty

-- 
Jonas Fonseca
