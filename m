From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/5] technical/api-remote: Describe new struct remote member pushurl
Date: Tue,  9 Jun 2009 18:01:36 +0200
Message-ID: <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3lt-00008m-VG
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbZFIQBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbZFIQBs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53446 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755034AbZFIQBp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4B16835EA77;
	Tue,  9 Jun 2009 12:01:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Jun 2009 12:01:48 -0400
X-Sasl-enc: WZcDhpDGDzQlTw1WgTHLqAnAwZo3EX0dOJtsBVACDV0J 1244563307
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8433E2F08C;
	Tue,  9 Jun 2009 12:01:47 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121182>

...and pushurl_nr

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/api-remote.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index 073b22b..c54b17d 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -18,6 +18,10 @@ struct remote
 
 	An array of all of the url_nr URLs configured for the remote
 
+`pushurl`::
+
+	An array of all of the pushurl_nr push URLs configured for the remote
+
 `push`::
 
 	 An array of refspecs configured for pushing, with
-- 
1.6.3.2.278.gb6431.dirty
