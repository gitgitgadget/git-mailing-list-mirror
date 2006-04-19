From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge: a bit more readable user guidance.
Date: Wed, 19 Apr 2006 14:59:26 -0700
Message-ID: <7vwtdl5irl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
	<87acah6zk6.wl%cworth@cworth.org>
	<7v8xq16y31.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 19 23:59:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKhv-0005OC-GQ
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDSV72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWDSV72
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:59:28 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28622 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751267AbWDSV71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 17:59:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419215927.CQAH8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 17:59:27 -0400
To: git@vger.kernel.org
In-Reply-To: <7v8xq16y31.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 19 Apr 2006 14:43:14 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18945>

We said "fix up by hand" after failed automerge, which was a big
"Huh?  Now what?".  Be a bit more explicit without being too
verbose. Suggested by Carl Worth.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

aec8e89ca3d38f9d0d4d287d874e8b3859d68787
diff --git a/git-merge.sh b/git-merge.sh
index 78ab422..b834e79 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -335,5 +335,5 @@ Conflicts:
 	then
 		git-rerere
 	fi
-	die "Automatic merge failed; fix up by hand"
+	die "Automatic merge failed; fix conflicts and then commit the result."
 fi
-- 
1.3.0.g2c4a
