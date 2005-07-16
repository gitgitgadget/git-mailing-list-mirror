From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 2/5] cogito: remove use of cp -a, a non-portable GNU extension
Date: Sat, 16 Jul 2005 19:23:36 -0400
Message-ID: <20050716232330.7317.50646.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw17-0007X0-MC
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVGPXYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVGPXX6
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:23:58 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:52344 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261890AbVGPXXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:23:36 -0400
Received: (qmail 49996 invoked from network); 16 Jul 2005 23:23:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=CMb0MuVqMFWYGJqQFbZ324LWXjFRXs5UCV+YF5KT1ruHtNfqzeTddJgSL6fRmAHMiu05RH3fds/qXq8izwsR7W1MxqBkFdDpmJO+isZxz2PpX/BnJKfgcSTXmLa26wdOj2mwwBDGl8QZ0XfaBjb4LL5tsYO9vxf5iJqAGfpLjts=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp104.mail.sc5.yahoo.com with SMTP; 16 Jul 2005 23:23:35 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
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
