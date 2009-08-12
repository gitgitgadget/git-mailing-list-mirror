From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/13] pick: remove useless PICK_REVERSE => PICK_ADD_NOTE code
Date: Wed, 12 Aug 2009 07:15:46 +0200
Message-ID: <20090812051552.18155.22076.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6O1-0003mw-1p
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZHLF2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbZHLF2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:16 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47769 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B591781810F;
	Wed, 12 Aug 2009 07:27:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B234F8180D3;
	Wed, 12 Aug 2009 07:27:55 +0200 (CEST)
X-git-sha1: 3fbba184e3886bcccf96191723f40b876f921468 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Useless of the removed code was found by Junio.

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
1.6.4.271.ge010d
