From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.
Date: Sun, 08 Feb 2009 00:16:11 +0200
Message-ID: <87zlgxzydw.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 23:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVvVL-0007a2-H9
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 23:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZBGWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbZBGWRE
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 17:17:04 -0500
Received: from main.gmane.org ([80.91.229.2]:41563 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZBGWRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 17:17:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVvTt-0003jZ-Pb
	for git@vger.kernel.org; Sat, 07 Feb 2009 22:16:57 +0000
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 22:16:57 +0000
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 22:16:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:ouYAp3CrpT6JhvDaoVYRULz7RzQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108896>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-show.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 48b612e..2a014cc 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -57,7 +57,11 @@ git show v1.0.0^\{tree\}::
 git show next~10:Documentation/README::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
-	`next`.
+	`next`. *Note:* the 'object' path must always be relative to git
+	project root. This wouldn't have worked:
+
+	$ cd Documentation
+	$ git show next~10:README
 
 git show master:Makefile master:t/Makefile::
 	Concatenates the contents of said Makefiles in the head
-- 
1.5.6.5
