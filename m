From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t3800-mktag.sh: use test_must_fail rather than '!'
Date: Tue, 25 Mar 2008 19:20:52 -0500
Message-ID: <47E996E4.5030108@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 01:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeJP4-0002P0-3U
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 01:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbYCZAVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbYCZAVY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 20:21:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40301 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbYCZAVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 20:21:23 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2Q0Kq1q023041;
	Tue, 25 Mar 2008 19:20:52 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 19:20:52 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 26 Mar 2008 00:20:52.0335 (UTC) FILETIME=[4006A7F0:01C88ED7]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--8.373000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY3My0xODgw?=
	=?us-ascii?B?MTktNzAwOTcwLTcwNDU2OC03MDAzNzMtMTA1MjUwLTcwMDQ3Ni0x?=
	=?us-ascii?B?MjEzMzgtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78236>

---
 t/t3800-mktag.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 2780758..bdc6e13 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description='git-mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		( ! git-mktag <tag.sig 2>message ) &&
+		( test_must_fail git-mktag <tag.sig 2>message ) &&
 		grep "$expect" message
 	'
 }
-- 
1.5.4.4.481.g5075
