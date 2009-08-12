From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/13] pick: simplify bogus comment about commiting immediately
Date: Wed, 12 Aug 2009 07:15:47 +0200
Message-ID: <20090812051552.18155.65040.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6Os-000460-LL
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbZHLF2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbZHLF2L
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47773 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4B98F81810D;
	Wed, 12 Aug 2009 07:27:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0F3318180EC;
	Wed, 12 Aug 2009 07:27:56 +0200 (CEST)
X-git-sha1: 58ddd3beb110a59bdc14c29f2b543e90a169e5a2 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125668>

as suggested by Junio.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/pick.c b/pick.c
index a6b1d6f..058b877 100644
--- a/pick.c
+++ b/pick.c
@@ -85,10 +85,8 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 	commit = pick_commit;
 
 	/*
-	 * We do not intend to commit immediately.  We just want to
-	 * merge the differences in, so let's compute the tree
-	 * that represents the "current" state for merge-recursive
-	 * to work on.
+	 * Let's compute the tree that represents the "current" state
+	 * for merge-recursive to work on.
 	 */
 	if (write_cache_as_tree(head, 0, NULL))
 		return error("Your index file is unmerged.");
-- 
1.6.4.271.ge010d
