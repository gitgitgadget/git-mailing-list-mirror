From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Change tg help exit code to 0
Date: Wed, 19 Nov 2008 17:03:41 +0100
Message-ID: <1227110623-4474-3-git-send-email-madduck@debian.org>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
 <1227110623-4474-2-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 17:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pYr-0004Ic-0b
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYKSQD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYKSQD6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:03:58 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47989 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYKSQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:03:58 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 9EA4A1D40B3;
	Wed, 19 Nov 2008 17:03:47 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 109179F34D;
	Wed, 19 Nov 2008 17:03:45 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A6EE245F5; Wed, 19 Nov 2008 17:03:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1227110623-4474-2-git-send-email-madduck@debian.org>
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101355>

Printing --help is not an error, but a successful operation, if the help
output could be printed.

Signed-off-by: martin f. krafft <madduck@debian.org>
---
 tg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 40c4ab7..ea22544 100644
--- a/tg.sh
+++ b/tg.sh
@@ -243,7 +243,7 @@ while [ -n "$1" ]; do
 	help|--help|-h)
 		shift
 		do_help "$1"
-		exit 1;;
+		exit 0;;
 	esac
 	shift
 done
-- 
1.6.0.2
