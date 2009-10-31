From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 20/28] http-backend: more explict LocationMatch
Date: Fri, 30 Oct 2009 17:47:39 -0700
Message-ID: <1256950067-27938-22-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429v-0001yQ-3Q
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbZJaAtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbZJaAsd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:33 -0400
Received: from george.spearce.org ([209.20.77.23]:36953 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbZJaAr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 37EB538200; Sat, 31 Oct 2009 00:48:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5C9293821F;
	Sat, 31 Oct 2009 00:47:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131802>

From: Mark Lodato <lodatom@gmail.com>

In the git-http-backend examples, only match git-receive-pack within
/git/.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 2989c9f..f17251a 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -69,7 +69,7 @@ To enable anonymous read access but authenticated write access,
 require authorization with a LocationMatch directive:
 +
 ----------------------------------------------------------------
-<LocationMatch ".*/git-receive-pack$">
+<LocationMatch "^/git/.*/git-receive-pack$">
 	AuthType Basic
 	AuthName "Git Access"
 	Require group committers
-- 
1.6.5.2.181.gd6f41
