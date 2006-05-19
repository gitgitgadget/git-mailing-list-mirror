From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/5] Change order of -m option to update-ref.
Date: Fri, 19 May 2006 05:15:50 -0400
Message-ID: <20060519091550.GJ22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:16:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh15Q-0008A1-RI
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWESJPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWESJPy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:15:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18123 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751258AbWESJPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:15:53 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh15J-0005hb-0T; Fri, 19 May 2006 05:15:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 40992212691; Fri, 19 May 2006 05:15:50 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20339>

The actual position doesn't matter but most people prefer to see
options appear before the arguments.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/git-update-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

75d5d46e9d911ab657af3c2eef9b585ac6a36b18
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index dfbd886..e062030 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - update the object name 
 
 SYNOPSIS
 --------
-'git-update-ref' <ref> <newvalue> [<oldvalue>] [-m <reason>]
+'git-update-ref' [-m <reason>] <ref> <newvalue> [<oldvalue>]
 
 DESCRIPTION
 -----------
-- 
1.3.2.g7278
