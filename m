From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/6] Remove outdated warnings from the README
Date: Mon,  4 Aug 2008 19:47:14 -0700
Message-ID: <1217904436-1989-5-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
 <1217904436-1989-2-git-send-email-spearce@spearce.org>
 <1217904436-1989-3-git-send-email-spearce@spearce.org>
 <1217904436-1989-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCbW-0006tq-3u
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590AbYHECrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757569AbYHECrc
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:32 -0400
Received: from george.spearce.org ([209.20.77.23]:45388 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844AbYHECrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C223338419; Tue,  5 Aug 2008 02:47:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3A07338419;
	Tue,  5 Aug 2008 02:47:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91415>

We no longer fear the jgit library eating a repository, or causing
other sorts of corruption.  Nor do we fear the Eclipse plugin
locking up your workbench, as it just has never happened.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 README |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/README b/README
index db11c25..e18a9eb 100644
--- a/README
+++ b/README
@@ -66,15 +66,6 @@ three for packaging.
 
             == WARNINGS / CAVEATS              ==
 
-- The plugin could lockup your Eclipse workbench.  I've tried to
-  make it stable and function in such a way that it can't crash
-  the workbench, but that doesn't mean it won't.  :-)
-
-- This package might eat your files.  Everything I've added to a
-  repository with it has unpacked properly both with itself and
-  with the canonical C based implementation, but that doesn't mean
-  it won't generate a corrupt object.
-
 - Symbolic links are not supported because java does not support it.
   Such links could be damaged.
 
@@ -88,10 +79,6 @@ three for packaging.
   have no information about other vendors. Please report your findings
   if you try.
 
-- Do not trust this plugin to always do the right thing (yet). Please
-  check with the real Git and report any problems.
-
-
             == COMPATIBILITY                   ==
 
 - Eclipse 3.3.1 is the minimum Eclipse version, 3.4 is preferred.
-- 
1.6.0.rc1.250.g9b5e2
