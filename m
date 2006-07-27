From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Remove -d from *-fetch usage strings
Date: Thu, 27 Jul 2006 20:58:53 +0200
Message-ID: <20060727185853.32107.32772.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 20:59:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6B4Y-0001TX-I3
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 20:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWG0S67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 14:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWG0S67
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 14:58:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49552 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751950AbWG0S65 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 14:58:57 -0400
Received: (qmail 32118 invoked from network); 27 Jul 2006 20:58:54 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 20:58:54 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24331>

This is a really ancient remnant of the short era of delta objects stored
directly in the object database.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 http-fetch.c  |    2 +-
 local-fetch.c |    2 +-
 ssh-fetch.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 12493fb..dc286b7 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1245,7 +1245,7 @@ int main(int argc, char **argv)
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-http-fetch [-c] [-t] [-a] [-d] [-v] [--recover] [-w ref] commit-id url");
+		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
diff --git a/local-fetch.c b/local-fetch.c
index ffa4887..65a803a 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -194,7 +194,7 @@ int fetch_ref(char *ref, unsigned char *
 }
 
 static const char local_pull_usage[] =
-"git-local-fetch [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path";
+"git-local-fetch [-c] [-t] [-a] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path";
 
 /* 
  * By default we only use file copy.
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 28f7fd9..a8a6cfb 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -120,7 +120,7 @@ int fetch_ref(char *ref, unsigned char *
 
 static const char ssh_fetch_usage[] =
   MY_PROGRAM_NAME
-  " [-c] [-t] [-a] [-v] [-d] [--recover] [-w ref] commit-id url";
+  " [-c] [-t] [-a] [-v] [--recover] [-w ref] commit-id url";
 int main(int argc, char **argv)
 {
 	char *commit_id;
