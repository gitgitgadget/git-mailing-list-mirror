From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 3/3] Add new dependencies caused by git-send-email-script to debian/control
Date: Sun, 31 Jul 2005 04:17:25 -0400
Message-ID: <1122797845573@foobar.com>
References: <112279784541@foobar.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ryan@michonline.com
X-From: git-owner@vger.kernel.org Sun Jul 31 10:18:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz91s-00013d-0q
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 10:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGaIR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGaIR2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 04:17:28 -0400
Received: from mail.autoweb.net ([198.172.237.26]:3561 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261835AbVGaIR1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 04:17:27 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dz90g-0005mH-HR; Sun, 31 Jul 2005 04:17:26 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dz9AL-0004nD-00; Sun, 31 Jul 2005 04:27:25 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1Dz90f-0006Xl-Nx; Sun, 31 Jul 2005 04:17:25 -0400
In-Reply-To: <112279784541@foobar.com>
X-Mailer: git-send-email-script
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 debian/control |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6dbf602b0931608831888e779612fcc89b90d16f
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -8,7 +8,7 @@ Standards-Version: 3.6.1
 Package: git-core
 Architecture: any
 Depends: ${shlibs:Depends}, ${misc:Depends}, patch, diff, rcs
-Recommends: rsync, curl, ssh
+Recommends: rsync, curl, ssh, libmail-sendmail-perl, libemail-valid-perl
 Conflicts: git
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
