From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] config.txt: refer to --upload-pack and --receive-pack instead of --exec
Date: Thu,  6 Mar 2008 21:28:07 +0100
Message-ID: <1204835287-2852-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 21:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXMhU-0003Tl-BD
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758996AbYCFU1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758936AbYCFU1f
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:27:35 -0500
Received: from mail164.messagelabs.com ([216.82.253.131]:18793 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758696AbYCFU1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:27:34 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-15.tower-164.messagelabs.com!1204835250!436009!5
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 30333 invoked from network); 6 Mar 2008 20:27:32 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-15.tower-164.messagelabs.com with SMTP; 6 Mar 2008 20:27:32 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Mar 2008 14:27:31 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Mar 2008 14:27:17 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Mar 2008 21:27:15 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 4196F2AA22; Thu,  6 Mar 2008 21:28:07 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
X-OriginalArrivalTime: 06 Mar 2008 20:27:15.0498 (UTC) FILETIME=[777DD0A0:01C87FC8]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15772.000
X-TM-AS-Result: No--11.824000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76417>

The options --upload-pack (of git-fetch-pack) and --receive-pack (of
git-push) do the same as --exec (for both commands).  But the former op=
tions
have the more descriptive name.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4027726..23e1cab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -864,15 +864,15 @@ remote.<name>.skipDefaultUpdate::
=20
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
-	option \--exec of linkgit:git-push[1].
+	option \--receive-pack of linkgit:git-push[1].
=20
 remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
-	option \--exec of linkgit:git-fetch-pack[1].
+	option \--upload-pack of linkgit:git-fetch-pack[1].
=20
 remote.<name>.tagopt::
-	Setting this value to --no-tags disables automatic tag following when=
 fetching
-	from remote <name>
+	Setting this value to \--no-tags disables automatic tag following whe=
n
+	fetching from remote <name>
=20
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
--=20
1.5.4.3

