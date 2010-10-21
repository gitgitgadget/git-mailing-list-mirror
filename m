From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 01/21] notes.c: Hexify SHA1 in die() message from init_notes()
Date: Thu, 21 Oct 2010 04:08:36 +0200
Message-ID: <1287626936-32232-2-git-send-email-johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 04:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kat-0007cL-NB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816Ab0JUCJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:09:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33116 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756755Ab0JUCJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:09:03 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00IP9BB1YX70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:01 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 368EF1EA5801_CBFA0BDB	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9FE821EA2896_CBFA0BCF	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:00 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM0096KBB03500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:00 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287626936-32232-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159458>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index 1978244..bb03eb0 100644
--- a/notes.c
+++ b/notes.c
@@ -940,7 +940,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (get_tree_entry(object_sha1, "", sha1, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
-		    notes_ref, object_sha1);
+		    notes_ref, sha1_to_hex(object_sha1));
 
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
-- 
1.7.3.98.g5ad7d9
