From: Michael Fallows <michael@fallo.ws>
Subject: [PATCH] git.c: Remove unnecessary new line
Date: Sat, 09 Mar 2013 21:48:06 +0000
Message-ID: <513BAE16.4060706@fallo.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 00:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UESn5-0005jP-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 00:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab3CIXCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 18:02:34 -0500
Received: from uk-dedi-rs-01.svrz.com ([87.117.195.124]:45989 "EHLO
	uk-dedi-rs-01.svrz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab3CIXCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 18:02:33 -0500
Received: from cpc9-tilb8-2-0-cust26.basl.cable.virginmedia.com ([62.31.243.27]:56167 helo=[192.168.1.222])
	by uk-dedi-rs-01.svrz.com with esmtpa (Exim 4.80)
	(envelope-from <michael@fallo.ws>)
	id 1UERca-0005VD-Q8; Sat, 09 Mar 2013 21:48:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uk-dedi-rs-01.svrz.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fallo.ws
X-Get-Message-Sender-Via: uk-dedi-rs-01.svrz.com: authenticated_id: michael@htmlland.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217771>

>From 8750dc231a2b973efa18aff4dbc5b2ace7c79c47 Mon Sep 17 00:00:00 2001
From: Michael Fallows <michael@fallo.ws>
Date: Sat, 9 Mar 2013 21:47:11 +0000
Subject: [PATCH] git.c: Remove unnecessary new line

New line on checkout-index is inconsistent with the rest of the commands

Signed-off-by: Michael Fallows <michael@fallo.ws>
---
 git.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git.c b/git.c
index b10c18b..b4d7bbb 100644
--- a/git.c
+++ b/git.c
@@ -316,8 +316,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
-		{ "checkout-index", cmd_checkout_index,
-			RUN_SETUP | NEED_WORK_TREE},
+		{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
-- 
1.7.9.5
