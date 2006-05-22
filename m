From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] git help: remove whatchanged from list of common commands
Date: Mon, 22 May 2006 12:09:14 +0200
Message-ID: <20060522100914.GD12810@admingilde.org>
References: <1148255528.61d5d241.0@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 12:09:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi7Lo-0004pn-Ob
	for gcvg-git@gmane.org; Mon, 22 May 2006 12:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWEVKJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 06:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWEVKJR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 06:09:17 -0400
Received: from admingilde.org ([213.95.32.146]:13741 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750705AbWEVKJR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 06:09:17 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fi7Le-00064j-OE; Mon, 22 May 2006 12:09:14 +0200
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <1148255528.61d5d241.0@fieldses.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20494>

whatchanged is replaced by git log now.

Signed-off-by: Martin Waitz

---

7da71dafe75f2a682b07cd1140a29e6fd2705583
 generate-cmdlist.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

7da71dafe75f2a682b07cd1140a29e6fd2705583
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 6c59dbd..ec1eda2 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -37,7 +37,6 @@ show-branch
 status
 tag
 verify-tag
-whatchanged
 EOF
 while read cmd
 do
-- 
1.3.3.g288c

-- 
Martin Waitz
