From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] mention mergetool in gittutorial
Date: Mon, 27 Apr 2009 19:46:16 +0530
Message-ID: <20090427141616.GA10750@atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 16:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyRdT-0003Vf-Kd
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 16:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbZD0OQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZD0OQb
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 10:16:31 -0400
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:47299 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbZD0OQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 10:16:30 -0400
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.14.2/8.14.2) with ESMTP id n3REGIjH011001;
	Mon, 27 Apr 2009 19:46:18 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.14.2/8.14.2/Submit) id n3REGGId010997;
	Mon, 27 Apr 2009 19:46:16 +0530
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9291/Sun Apr 26 12:14:09 2009 on atcmail.atc.tcs.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117672>

---

This came up in IRC in some context, and pasky suggested it
might be useful to talk about mergetool in the tutorial.

 Documentation/gittutorial.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c5d5596..0d2e75d 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -239,8 +239,15 @@ markers will be left in the problematic files showing the conflict;
 $ git diff
 ------------------------------------------------
 
-will show this.  Once you've edited the files to resolve the
-conflicts,
+will show this.  You can use your normal text editor to resolve the conflicts,
+or you can use linkgit:git-mergetool[1] to invoke any of a range of popular
+tools to help you do this.  For example:
+
+------------------------------------------------
+$ git mergetool --tool=meld
+------------------------------------------------
+
+Once you've edited the files to resolve the conflicts,
 
 ------------------------------------------------
 $ git commit -a
-- 
1.6.2.4
