From: Steven Drake <sdrake@ihug.co.nz>
Subject: [PATCH] timezone_names[]: fixed the tz offset for New Zealand.
Date: Tue, 26 Feb 2008 13:45:53 +1300 (NZDT)
Message-ID: <Pine.LNX.4.64.0802261343260.20664@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 01:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTo7o-0007iN-5f
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbYBZA4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYBZA4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:56:16 -0500
Received: from mailfilter1.ihug.co.nz ([203.109.136.1]:18085 "EHLO
	mailfilter1.ihug.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYBZA4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:56:16 -0500
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2008 19:56:15 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlwPAFPwwkfLrc6H/2dsb2JhbACBO2mpUYF5
X-IronPort-AV: E=Sophos;i="4.25,404,1199617200"; 
   d="scan'208";a="72124041"
Ironport-Content-Filter: send-to-smtp
Ironport-OCF: send-to-smtp
Received: from 203-173-206-135.dialup.ihug.co.nz ([203.173.206.135])
  by smtp.mailfilter1.ihug.co.nz with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Feb 2008 13:46:01 +1300
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75098>

---
 date.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 8f70500..a74ed86 100644
--- a/date.c
+++ b/date.c
@@ -213,9 +213,9 @@ static const struct {
 	{ "EAST", +10, 0, },	/* Eastern Australian Standard */
 	{ "EADT", +10, 1, },	/* Eastern Australian Daylight */
 	{ "GST",  +10, 0, },	/* Guam Standard, USSR Zone 9 */
-	{ "NZT",  +11, 0, },	/* New Zealand */
-	{ "NZST", +11, 0, },	/* New Zealand Standard */
-	{ "NZDT", +11, 1, },	/* New Zealand Daylight */
+	{ "NZT",  +12, 0, },	/* New Zealand */
+	{ "NZST", +12, 0, },	/* New Zealand Standard */
+	{ "NZDT", +12, 1, },	/* New Zealand Daylight */
 	{ "IDLE", +12, 0, },	/* International Date Line East */
 };
 
-- 
1.5.0.3
