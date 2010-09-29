From: Johan Herland <johan@herland.net>
Subject: [PATCH 01/18] (trivial) notes.h: Minor documentation fixes to
 copy_notes()
Date: Wed, 29 Sep 2010 02:23:14 +0200
Message-ID: <1285719811-10871-2-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kSg-0000uw-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab0I2AXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:23:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0I2AXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:44 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003XLFRHTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id AFD341EEF82F_CA2870DB	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:41 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 51DA31EEF79D_CA2870DF	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:41 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157498>

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
1.7.3.98.g5ad7d9
