From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Add otherwise missing --strict option to unpack-objects summary.
Date: Wed, 23 Apr 2008 16:14:30 -0500
Message-ID: <1208985270-27147-1-git-send-email-jdl@freescale.com>
Cc: Jon Loeliger <jdl@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 23:15:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JomJQ-0008B7-K4
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 23:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbYDWVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYDWVOm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 17:14:42 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:39197 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYDWVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 17:14:42 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m3NLEXL2017508
	for <git@vger.kernel.org>; Wed, 23 Apr 2008 14:14:34 -0700 (MST)
Received: from ld0161-tx32.am.freescale.net (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3NLEVG8013795
	for <git@vger.kernel.org>; Wed, 23 Apr 2008 16:14:32 -0500 (CDT)
Received: by ld0161-tx32.am.freescale.net (Postfix, from userid 12040105)
	id BC8A33005B; Wed, 23 Apr 2008 16:14:30 -0500 (CDT)
X-Mailer: git-send-email 1.5.5.49.gf43e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80260>

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

The option --pack_header= is also not documented here
and in git-fetch-pack (others?), but it seems like that
might have been intentional?  It look like it is the
pack header version number and object count.  Dunno.


 Documentation/git-unpack-objects.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 3697896..50947c5 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,7 +8,7 @@ git-unpack-objects - Unpack objects from a packed archive
 
 SYNOPSIS
 --------
-'git-unpack-objects' [-n] [-q] [-r] <pack-file
+'git-unpack-objects' [-n] [-q] [-r] [--strict] <pack-file
 
 
 DESCRIPTION
-- 
1.5.5.49.gf43e2
