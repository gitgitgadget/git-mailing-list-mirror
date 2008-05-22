From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Clarify repack -n documentation
Date: Thu, 22 May 2008 08:47:19 -0400
Message-ID: <20080522124719.GA9152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 14:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzADV-0004WF-SG
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761244AbYEVMrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761291AbYEVMrX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:47:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55860 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761102AbYEVMrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:47:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzACS-0005Oe-LU; Thu, 22 May 2008 08:47:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A60420FBAE; Thu, 22 May 2008 08:47:19 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82620>

While repacking a local repository a coworker thought the -n option
was necessary to git-repack to keep it from updating some unknown
file on the central server we all share.  Explaining further what
the option is (not) doing helps to make it clear the option does
not impact any remote repositories the user may have configured.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-repack.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 3d95749..d14ab51 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -55,8 +55,11 @@ OPTIONS
 	linkgit:git-pack-objects[1].
 
 -n::
-        Do not update the server information with
-        `git update-server-info`.
+	Do not update the server information with
+	`git update-server-info`.  This option skips
+	updating local catalog files needed to publish
+	this repository (or a direct copy of it)
+	over HTTP or FTP.  See gitlink:git-update-server-info[1].
 
 --window=[N], --depth=[N]::
 	These two options affect how the objects contained in the pack are
-- 
1.5.5.1.501.gefb4
