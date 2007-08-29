From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Explain in --pid-file that using --inetd implies it automatically
Date: Wed, 29 Aug 2007 11:07:37 +0300
Organization: Private
Message-ID: <ejhm3gs6.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 10:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQIX1-0003bu-0U
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXH2IEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbXH2IEB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:04:01 -0400
Received: from main.gmane.org ([80.91.229.2]:41035 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbXH2ID7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:03:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQIWh-0003oj-CM
	for git@vger.kernel.org; Wed, 29 Aug 2007 10:03:47 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 10:03:47 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 10:03:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:6xo/QVKvIjQqwfBX+YlV4Va0BcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56906>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-daemon.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f902161..687deb2 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -124,7 +124,8 @@ OPTIONS
 	Detach from the shell. Implies --syslog.
 
 --pid-file=file::
-	Save the process id in 'file'.
+	Save the process id in 'file'. When `--inetd` is in use, this
+        option is not needed.
 
 --user=user, --group=group::
 	Change daemon's uid and gid before entering the service loop.
-- 
1.5.3.rc5

Available also from git repository http://cante.net/~jaalto/git/git

    Branch: Documentation/git-daemon.txt+option--pid-file
