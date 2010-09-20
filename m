From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 1/2] Command names should not be translated.
Date: Mon, 20 Sep 2010 09:00:00 +0100
Message-ID: <20100920080037.62EB02FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, avarab@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 20 10:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbJG-0004Qs-6c
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab0ITIAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:00:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:61286 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066Ab0ITIAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:00:40 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9100BCMCX12A90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Sep 2010 10:00:37 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A68F21EEEDEC_C9714A5B	for <git@vger.kernel.org>; Mon,
 20 Sep 2010 08:00:37 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 90E9B1EEEDE9_C9714A5F	for <git@vger.kernel.org>; Mon,
 20 Sep 2010 08:00:37 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9100ISFCX1AI40@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Sep 2010 10:00:37 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id 62EB02FC00; Mon,
 20 Sep 2010 10:00:37 +0200 (CEST)
Message.Id: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156554>

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 wt-status.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index f6946e1..7d4719f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -663,9 +663,9 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked"), _("add"));
+		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f"));
+			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
 	} else if (s->commitable)
 		fprintf(s->fp, _("# Untracked files not listed%s\n"),
 			advice_status_hints
-- 
1.7.1
