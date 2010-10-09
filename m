From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 02/21] (trivial) notes.h: Minor documentation fixes to copy_notes()
Date: Sat,  9 Oct 2010 03:08:29 +0200
Message-ID: <1286586528-3473-3-git-send-email-johan@herland.net>
References: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4NwA-0001XH-0g
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760098Ab0JIBJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:09:11 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:52248 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759930Ab0JIBJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:09:11 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nvw-00011L-9K; Sat, 09 Oct 2010 03:09:08 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158553>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/notes.h b/notes.h
index 65fc3a6..c0288b0 100644
--- a/notes.h
+++ b/notes.h
@@ -104,6 +104,10 @@ const unsigned char *get_note(struct notes_tree *t,
  * Copy a note from one object to another in the given notes_tree.
  *
  * Fails if the to_obj already has a note unless 'force' is true.
+ *
+ * IMPORTANT: The changes made by copy_note() to the given notes_tree structure
+ * are not persistent until a subsequent call to write_notes_tree() returns
+ * zero.
  */
 int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
@@ -149,6 +153,7 @@ int copy_note(struct notes_tree *t,
  * notes tree) from within the callback:
  * - add_note()
  * - remove_note()
+ * - copy_note()
  * - free_notes()
  */
 typedef int each_note_fn(const unsigned char *object_sha1,
-- 
1.7.3.1.104.g92b87a
