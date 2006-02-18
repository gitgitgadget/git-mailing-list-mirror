From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Document --short and --git-dir in git-rev-parse(1)
Date: Sat, 18 Feb 2006 02:11:36 +0100
Message-ID: <20060218011136.GC2562@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 02:11:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAGdT-00011e-ID
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 02:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBRBLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 20:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBRBLj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 20:11:39 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:49080 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751077AbWBRBLi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 20:11:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1868F52D556;
	Sat, 18 Feb 2006 02:11:38 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03998-19; Sat, 18 Feb 2006 02:11:36 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4B31952D395;
	Sat, 18 Feb 2006 02:11:36 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 603F66DF823; Sat, 18 Feb 2006 02:10:38 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 396B361BD0; Sat, 18 Feb 2006 02:11:36 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16380>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 013b99654ee464856d266a72f0203d0fee2b0d11
tree 3c961d6ebb8b9805ee3950ec081679de15f5a9ba
parent 16e2efc524d181cf46dcb252532139a0aff4a28f
author Jonas Fonseca <fonseca@diku.dk> Sat, 18 Feb 2006 02:05:11 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 18 Feb 2006 02:05:11 +0100

 Documentation/git-rev-parse.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d638bfc..1662e06 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -77,6 +77,14 @@ OPTIONS
 	path of the top-level directory relative to the current
 	directory (typically a sequence of "../", or an empty string).
 
+--git-dir::
+	Show `$GIT_DIR` if defined else show the path to the .git directory.
+
+--short, short=number::
+	Instead of outputting the full SHA1 values of object names try to
+	abbriviate them to a shorter unique name. When no length is specified
+	7 is used. The minimum length is 4.
+
 --since=datestring, --after=datestring::
 	Parses the date string, and outputs corresponding
 	--max-age= parameter for git-rev-list command.

-- 
Jonas Fonseca
