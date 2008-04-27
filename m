From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] Documentation gitk: Describe what --merge does
Date: Sun, 27 Apr 2008 17:51:09 +0200
Message-ID: <1209311469-7561-1-git-send-email-richard.quirk@gmail.com>
Cc: Richard Quirk <richard.quirk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 17:52:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq9AX-0002Xq-OL
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbYD0PvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYD0PvO
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:51:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:59116 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYD0PvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:51:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1739474nfb.21
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=T7edm97ugPkOaw77kqBo/lxtldouoes9y6Vvh/Zq71g=;
        b=o+hHIWjJTaWeBdZp4f6hkjvofgpBmgEtNqw8V4GQOo3k24HQsRy+k1NFOGiuyS8/US47In7k8N0vFDVbuGxxhGcMwDA1RBv3KV96sD43tUyQh30XnQpgZb9FLPHsHgpSplo59FmtM8i7CJkO6ukGL8+v6eO8JJeNG22AAOLETJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XZ/TxKjzFpJzPseo63pXVWuNSoO3BF25L8McK+1vY8rDTf3UPWfpqr9D3douofE244AVLJ817KNtaXzwvN1336yt2VTQjpzPvXVW0wE/9t8hyOod7f/yujkSeuRrO7hUiGwPQFmze2RsM7w3NQeEFso5BkzrrxsUzzY9p8aj/5A=
Received: by 10.210.30.1 with SMTP id d1mr4779355ebd.91.1209311472820;
        Sun, 27 Apr 2008 08:51:12 -0700 (PDT)
Received: from localhost ( [84.77.29.188])
        by mx.google.com with ESMTPS id f4sm35902365nfh.26.2008.04.27.08.51.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Apr 2008 08:51:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.79.g57cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80454>

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---
 Documentation/gitk.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index ed3ba83..edd6547 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,11 @@ frequently used options.
 
 	Show all branches.
 
+--merge::
+
+	Show the differences between HEAD and MERGE_HEAD for files with
+	conflicts after a merge.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.5.5.1.79.g57cf
