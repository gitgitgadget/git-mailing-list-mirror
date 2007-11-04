From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] builtin-fetch: Add "-q" as a synonym for "--quiet"
Date: Sat,  3 Nov 2007 19:26:54 -0700
Message-ID: <1194143214-25980-1-git-send-email-koreth@midwinter.com>
Cc: Steven Grimm <koreth@midwinter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoVCq-0000kV-OR
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 03:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbXKDC04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 22:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbXKDC04
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 22:26:56 -0400
Received: from tater.midwinter.com ([216.32.86.90]:33503 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756343AbXKDC0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 22:26:55 -0400
Received: (qmail 20087 invoked from network); 4 Nov 2007 02:26:55 -0000
Received: from out031.sctm.tfbnw.net (HELO localhost.localdomain) (koreth@204.15.20.158)
  by tater.midwinter.com with SMTP; 4 Nov 2007 02:26:55 -0000
X-Mailer: git-send-email 1.5.3.5.529.ge3d6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63336>

"-q" is the very first option described in the git-fetch manpage, and it
isn't supported.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 builtin-fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 003ed76..8e79055 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -517,7 +517,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			depth = argv[i];
 			continue;
 		}
-		if (!strcmp(arg, "--quiet")) {
+		if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
 			quiet = 1;
 			continue;
 		}
-- 
1.5.3.5.529.ge3d6d-dirty
