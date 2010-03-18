From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] notes.c: don't call 'return' in a void function
Date: Thu, 18 Mar 2010 09:50:37 -0500
Message-ID: <m6P-Qdljqt7xCgOUC581DdkndLOwc9aVqzGi_vEsC8UeEeGnpREXOnx-fSQIkTfaqsh9HzzlXIM@cipher.nrlssc.navy.mil>
Cc: johan@herland.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 18 15:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsH7g-0006GS-Sw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab0CROyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 10:54:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54247 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab0CROyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 10:54:50 -0400
Received: by mail.nrlssc.navy.mil id o2IEp0Ok003943; Thu, 18 Mar 2010 09:51:00 -0500
X-OriginalArrivalTime: 18 Mar 2010 14:51:00.0416 (UTC) FILETIME=[6CB71C00:01CAC6AA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142475>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index a4f9926..07941b7 100644
--- a/notes.c
+++ b/notes.c
@@ -893,7 +893,7 @@ void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	assert(t->initialized);
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
-	return note_tree_remove(t, t->root, 0, &l);
+	note_tree_remove(t, t->root, 0, &l);
 }
 
 const unsigned char *get_note(struct notes_tree *t,
-- 
1.6.6.2
