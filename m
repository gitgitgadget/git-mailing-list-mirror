From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 2/6] cogito: remove use of cp -a, a non-portable GNU extension
Date: Sun, 17 Jul 2005 22:50:51 -0400
Message-ID: <20050718025046.11198.10078.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:51:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLih-0008Ei-Qx
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVGRCuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVGRCuy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:50:54 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:3519 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261490AbVGRCuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:50:51 -0400
Received: (qmail 94169 invoked from network); 18 Jul 2005 02:50:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=NShch0WM+FoVIUV1N72aFme/FGdtfe1UeassYBDMylLebLpcmMEtAFPlZKIWHggW0HCouLQJI9WHEuDRbHmUGIuJ1QMJhTbgSLOt/NKHc4lI2dYg4jC8rZ4vUb1QFQSd8Uner/ITHxygiQnyTy3v4pKFN9owVHZKnjHujU07t/M=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp108.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 02:50:50 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove usage of cp -a, a non-portable gnu extension.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-pull |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -217,7 +217,7 @@ fetch_local () {
 	[ "$1" = "-i" ] && shift
 	[ "$1" = "-s" ] && shift
 
-	cp_flags_l="-va"
+	cp_flags_l="-vdpR"
 	if [ "$1" = "-u" ]; then
 		cp_flags_l="$cp_flags_l -u$can_hardlink"
 		suggest_hardlink=
