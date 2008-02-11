From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] rebase -i: accept -m as advertised in the man page
Date: Mon, 11 Feb 2008 14:45:26 +0100
Message-ID: <1202737526-18210-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 14:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYz7-00079d-T3
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYBKNpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 08:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYBKNpb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:45:31 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:40118 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751417AbYBKNpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 08:45:30 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-13.tower-164.messagelabs.com!1202737529!8862044!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 9630 invoked from network); 11 Feb 2008 13:45:29 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-13.tower-164.messagelabs.com with SMTP; 11 Feb 2008 13:45:29 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 07:45:29 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 07:45:28 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 11 Feb 2008 14:45:26 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id B326F1B23F; Mon, 11 Feb 2008 14:45:26 +0100 (CET)
X-Mailer: git-send-email 1.5.4
X-OriginalArrivalTime: 11 Feb 2008 13:45:26.0935 (UTC) FILETIME=[5BC10A70:01C86CB4]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15724.000
X-TM-AS-Result: No--6.132300-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73535>

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 402ff37..fb12b03 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -432,7 +432,7 @@ do
 			shift ;;
 		esac
 		;;
-	--merge)
+	-m|--merge)
 		# we use merge anyway
 		;;
 	-C*)
--=20
1.5.4
