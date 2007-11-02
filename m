From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Remove escaping of '|' in manpage option sections
Date: Fri, 2 Nov 2007 10:10:11 +0100
Message-ID: <20071102091011.GB10141@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsXt-0006BG-BU
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbXKBJKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXKBJKP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:10:15 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:35139 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517AbXKBJKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 12F6752C3D9;
	Fri,  2 Nov 2007 10:10:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUUUEVw7NIfY; Fri,  2 Nov 2007 10:10:11 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7862052C3CA;
	Fri,  2 Nov 2007 10:10:11 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C4E5C6DFF8B; Fri,  2 Nov 2007 10:09:59 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 67B345B8001; Fri,  2 Nov 2007 10:10:11 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63079>

The escaped were ending up verbatim in the generated documentation.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-filter-branch.txt |    2 +-
 Documentation/git-stripspace.txt    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ba9b4fb..37b6fb8 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -152,7 +152,7 @@ definition impossible to preserve signatures at any rate.)
 	does this in the '.git-rewrite/' directory but you can override
 	that choice by this parameter.
 
--f\|--force::
+-f|--force::
 	`git filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
 	'refs/original/', unless forced.
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 5212358..f80526b 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -16,7 +16,7 @@ Remove multiple empty lines, and empty lines at beginning and end.
 
 OPTIONS
 -------
--s\|--strip-comments::
+-s|--strip-comments::
 	In addition to empty lines, also strip lines starting with '#'.
 
 <stream>::
-- 
1.5.3.4.1481.g854da-dirty

-- 
Jonas Fonseca
