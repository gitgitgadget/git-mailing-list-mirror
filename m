From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH 2/2] [CLEANUP] use symbolic name as return value
Date: Thu, 26 Jan 2006 12:26:15 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126112615.GC7706@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 26 12:26:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F25Gd-0001qn-Og
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 12:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWAZL0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 06:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAZL0R
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 06:26:17 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:21668 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932301AbWAZL0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 06:26:17 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F25GZ-0000gA-Qx
	for git@vger.kernel.org; Thu, 26 Jan 2006 12:26:15 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0QBQFcH008409
	for <git@vger.kernel.org>; Thu, 26 Jan 2006 12:26:15 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0QBQFXr008408
	for git@vger.kernel.org; Thu, 26 Jan 2006 12:26:15 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15160>

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9acfd0a5f5390460d3de7d3f04610b795f8e69dc
diff --git a/sha1_name.c b/sha1_name.c
index b95ef05..ba0747c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -143,7 +143,7 @@ static int find_unique_short_object(int 
 	}
 	/* Both have unique ones -- do they match? */
 	if (memcmp(packed_sha1, unpacked_sha1, 20))
-		return -2;
+		return SHORT_NAME_AMBIGUOUS;
 	memcpy(sha1, packed_sha1, 20);
 	return 0;
 }
-- 
1.1.4.g3e6c

-- 
Uwe Zeisberger

Set the I_WANT_A_BROKEN_PS environment variable to force BSD syntax ...
	-- manpage of procps
