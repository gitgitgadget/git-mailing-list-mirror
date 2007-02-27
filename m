From: Theodore Tso <tytso@mit.edu>
Subject: [PATCH] Fix git-show man page formatting in the EXAMPLES section
Date: Tue, 27 Feb 2007 10:43:28 -0500
Message-ID: <20070227154328.GB8228@thunk.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org> <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 19:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM7Di-0006wu-AE
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 19:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbXB0SiZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 13:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbXB0SiZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 13:38:25 -0500
Received: from thunk.org ([69.25.196.29]:39833 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbXB0SiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 13:38:23 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HM7Is-00030L-JH; Tue, 27 Feb 2007 13:43:58 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HM4UC-0003Nj-7P; Tue, 27 Feb 2007 10:43:28 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40768>

Fix asciidoc markup so that the man page is properly formatted in the
EXAMPLES section.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git-show.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index f56f164..5a219ab 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -48,15 +48,15 @@ git show v1.0.0::
 	Shows the tag `v1.0.0`, along with the object the tags
 	points at.
 
-git show v1.0.0^{tree}::
+git show v1.0.0^\{tree\}::
 	Shows the tree pointed to by the tag `v1.0.0`.
 
-git show next~10:Documentation/README
+git show next~10:Documentation/README::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
 	`next`.
 
-git show master:Makefile master:t/Makefile
+git show master:Makefile master:t/Makefile::
 	Concatenates the contents of said Makefiles in the head
 	of the branch `master`.
 
-- 
1.5.0.1.74.g2470
