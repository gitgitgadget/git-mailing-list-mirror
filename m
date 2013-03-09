From: Michael Fallows <michael@fallo.ws>
Subject: [PATCH] git.c: Remove unnecessary new line
Date: Sat, 09 Mar 2013 22:13:23 +0000
Message-ID: <513BB403.2080103@fallo.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 23:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UES1c-00018E-Vy
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 23:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3CIWNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 17:13:30 -0500
Received: from uk-dedi-rs-01.svrz.com ([87.117.195.124]:42688 "EHLO
	uk-dedi-rs-01.svrz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab3CIWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 17:13:28 -0500
X-Greylist: delayed 1517 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 17:13:28 EST
Received: from cpc9-tilb8-2-0-cust26.basl.cable.virginmedia.com ([62.31.243.27]:56379 helo=[192.168.1.222])
	by uk-dedi-rs-01.svrz.com with esmtpa (Exim 4.80)
	(envelope-from <michael@fallo.ws>)
	id 1UES13-00062F-VF; Sat, 09 Mar 2013 22:13:21 +0000
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217769>

New line on checkout-index is inconsistent with the rest of the commands

Signed-off-by: Michael Fallows <michael@fallo.ws>
---
  git.c |    3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git.c b/git.c
index b10c18b..b4d7bbb 100644
--- a/git.c
+++ b/git.c
@@ -316,8 +316,7 @@ static void handle_internal_command(int argc, const 
char **argv)
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
