From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Do not use C++-style comments
Date: Mon, 22 Aug 2011 12:33:52 +0200
Message-ID: <1314009232-6194-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 12:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvRpf-0000bN-Be
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 12:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab1HVKeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 06:34:10 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:49914 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756757Ab1HVKeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 06:34:08 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QvRmE-0002t9-Gz; Mon, 22 Aug 2011 12:30:42 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179854>

Detected by "gcc -std=iso9899:1990 ...".  This patch applies against
"maint".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index f6ce848..93e9868 100644
--- a/notes.c
+++ b/notes.c
@@ -1105,7 +1105,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
 	note_tree_remove(t, t->root, 0, &l);
-	if (is_null_sha1(l.val_sha1)) // no note was removed
+	if (is_null_sha1(l.val_sha1)) /* no note was removed */
 		return 1;
 	t->dirty = 1;
 	return 0;
-- 
1.7.6.8.gd2879
