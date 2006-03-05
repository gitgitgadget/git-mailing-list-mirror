From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 3/3] Documentation/git-cvsserver.txt: Fix list numbering.
Date: Sun, 05 Mar 2006 09:36:35 +0000
Message-ID: <20060305093635.26650.13163.stgit@metalzone.distorted.org.uk>
References: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 10:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpfR-00021M-Gu
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbWCEJgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCEJgh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:36:37 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:63386 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752159AbWCEJgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 04:36:36 -0500
Received: (qmail 26960 invoked from network); 5 Mar 2006 09:36:35 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 09:36:35 -0000
To: git@vger.kernel.org
In-Reply-To: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17214>

From: Mark Wooding <mdw@distorted.org.uk>

Asciidoc complains about the bogus list item numbers in the installation
instructions.  Fix them.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 Documentation/git-cvsserver.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
 
