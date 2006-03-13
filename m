From: Alex Riesen <raa.lkml@gmail.com>
Subject: make -d work in git-repack (without -a)
Date: Mon, 13 Mar 2006 23:26:21 +0100
Message-ID: <20060313222621.GA25713@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 23:28:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIvUu-0005pd-Vn
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 23:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWCMW0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWCMW0f
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 17:26:35 -0500
Received: from devrace.com ([198.63.210.113]:18443 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964785AbWCMW0e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 17:26:34 -0500
Received: from tigra.home (p54A07B36.dip.t-dialin.net [84.160.123.54])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k2DMQObM006072;
	Mon, 13 Mar 2006 16:26:25 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FIvUc-0000sV-00; Mon, 13 Mar 2006 23:26:22 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FIvUb-0006ms-T4; Mon, 13 Mar 2006 23:26:21 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17576>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Junio C Hamano, Thu, Mar 09, 2006 19:50:43 +0100:
> I am inclined to say I prefer Alex' one.

I guess it has to be sent in formally...

 git-repack.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

a594bee1d539f71970e321592f45a114ea648d92
diff --git a/git-repack.sh b/git-repack.sh
index bc90112..2f643b5 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -74,6 +74,8 @@ then
 			esac
 		  done
 		)
+	else
+		git-prune-packed
 	fi
 	git-prune-packed
 fi
-- 
1.2.4.g6ec337
