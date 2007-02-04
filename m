From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Default GIT_MERGE_VERBOSITY to 5 during tests.
Date: Sun, 4 Feb 2007 00:45:47 -0500
Message-ID: <20070204054547.GA17344@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDaCR-0000cd-QE
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXBDFpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXBDFpz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:45:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53117 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbXBDFpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:45:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDaCG-0003Pw-Ux; Sun, 04 Feb 2007 00:45:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 35E4E20FBAE; Sun,  4 Feb 2007 00:45:48 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38654>

Its really nice to be able to run a test with -v and automatically
see the "debugging" dump from merge-recursive, especially if we
are actually trying to debug merge-recursive.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8e3ee6c..37822fc 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -30,6 +30,8 @@ unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
+GIT_MERGE_VERBOSITY=5
+export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
-- 
1.5.0.rc3.22.g5057
