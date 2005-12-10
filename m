From: freku045@student.liu.se
Subject: [PATCH 1/25] git-bisect: Use $0 instead of program name in usage message.
Date: Sat, 10 Dec 2005 20:37:56 +0100
Message-ID: <11342434762339-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:39:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAXy-0002Gb-EL
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVLJTiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLJTiM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:12 -0500
Received: from [85.8.31.11] ([85.8.31.11]:17613 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965068AbVLJTiH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:07 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 03BCD40FF; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXc-0006yi-00; Sat, 10 Dec 2005 20:37:56 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13448>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

fdaaf0b14e5df17cbeef9e89ff85f33e3dcaa4d6
diff --git a/git-bisect.sh b/git-bisect.sh
index 05dae8a..6ec35ab 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -12,7 +12,7 @@ sq() {
 }
 
 usage() {
-    echo >&2 'usage: git bisect [start|bad|good|next|reset|visualize]
+    echo >&2 'usage: $0 [start|bad|good|next|reset|visualize]
 git bisect start [<pathspec>]	reset bisect state and start bisection.
 git bisect bad [<rev>]		mark <rev> a known-bad revision.
 git bisect good [<rev>...]	mark <rev>... known-good revisions.
-- 
0.99.9.GIT
