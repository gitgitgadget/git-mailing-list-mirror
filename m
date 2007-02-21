From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Document the new core.bare configuration option.
Date: Wed, 21 Feb 2007 17:59:08 -0500
Message-ID: <20070221225908.GA27091@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 23:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK0Qe-0001fc-Hu
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 23:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbXBUW7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945901AbXBUW7N
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 17:59:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56404 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945897AbXBUW7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 17:59:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HK0QP-0007gF-Nk; Wed, 21 Feb 2007 17:59:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D579020FBAE; Wed, 21 Feb 2007 17:59:08 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40330>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5c846f..9d045d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -142,6 +142,18 @@ core.preferSymlinkRefs::
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
 
+core.bare::
+	If true this repository is assumed to be 'bare' and has no
+	working directory associated with it.  If this is the case a
+	number of commands that require a working directory will be
+	disabled, such as gitlink:git-add[1] or gitlink:git-merge[1].
++
+This setting is automatically guessed by gitlink:git-clone[1] or
+gitlink:git-init[1] when the repository was created.  By default a
+repository that ends in "/.git" is assumed to be not bare (bare =
+false), while all other repositories are assumed to be bare (bare
+= true).
+
 core.logAllRefUpdates::
 	Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
-- 
1.5.0.1.615.gfb51
