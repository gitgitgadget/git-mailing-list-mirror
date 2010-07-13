From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 1/5] ui-stats: Remove unnecessary #include
Date: Tue, 13 Jul 2010 23:40:17 +0200
Message-ID: <1279057221-28036-2-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnDr-0004WU-OV
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab0GMVkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:40 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab0GMVkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:36 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00AU2MVMA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 44FA01EA5AF0_C3CDD52B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1C3901EA292D_C3CDD52F	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00782MVL0N10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150926>

<string-list.h> is already #included from cgit.h

Signed-off-by: Johan Herland <johan@herland.net>
---
 ui-stats.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/ui-stats.c b/ui-stats.c
index bdaf9cc..e8ea57a 100644
--- a/ui-stats.c
+++ b/ui-stats.c
@@ -1,5 +1,3 @@
-#include <string-list.h>
-
 #include "cgit.h"
 #include "html.h"
 #include "ui-shared.h"
-- 
1.7.0.4
