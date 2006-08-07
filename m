From: Michael Krelin <hacker@klever.net>
Subject: [PATCH] handle https:// protocol in git-clone
Date: Mon, 7 Aug 2006 17:10:21 +0200
Message-ID: <20060807151021.GF21051@argo.zzZZzz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 07 17:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA6kR-0006Fu-H4
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 17:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHGPK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 11:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWHGPK2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 11:10:28 -0400
Received: from argo.arachnion.zzZZzz.net ([62.27.45.185]:18379 "EHLO
	argo.arachnion.zzZZzz.net") by vger.kernel.org with ESMTP
	id S932128AbWHGPK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 11:10:27 -0400
Received: from hacker by argo.arachnion.zzZZzz.net with local (Exim 4.42)
	id 1GA6kH-0000IY-FY
	for git@vger.kernel.org; Mon, 07 Aug 2006 17:10:21 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25017>

---
 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index acc7a51..7060bda 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -298,7 +298,7 @@ yes,yes)
 		fi
 		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
-	http://*)
+	https://*|http://*)
 		if test -z "@@NO_CURL@@"
 		then
 			clone_dumb_http "$repo" "$D"
-- 
1.4.1.1

Love,
H
