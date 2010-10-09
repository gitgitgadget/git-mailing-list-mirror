From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 01/21] notes.c: Hexify SHA1 in die() message from init_notes()
Date: Sat,  9 Oct 2010 03:08:28 +0200
Message-ID: <1286586528-3473-2-git-send-email-johan@herland.net>
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
	id 1P4Nw8-0001XH-AT
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760109Ab0JIBJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:09:12 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:52247 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760087Ab0JIBJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:09:11 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nvv-00011L-HT; Sat, 09 Oct 2010 03:09:07 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158551>

Signed-off-by: Johan Herland <johan@herland.net>
---

Found this while testing other aspects of this series.

...Johan

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
1.7.3.1.104.g92b87a
