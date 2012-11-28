From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 03:57:33 +0100
Message-ID: <20121128025734.21231.47468.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYLA-0001uW-0W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab2K1D3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:29:21 -0500
Received: from delay-3d.bbox.fr ([194.158.122.137]:60171 "EHLO
	delay-3d.bbox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2K1D3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:29:20 -0500
X-Greylist: delayed 1584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 22:29:20 EST
Received: from mail-4d.bbox.fr (bt8ssscb.cs.dolmen.bouyguestelecom.fr [10.119.71.135])
	by delay-3d.bbox.fr (Postfix) with ESMTP id 3310E34A166
	for <git@vger.kernel.org>; Wed, 28 Nov 2012 04:05:57 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-4d.bbox.fr (Postfix) with ESMTP id A48E145;
	Wed, 28 Nov 2012 04:02:34 +0100 (CET)
X-git-sha1: 3e44b8911909752ebab827029c29d332f2c7a094 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210688>

All the python scripts except contrib/svn-fe/svnrdump_sim.py
start with "#!/usr/bin/env python".

This patch fix contrib/svn-fe/svnrdump_sim.py to do the same.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 contrib/svn-fe/svnrdump_sim.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 1cfac4a..d219180 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 """
 Simulates svnrdump by replaying an existing dump from a file, taking care
 of the specified revision range.
-- 
1.7.11.rc3.17.g55b3f8c
