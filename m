From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: document the pager.* configuration setting
Date: Sat, 16 Aug 2008 04:09:44 +0200
Message-ID: <1218852584-10523-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 04:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUBFC-0008Fn-Vb
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 04:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbYHPCJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 22:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYHPCJP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 22:09:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53294 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYHPCJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 22:09:15 -0400
Received: from vmobile.example.net (dsl5401C01F.pool.t-online.hu [84.1.192.31])
	by yugo.frugalware.org (Postfix) with ESMTP id C67B41DDC5B;
	Sat, 16 Aug 2008 04:09:12 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AE9191A5FBF; Sat, 16 Aug 2008 04:09:44 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92526>

It was already documented in RelNotes-1.6.0, but not in the git-config
manual page.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/config.txt     |    5 +++++
 Documentation/git-config.txt |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b8ec01c..676c39b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -978,6 +978,11 @@ pack.packSizeLimit::
 	can be overridden by the `\--max-pack-size` option of
 	linkgit:git-repack[1].
 
+pager.<cmd>::
+	Allows to set your own pager preferences for each command, overriding
+	the default. If `\--pager` or `\--no-pager` is specified on the command
+	line, it takes precedence over this option.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..d869942 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -315,6 +315,12 @@ RESET=$(git config --get-color "" "reset")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
 
+To disable the pager for linkgit:git-status[1]:
+
+------------
+% git config pager.status false
+------------
+
 include::config.txt[]
 
 
-- 
1.6.0.rc0.14.g95f8.dirty
