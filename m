From: rocketraman@fastmail.fm
Subject: [PATCH 1/2] Add feature release instructions to MaintNotes addendum
Date: Mon, 30 Mar 2009 01:35:18 -0400
Message-ID: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 07:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoABB-0001bV-5G
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbZC3FfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbZC3FfY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:35:24 -0400
Received: from smtp132.rog.mail.re2.yahoo.com ([206.190.53.37]:35886 "HELO
	smtp132.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752317AbZC3FfY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 01:35:24 -0400
Received: (qmail 87815 invoked from network); 30 Mar 2009 05:35:21 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp132.rog.mail.re2.yahoo.com with SMTP; 30 Mar 2009 05:35:21 -0000
X-YMail-OSG: 4jD4erIVM1l_R_dlUTYAmoy4thJao6p8SUaRpm9J.N0_Xhmn2joLKJnXh95rF95xjQ--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 8CD1A21C051B
	for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:35:20 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xY1fp+vBkeAO for <git@vger.kernel.org>;
	Mon, 30 Mar 2009 01:35:20 -0400 (EDT)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id 35E6721C04F1
	for <git@vger.kernel.org>; Mon, 30 Mar 2009 01:35:19 -0400 (EDT)
Received: by zeus (sSMTP sendmail emulation); Mon, 30 Mar 2009 01:35:19 -0400
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115079>

From: Raman Gupta <raman@rocketraman.com>

Based on a mailing list discussion, add the operations for creating a
feature release.

Signed-off-by: Raman Gupta <raman@rocketraman.com>
---
 Documentation/howto/maintain-git.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 4357e26..f8b7614 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -244,6 +244,27 @@ by doing the following:
    repo.or.cz
 
 
+A feature release of git is made by tagging 'master' with a tag
+matching vX.Y.Z, where X.Y.Z is the feature release version.
+
+ - Optionally, track the current 'maint' branch to support
+   new releases for the older codebase if necessary.
+
+     $ git branch maint-X.Y.(Z-1) maint
+
+ - The 'maint' branch is updated to the new release.
+
+     $ git branch -f maint master
+
+ - The 'next' branch may be rebuilt from the tip of 'master'
+   using the surviving topics on 'next'.
+
+     $ git branch -f next master
+     $ git merge ai/topic_in_next1
+     $ git merge ai/topic_in_next2
+     ...
+
+
 Some observations to be made.
 
  * Each topic is tested individually, and also together with
-- 
1.6.2
