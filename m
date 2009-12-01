From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: Fix a few i.e./e.g. mix-ups
Date: Tue,  1 Dec 2009 10:19:05 +0100
Message-ID: <81ffa57ff9292b0a85e812c14154a2291aa3c2f9.1259658926.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 10:20:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOuI-0003kq-L4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbZLAJUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 04:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbZLAJUN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:20:13 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59911 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841AbZLAJUL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 04:20:11 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 00BF1C6178;
	Tue,  1 Dec 2009 04:20:17 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 01 Dec 2009 04:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=AS9bkHRrG8lduQXWpxRaZgAUbTQ=; b=V5V5U+PCeof9WPHqkBt0qjn8ozTxi7z+yLkDxuAf1JbZAo4IZcs9C1VVHQ8QPMWdHnAOdzJCUCkKyvvfMlEmTHNfZ2WGc19StF7zFQZHi8djTuJcJ/dcZGcjda0QvTXoAEzYR8SLTVffo2RtLpG3teioa5GKGsGRf6qfmpnI4+A=
X-Sasl-enc: oAjERswF0OtuseG0b5rEkVEtfcotyGMmpsTFV+YU6r8s 1259659217
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6E45613BE7;
	Tue,  1 Dec 2009 04:20:17 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134186>

A git bundle can be transported by several means (such as e-mail), not
only by snekaernet, so use e.g. instead of i.e.

The mix-up in git-bundle.txt is obvious.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bundle.txt       |    2 +-
 Documentation/gitcore-tutorial.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index aee7e4a..c3a066e 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -24,7 +24,7 @@ ssh, rsync, http) cannot be used.  This command provides support for
 'git-fetch' and 'git-pull' to operate by packaging objects and references
 in an archive at the originating machine, then importing those into
 another repository using 'git-fetch' and 'git-pull'
-after moving the archive by some means (i.e., by sneakernet).  As no
+after moving the archive by some means (e.g., by sneakernet).  As no
 direct connection between the repositories exists, the user must specify a
 basis for the bundle that is held by the destination repository: the
 bundle assumes that all objects in the basis are already in the
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index e237394..f762dca 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -602,7 +602,7 @@ $ git tag -s <tagname>
 ----------------
 
 which will sign the current `HEAD` (but you can also give it another
-argument that specifies the thing to tag, i.e., you could have tagged the
+argument that specifies the thing to tag, e.g., you could have tagged the
 current `mybranch` point by using `git tag <tagname> mybranch`).
 
 You normally only do signed tags for major releases or things
-- 
1.6.6.rc0.274.g71380
