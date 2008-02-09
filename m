From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] web--browse: Add a few quotes in 'init_browser_path'.
Date: Sat, 9 Feb 2008 07:11:01 +0100
Message-ID: <20080209071101.acf6cdbe.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 07:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiqg-0000NP-1E
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 07:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbYBIGFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 01:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYBIGF3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 01:05:29 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58080 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbYBIGFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 01:05:01 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4FEA21AB2AC;
	Sat,  9 Feb 2008 07:05:00 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0BD821AB2A9;
	Sat,  9 Feb 2008 07:05:00 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73200>

These changes were made to the 'init_browser_path' function in
'git-instaweb.sh', but was not in 'git-web--browse.sh'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-web--browse.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 8ed489d..855de40 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -34,8 +34,8 @@ valid_tool() {
 }
 
 init_browser_path() {
-	browser_path=`git config browser.$1.path`
-	test -z "$browser_path" && browser_path=$1
+	browser_path="`git config browser.$1.path`"
+	test -z "$browser_path" && browser_path="$1"
 }
 
 while test $# != 0
-- 
1.5.4.16.g9f0c3
