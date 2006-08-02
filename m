From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-grep: document --and, --or, --not, ( and )
Date: Thu, 3 Aug 2006 00:04:56 +0200
Message-ID: <E1G8Opk-0003lj-Q7@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 00:05:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Opt-0000dR-UI
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHBWE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHBWE7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:04:59 -0400
Received: from moooo.ath.cx ([85.116.203.178]:50893 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932159AbWHBWE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 18:04:58 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24693>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The synopsis looks a bit strange, perhaps someone else has an idea for
this.
---
 Documentation/git-grep.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 62a8e7f..544ad24 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
-	   [-f <file>] [-e] <pattern>
+	   [-f <file>] [-e] <pattern> [--and|--or|--not|(|)|-e <pattern>...]
 	   [<tree>...]
 	   [--] [<path>...]
 
@@ -74,7 +74,14 @@ OPTIONS
 -e::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with - and should be used in
-	scripts passing user input to grep.
+	scripts passing user input to grep.  Multiple patterns are
+	combined by 'or'.
+
+--and | --or | --not | ( | )::
+	Specify how multiple patterns are combined using boolean
+	expressions.  `--or` is the default operator.  `--and` has
+	higher precedence than `--or`.  `-e` has to be used for all
+	patterns.
 
 `<tree>...`::
 	Search blobs in the trees for specified patterns.
-- 
1.4.2.rc2.g4713
