From: nadim khemir <nadim@khemir.net>
Subject: [PATCH] Added EXIT STATUS section in git-status documentation
Date: Mon, 15 Dec 2008 00:12:13 +0100
Message-ID: <200812150012.14071.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC083-0003lx-61
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYLNXKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYLNXKp
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:10:45 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:33987 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751516AbYLNXKo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:10:44 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 2C02F94005A
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 00:10:41 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id 9E91B2F04001
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 00:10:40 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103102>

>From d6438d2f245cf36e5824c5d408c3100a01aae7ad Mon Sep 17 00:00:00 2001

Signed-off-by: nadim khemir <nadim@khemir.net>
---
 Documentation/git-status.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 84f60f3..e49ae2a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -24,10 +24,6 @@ The command takes the same set of options as 'git-commit'; it
 shows what would be committed if the same options are given to
 'git-commit'.
 
-If there is no path that is different between the index file and
-the current HEAD commit (i.e., there is nothing to commit by running
-`git commit`), the command exits with non-zero status.
-
 
 OUTPUT
 ------
@@ -57,6 +53,12 @@ to -1 or an unlimited number), the submodule summary will be enabled and a
 summary of commits for modified submodules will be shown (see --summary-limit
 option of linkgit:git-submodule[1]).
 
+EXIT STATUS
+-----------
+The command exits with status 0 if there is a different between the index
+and HEAD. IE, running `git commit`, with the same arguments as your
+'git status' command, would create a new commit.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
-- 
1.6.1.rc2.20.gde0d
