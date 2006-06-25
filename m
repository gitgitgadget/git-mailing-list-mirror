From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] correct documentation for git grep
Date: Mon, 26 Jun 2006 01:39:18 +0200
Message-ID: <E1FueCE-0003W3-4Q@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 01:39:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FueCL-0003Zb-Ix
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 01:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWFYXjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWFYXjV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 19:39:21 -0400
Received: from moooo.ath.cx ([85.116.203.178]:52430 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964899AbWFYXjV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 19:39:21 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22649>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
> ... and by the far the most common use is to pass more than one pattern. 
> Also, the usage is "[-e] <pattern> [-e <pattern>...]".
Ok, so I changed the patch :)

 Documentation/git-grep.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 7b810df..3dd1bdd 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
-	   [-f <file>] [-e <pattern>]
+	   [-f <file>] [-e] <pattern> [-e <pattern> [..]]
 	   [<tree>...]
 	   [--] [<path>...]
 
@@ -71,6 +71,12 @@ OPTIONS
 -f <file>::
 	Read patterns from <file>, one per line.
 
+-e::
+	The next parameter is a pattern. This option has to be
+	used for patterns starting with - and should be used in
+	scripts passing user input to grep. You can specify multiple
+	patterns which will be combined by or.
+
 `<tree>...`::
 	Search blobs in the trees for specified patterns.
 
-- 
1.4.1.rc1.g72a4-dirty
