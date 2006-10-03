From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: [PATCH] Fix usage string to match that given in the man page
Date: Tue, 3 Oct 2006 21:11:25 +0100
Message-ID: <200610032111.25259.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tPsIF/+6CeKFpuX"
X-From: git-owner@vger.kernel.org Tue Oct 03 22:14:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqbz-0005Rz-VV
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWJCUL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWJCUL1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:11:27 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:726
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030311AbWJCUL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:11:27 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GUqbt-0003NJ-Gs
	for git@vger.kernel.org; Tue, 03 Oct 2006 21:11:25 +0100
User-Agent: KMail/1.9.4
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28295>

--Boundary-00=_tPsIF/+6CeKFpuX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Still not managed to understand git-send-mail sufficiently well to  not 
accidently miss of this list when I sending it to Junio



Signed-off-by: Alan Chandler <alan@chandlerfamily.org.uk>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index ae80e78..b8e8622 100644
--- a/git.c
+++ b/git.c
@@ -16,7 +16,7 @@ #include "quote.h"
 #include "builtin.h"

 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare]
 [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";

 static void prepend_to_path(const char *dir, int len)
 {
--
1.4.2.1

-------------------------------------------------------

-- 
Alan Chandler
http://www.chandlerfamily.org.uk

--Boundary-00=_tPsIF/+6CeKFpuX
Content-Type: text/plain;
  name="[PATCH] Fix usage string to match that given in the man page"
Content-Transfer-Encoding: 7bit

From: Alan Chandler <alan@chandlerfamily.org.uk>

Signed-off-by: Alan Chandler <alan@chandlerfamily.org.uk>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index ae80e78..b8e8622 100644
--- a/git.c
+++ b/git.c
@@ -16,7 +16,7 @@ #include "quote.h"
 #include "builtin.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
-- 
1.4.2.1


--Boundary-00=_tPsIF/+6CeKFpuX--
