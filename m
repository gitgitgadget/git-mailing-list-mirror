From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH] init-db.c: fix stupid typo
Date: Tue, 19 Apr 2005 13:31:00 -0700
Message-ID: <mailbox-25052-1113942660-25966@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 22:27:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNzJ7-0006h0-8p
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVDSUbC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDSUbC
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 16:31:02 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:54414 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261655AbVDSUbB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 16:31:01 -0400
Received: (qmail 25055 invoked by uid 5006); 19 Apr 2005 13:31:00 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-730821@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix a stupid typo from the last mkdir refactorng patch.

 init-db.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>


--- a/init-db.c	2005-04-19 13:06:11.000000000 -0700
+++ a/init-db.c	2005-04-19 13:06:16.000000000 -0700
@@ -11,7 +11,7 @@
  * be the judge.  The default case is to have a DB per managed directory.
  */
 
-static void create_dir(char *path) 
+static void create_dir(char *dir) 
 {
 	if (mkdir(dir, 0755) < 0) {
 		if (errno != EEXIST) {
There are 0 patches in this series:
