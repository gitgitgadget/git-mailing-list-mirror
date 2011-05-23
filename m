From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 01/10] Update technical docs to reflect side-band-64k
 capability in receive-pack
Date: Mon, 23 May 2011 02:51:54 +0200
Message-ID: <1306111923-16859-2-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJOP-0000eg-8h
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab1EWAwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab1EWAwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:40 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001SAIFE4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:26 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id E0FF81EA6143_DD9AFC9B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C67111EA2C53_DD9AFC5F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:21 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:21 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1306111923-16859-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174216>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/technical/pack-protocol.txt         |    3 ++-
 Documentation/technical/protocol-capabilities.txt |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 369f91d..4a68f0f 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -391,7 +391,8 @@ The reference discovery phase is done nearly the same way as it is in the
 fetching protocol. Each reference obj-id and name on the server is sent
 in packet-line format to the client, followed by a flush-pkt.  The only
 real difference is that the capability listing is different - the only
-possible values are 'report-status', 'delete-refs' and 'ofs-delta'.
+possible values are 'report-status', 'delete-refs', 'side-band-64k' and
+'ofs-delta'.
 
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index b15517f..b732e80 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -21,8 +21,8 @@ NOT advertise capabilities it does not understand.
 The 'report-status' and 'delete-refs' capabilities are sent and
 recognized by the receive-pack (push to server) process.
 
-The 'ofs-delta' capability is sent and recognized by both upload-pack
-and receive-pack protocols.
+The 'side-band-64k' and 'ofs-delta' capabilities are sent and
+recognized by both upload-pack and receive-pack protocols.
 
 All other capabilities are only recognized by the upload-pack (fetch
 from server) process.
-- 
1.7.5.rc1.3.g4d7b
