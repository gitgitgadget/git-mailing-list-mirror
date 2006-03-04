From: Francis Daly <francis@daoine.org>
Subject: [PATCH] AsciiDoc fix for tutorial
Date: Sat, 4 Mar 2006 16:35:27 +0000
Message-ID: <20060304163527.GA12015@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:42:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZpy-0008LT-3W
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCDQmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWCDQmb
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:42:31 -0500
Received: from craic.sysops.org ([217.75.2.2]:8073 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S932118AbWCDQma (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 11:42:30 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k24GZRhX012045
	for <git@vger.kernel.org>; Sat, 4 Mar 2006 16:35:28 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1313/Fri Mar  3 16:19:06 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-1.2 required=2.0
	tests=HTML_00_10,HTML_MESSAGE,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17189>

RE \^.+\^ becomes <sup>. Not wanted here

---

 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7b81a656bfa1faea449f4c9c083d69f940912a8d
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 66680d7..268a877 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -309,7 +309,7 @@ git diff HEAD^^ HEAD^
 -------------------------------------
 
 shows the difference between that previous state and the state two
-commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD^^^^^,
+commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD{caret}{caret}{caret}^^,
 and more generally HEAD~n can refer to the nth previous commit.
 Commits representing merges have more than one parent, and you can
 specify which parent to follow in that case; see
-- 
1.2.GIT

-- 
Francis Daly        francis@daoine.org
