From: Francis Daly <francis@daoine.org>
Subject: [PATCH] avoid asciidoc warning in git-cvsserver.txt
Date: Sun, 5 Mar 2006 11:41:33 +0000
Message-ID: <20060305114133.GA20399@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 05 12:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFriz-0002DR-Ga
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 12:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbWCELsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 06:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWCELsa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 06:48:30 -0500
Received: from craic.sysops.org ([217.75.2.2]:26508 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1752250AbWCELs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 06:48:29 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k25BfX1j020433
	for <git@vger.kernel.org>; Sun, 5 Mar 2006 11:41:34 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1314/Sat Mar  4 13:39:05 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-2.5 required=2.0
	tests=USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17224>


Manually renumber to keep asciidoc happy

---

 Documentation/git-cvsserver.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

9809de6594b8e11261ca5f18bb2eadb913fb33ae
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 19c9c51..0c4948d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -44,13 +44,13 @@ INSTALLATION
    n.b. you need to ensure each user that is going to invoke server.pl has
    write access to the log file.
 
-5. On each client machine you need to set the following variables.
+3. On each client machine you need to set the following variables.
      CVSROOT should be set as per normal, but the directory should point at the
              appropriate git repo.
      CVS_SERVER should be set to the server.pl script that has been put on the
                 remote machine.
 
-6. Clients should now be able to check out modules (where modules are the names
+4. Clients should now be able to check out modules (where modules are the names
    of branches in git).
      $ cvs co -d mylocaldir master
 
-- 
1.2.GIT

-- 
Francis Daly        francis@daoine.org
