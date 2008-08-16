From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: document the pager.* configuration setting
Date: Sat, 16 Aug 2008 04:14:33 +0200
Message-ID: <1218852873-10588-1-git-send-email-vmiklos@frugalware.org>
References: <1218852584-10523-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 04:15:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUBJs-0000XD-20
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 04:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYHPCOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 22:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYHPCOE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 22:14:04 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39101 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYHPCOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 22:14:03 -0400
Received: from vmobile.example.net (dsl5401C01F.pool.t-online.hu [84.1.192.31])
	by yugo.frugalware.org (Postfix) with ESMTP id D853B1DDC5B;
	Sat, 16 Aug 2008 04:14:00 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 75C041A5FBF; Sat, 16 Aug 2008 04:14:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <1218852584-10523-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92527>

It was already documented in RelNotes-1.6.0, but not in the git-config
manual page.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Ugh, I just noticed that the example was wrong, because paging for
status is disabled by default. Here is a corrected version.

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
index 28e1861..c0bc6fa 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -315,6 +315,12 @@ RESET=$(git config --get-color "" "reset")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
 
+To enable the pager for linkgit:git-status[1]:
+
+------------
+% git config pager.status true
+------------
+
 include::config.txt[]
 
 
-- 
1.6.0.rc0.14.g95f8.dirty
