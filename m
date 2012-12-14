From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] README: Git is released under the GPLv2, not just "the GPL"
Date: Fri, 14 Dec 2012 16:37:47 +0100
Message-ID: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 16:38:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjXL9-0006a1-Rh
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 16:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab2LNPiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 10:38:02 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37892 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217Ab2LNPiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 10:38:01 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1815711bkw.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AhNz5phyb2nb0ZnMZYQqI+wPsJh1xEQTIx50SWvb6sU=;
        b=pzGAlL043Wi+37beYffrMIjXO9fjoi5Mb4F8ihnV6iCIMKReiA91o2inPvH+jKxoSC
         kTFsaX2X9EiUWi6sw0l8krXKuC1Kvus6o2N7gbCbKkiuncfAzfyt6og4o5mSFenTQcL0
         UZ/6D1aEr5E/NaQX+76QAoQC+2C3bsknfAPOWZ4+Bq3CyFG2kyIoLQZNBA/1RK0qfdG6
         jTtom4gETOdK+ksPXII06D26vsOH8yN4ADo5zzQnBO3LOstkrrTLU1TggU3DFdkInq7H
         OHllaktsU74CGqs0flpvCHrVZytHxJz0JhzAaZCKwUYIb3L3FyaMcAAc6l/BHHnV6NCL
         jyrg==
Received: by 10.204.127.27 with SMTP id e27mr2945835bks.126.1355499480001;
        Fri, 14 Dec 2012 07:38:00 -0800 (PST)
Received: from localhost.localdomain (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id c10sm4916530bkw.1.2012.12.14.07.37.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2012 07:37:59 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.347.gf94c325
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211493>

And this is clearly stressed by Linus in the COPYING file.  So make it
clear in the README as well, to avoid possible misunderstandings.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 README | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/README b/README
index d2690ec..c50e6f4 100644
--- a/README
+++ b/README
@@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-Git is an Open Source project covered by the GNU General Public License.
-It was originally written by Linus Torvalds with help of a group of
-hackers around the net. It is currently maintained by Junio C Hamano.
+Git is an Open Source project covered by the GNU General Public License
+(version 2).  It was originally written by Linus Torvalds with help
+of a group of hackers around the net. It is currently maintained by
+Junio C Hamano.
 
 Please read the file INSTALL for installation instructions.
 
-- 
1.8.0.1.347.gf94c325
