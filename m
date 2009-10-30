From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Fri, 30 Oct 2009 18:20:28 +0100
Message-ID: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, spearce@spearce.org, sasa.zivkov@sap.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3v9n-0008KD-Qa
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbZJ3RUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbZJ3RUo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:20:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:6917 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbZJ3RUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 13:20:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4C1E4143E63A;
	Fri, 30 Oct 2009 18:20:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hM4ZR+aRgxn9; Fri, 30 Oct 2009 18:20:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 7D304146A837;
	Fri, 30 Oct 2009 18:20:46 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2.102.g1f8896
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131717>

Git itself does not even look at this directory. Any tools that
actually needs it should create it itself.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 templates/branches-- |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 templates/branches--

Shawn and other wants to stop JGit from creating this directory on
init with the motivation that newer Git version doesn't create it
anymore. This patch would make that assertion true.

-- robin

diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae8870..0000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
-- 
1.6.5.2.102.g1f8896
