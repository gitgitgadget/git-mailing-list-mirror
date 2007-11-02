From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Allow git-instaweb to be run from bare repositories
Date: Fri, 2 Nov 2007 10:09:22 +0100
Message-ID: <20071102090922.GA10141@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsX5-00063X-VV
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbXKBJJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbXKBJJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:09:26 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:42412 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbXKBJJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:09:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 2785319BD3F;
	Fri,  2 Nov 2007 10:09:24 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26775-03; Fri,  2 Nov 2007 10:09:22 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 7F50219BD2E;
	Fri,  2 Nov 2007 10:09:22 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C8B3C6DFAE8; Fri,  2 Nov 2007 10:09:10 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 66C1A5B8001; Fri,  2 Nov 2007 10:09:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63078>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 git-instaweb.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

 On IRC yesterday, two were asking for this and it seems simply enough.
 Apparently, git-instaweb is a great way to see if you've set up a
 remote repository correctly.

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 95c3e5a..14917ac 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -6,6 +6,7 @@ USAGE='[--start] [--stop] [--restart]
   [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
   [--module-path=<path> (for Apache2 only)]'
 
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
 fqgitdir="$GIT_DIR"
-- 
1.5.3.4.1481.g854da-dirty



-- 
Jonas Fonseca
