From: Kevin Daudt <me@ikke.info>
Subject: [PATCH 1/2] docs: explain behaviour with no tagopt set
Date: Wed,  4 Mar 2015 00:11:59 +0100
Message-ID: <1425424320-4091-1-git-send-email-me@ikke.info>
Cc: git@vger.kernel.org, Kevin Daudt <me@ikke.info>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 04 00:12:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvz5-00021R-1V
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbbCCXMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:12:08 -0500
Received: from ikke.info ([178.21.113.177]:59926 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbbCCXMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:12:07 -0500
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id A483C1DCF6D; Wed,  4 Mar 2015 00:12:05 +0100 (CET)
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id A85A34400AE;
	Wed,  4 Mar 2015 00:12:02 +0100 (CET)
X-Mailer: git-send-email 2.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264705>

Currently, only the behaviour when this option is set is explained, but
it's unclear what happens when this option hasn't been set.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 Documentation/config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 440784c..394042a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2241,8 +2241,9 @@ remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>. Setting it to \--tags will fetch every
 	tag from remote <name>, even if they are not reachable from remote
-	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
-	override this setting. See options \--tags and \--no-tags of
+	branch heads. When not set, fetches only tags reachable by the
+	downloaded refs. Passing these flags directly to linkgit:git-fetch[1]
+	can override this setting. See options \--tags and \--no-tags of
 	linkgit:git-fetch[1].
 
 remote.<name>.vcs::
-- 
2.3.0
