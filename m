From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Remove extra dots from doc of git-archive option --format
Date: Fri, 14 Sep 2007 21:38:02 +0300
Organization: Private
Message-ID: <7imtt7n9.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 20:42:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWG09-0007oI-Qj
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbXINSeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbXINSeq
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:34:46 -0400
Received: from main.gmane.org ([80.91.229.2]:49832 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbXINSep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:34:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IWFzu-0001jU-Mk
	for git@vger.kernel.org; Fri, 14 Sep 2007 20:34:34 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 20:34:34 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 20:34:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:AdBGpaA4kDR6qPnNr/I6/hoz7UM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58177>

The description of the option gave impression that there
were several formats available by using three dots. There are
no other formats than tar and gzip.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 Documentation/git-archive.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index f2080eb..04771dc 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -31,7 +31,7 @@ OPTIONS
 -------
 
 --format=<fmt>::
-	Format of the resulting archive: 'tar', 'zip'...  The default
+	Format of the resulting archive: 'tar' or 'zip'.  The default
 	is 'tar'.
 
 --list, -l::
-- 
1.5.3


-- 
Welcome to FOSS revolution: we fix and modify until it shines
