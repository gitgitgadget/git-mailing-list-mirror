From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/5] revision: Fix typo in --ancestry-path error message
Date: Fri, 04 Jun 2010 01:17:36 +0200
Message-ID: <1275607057-26645-5-git-send-email-johan@herland.net>
References: <1275607057-26645-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 01:18:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKJg5-0007LN-8m
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 01:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab0FCXSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 19:18:13 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40874 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510Ab0FCXSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 19:18:09 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G00DC6OQ9CWC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E4CA61EA54CD_C083830B	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CD7941EA280B_C083830F	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:18:08 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G007W6OPOV330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:18:08 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1275607057-26645-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148372>

Signed-off-by: Johan Herland <johan@herland.net>
---
 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index cb91094..7eeadb4 100644
--- a/revision.c
+++ b/revision.c
@@ -751,7 +751,7 @@ static int limit_list(struct rev_info *revs)
 	if (revs->ancestry_path) {
 		bottom = collect_bottom_commits(list);
 		if (!bottom)
-			die("--ancestry-path given but there is no bottom commits");
+			die("--ancestry-path given but there are no bottom commits");
 	}

 	while (list) {
--
1.7.0.4
