From: Christian Couder <chriscool@tuxfamily.org>
Subject: Bisect: improve readability in "bisect_next_check".
Date: Tue, 17 Apr 2007 07:02:08 +0200
Message-ID: <20070417070208.95cc3fa3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdfhq-0000IM-J7
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbXDQEx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbXDQEx4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:53:56 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55573 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbXDQEx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:53:56 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8015FB92E8;
	Tue, 17 Apr 2007 06:53:54 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44724>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 85c374e..512c1c6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -174,7 +174,8 @@ bisect_next_check() {
 
 	case "$missing_good,$missing_bad,$1" in
 	,,*)
-		: have both good and bad - ok
+		# have both good and bad - ok
+		true
 		;;
 	*,)
 		# do not have both but not asked to fail - just report.
@@ -189,7 +190,8 @@ bisect_next_check() {
 			printf >&2 'Are you sure [Y/n]? '
 			case "$(read yesno)" in [Nn]*) exit 1 ;; esac
 		fi
-		: bisect without good...
+		# bisect without good...
+		true
 		;;
 	*)
 		THEN=''
-- 
1.5.1.1.821.g88bdb-dirty
