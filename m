From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] pick: remove useless PICK_REVERSE => PICK_ADD_NOTE code
Date: Sat, 01 Aug 2009 17:46:05 +0200
Message-ID: <20090801154607.20922.74121.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 17:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXGpM-0000FT-QG
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbZHAPsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbZHAPsL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 11:48:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36484 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbZHAPsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 11:48:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CC024818057;
	Sat,  1 Aug 2009 17:48:00 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 915DA818050;
	Sat,  1 Aug 2009 17:47:57 +0200 (CEST)
X-git-sha1: cdd1bc7a00cbc0598362267a62b60a02d6ad779a 
X-Mailer: git-mail-commits v0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124630>

Junio noticed that the removed code was useless.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/pick.c b/pick.c
index 13bf793..a6b1d6f 100644
--- a/pick.c
+++ b/pick.c
@@ -84,9 +84,6 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 	strbuf_init(msg, 0);
 	commit = pick_commit;
 
-	if (flags & PICK_REVERSE) /* REVERSE implies ADD_NOTE */
-		flags |= PICK_ADD_NOTE;
-
 	/*
 	 * We do not intend to commit immediately.  We just want to
 	 * merge the differences in, so let's compute the tree
-- 
1.6.4.133.g8a5c8
