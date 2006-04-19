From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] sha1_name.c: no need to include diff.h; tree-walk.h will do.
Date: Wed, 19 Apr 2006 13:01:20 -0700
Message-ID: <7v1wvt8hdb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 19 22:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWIri-0006zn-0N
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 22:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDSUBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 16:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDSUBW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 16:01:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57045 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751157AbWDSUBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 16:01:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419200121.WXU17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 16:01:21 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18935>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * Just a clean-up, comes on top of the one that returns mode
   from get_tree_entry().

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 35e8dfb..7ad20b5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -3,7 +3,7 @@ #include "tag.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
-#include "diff.h"
+#include "tree-walk.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
-- 
1.3.0.g2c4a
