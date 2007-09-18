From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Mention that 'push .. master' is in explicit form master:refs/heads/master
Date: Tue, 18 Sep 2007 12:59:53 +0300
Organization: Private
Message-ID: <wsuomgyu.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 11:55:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZo9-0003vo-Ot
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbXIRJzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbXIRJzo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:55:44 -0400
Received: from main.gmane.org ([80.91.229.2]:44329 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbXIRJzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:55:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXZnr-0007vc-Dg
	for git@vger.kernel.org; Tue, 18 Sep 2007 11:55:35 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 11:55:35 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 11:55:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:31eoHOM1abRWOpPKbRJzgmWXSYE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58566>

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 Documentation/git-push.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7b8e075..71ac450 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -105,7 +105,9 @@ git push origin master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
 	the same ref (e.g. `refs/heads/master`) in `origin` repository
-	with it.
+	with it. The following would be exactly same command:
+
+	git push origin master:refs/heads/master
 
 git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
-- 
1.5.3


-- 
Welcome to FOSS revolution: we fix and modify until it shines
