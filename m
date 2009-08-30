From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/git-add.txt: Explain --patch option in layman terms
Date: Sun, 30 Aug 2009 20:29:59 +0300
Organization: Private
Message-ID: <87ocpxb46g.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 19:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhoEY-0008CK-S6
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 19:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbZH3RaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZH3RaX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 13:30:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:36872 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbZH3RaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 13:30:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MhoEQ-0008Ak-I1
	for git@vger.kernel.org; Sun, 30 Aug 2009 19:30:22 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 19:30:22 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 19:30:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:tq5DblKB6c62eQkzur0785+CtT4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127417>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-add.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e67b7e8..71990c2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -67,14 +67,14 @@ OPTIONS
 --interactive::
 	Add modified contents in the working tree interactively to
 	the index. Optional path arguments may be supplied to limit
-	operation to a subset of the working tree. See ``Interactive
-	mode'' for details.
+	operation to a subset of the working tree. See section
+	``INTERACTIVE MODE'' for details.
 
 -p::
 --patch::
-	Similar to Interactive mode but the initial command loop is
-	bypassed and the 'patch' subcommand is invoked using each of
-	the specified filepatterns before exiting.
+	Run interactive patch command for each file on command line.
+	See section INTERACTIVE MODE and patch subcommand for more
+	information.
 
 -e, \--edit::
 	Open the diff vs. the index in an editor and let the user
-- 
1.6.3.3
