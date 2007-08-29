From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Document service option receive-pack
Date: Wed, 29 Aug 2007 12:57:06 +0300
Organization: Private
Message-ID: <4pii3bpp.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 11:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKEe-00009A-01
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbXH2JxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbXH2JxN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:53:13 -0400
Received: from main.gmane.org ([80.91.229.2]:44334 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959AbXH2JxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:53:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQKET-0008Ur-Tr
	for git@vger.kernel.org; Wed, 29 Aug 2007 11:53:05 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:53:05 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:53:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:IbfGt70xWaRftA9h8Dzwoo8mCKg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56921>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-daemon.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f902161..91ce5f3 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -157,6 +157,13 @@ the facility of inet daemon to achieve the same before spawning
 SERVICES
 --------
 
+receive-pack::
+        Allow anonymous push to the repository. Use with caution.
+        Anyone can do anything in there: push to the repository,
+        delete content and branches or even add malicious code. This
+        kind of public pushable repository content needs peer review
+        and cannot be trusted.
+
 upload-pack::
 	This serves `git-fetch-pack` and `git-peek-remote`
 	clients.  It is enabled by default, but a repository can
-- 
1.5.3.rc5

    Available from git repository http://cante.net/~jaalto/git/git
    Branch: Documentation/git-daemon.txt+document-service-option--receive-pack
