From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Add comment that git-archive writes to stdout
Date: Fri, 14 Sep 2007 21:41:52 +0300
Organization: Private
Message-ID: <1wd1t7gv.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 20:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWG5R-0001xx-7L
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXINSkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbXINSkL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:40:11 -0400
Received: from main.gmane.org ([80.91.229.2]:40959 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258AbXINSkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:40:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IWG5D-0002VA-13
	for git@vger.kernel.org; Fri, 14 Sep 2007 20:40:03 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 20:40:03 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 20:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:JzmNU+K3WCyV3la77aHTTz7ngpU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58178>

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 Documentation/git-archive.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index f2080eb..f172639 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -16,7 +16,8 @@ DESCRIPTION
 -----------
 Creates an archive of the specified format containing the tree
 structure for the named tree.  If <prefix> is specified it is
-prepended to the filenames in the archive.
+prepended to the filenames in the archive. The archive is
+written to stdout.
 
 'git-archive' behaves differently when given a tree ID versus when
 given a commit ID or tag ID.  In the first case the current time is
-- 
1.5.3


-- 
Welcome to FOSS revolution: we fix and modify until it shines
