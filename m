From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Print help output when no command is given
Date: Wed, 19 Nov 2008 17:03:43 +0100
Message-ID: <1227110623-4474-5-git-send-email-madduck@debian.org>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
 <1227110623-4474-2-git-send-email-madduck@debian.org>
 <1227110623-4474-3-git-send-email-madduck@debian.org>
 <1227110623-4474-4-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 17:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pYr-0004Ic-PR
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYKSQEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYKSQEA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:04:00 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47991 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbYKSQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:03:58 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 73F091D40B2;
	Wed, 19 Nov 2008 17:03:47 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id EC3049F1AE;
	Wed, 19 Nov 2008 17:03:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B9C8E45F7; Wed, 19 Nov 2008 17:03:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1227110623-4474-4-git-send-email-madduck@debian.org>
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101354>

As much as I love your message (although you really ought not be
throwing around ducks!), this is more user-friendly.

Signed-off-by: martin f. krafft <madduck@debian.org>
---
 tg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index f3d1323..e0d62e7 100644
--- a/tg.sh
+++ b/tg.sh
@@ -278,7 +278,7 @@ if [ "$1" = "-r" ]; then
 fi
 
 cmd="$1"
-[ -n "$cmd" ] || die "He took a duck in the face at two hundred and fifty knots"
+[ -n "$cmd" ] || { do_help; exit 1; }
 shift
 
 case "$cmd" in
-- 
1.6.0.2
