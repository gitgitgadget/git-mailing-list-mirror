From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Elaborate on why ':' is a bad idea in a ref name.
Date: Sat, 20 May 2006 22:03:14 -0400
Message-ID: <20060521020314.GC7605@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 04:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhdI0-00017Q-54
	for gcvg-git@gmane.org; Sun, 21 May 2006 04:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWEUCDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 22:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWEUCDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 22:03:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37331 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751015AbWEUCDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 22:03:24 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FhdHd-0005yP-TY; Sat, 20 May 2006 22:03:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A36FA212691; Sat, 20 May 2006 22:03:14 -0400 (EDT)
To: junio@spearce.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20426>

With the new cat-file syntax of 'v1.3.3:refs.c' we should mention
it as part of the reason why ':' is not permitted in a ref name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

0b552e48ed1d1ce01e0c2850e90caad8150c199c
 Documentation/git-check-ref-format.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

0b552e48ed1d1ce01e0c2850e90caad8150c199c
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 7dc1bdb..3ea720d 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -45,6 +45,8 @@ refname expressions (see gitlink:git-rev
 
 . colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
   value and store it in dstref" in fetch and push operations.
+  It may also be used to select a specific object such as with
+  gitlink:git-cat-file[1] "git-cat-file blob v1.3.3:refs.c".
 
 
 GIT
-- 
1.3.3.gfad60
