From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/3] pack-protocol.txt: fix insconsistent spelling of "packfile"
Date: Sun, 17 May 2015 08:56:54 +0200
Message-ID: <1431845814-2541-3-git-send-email-ps@pks.im>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 08:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtsW1-000695-Iz
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 08:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbbEQG5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 02:57:33 -0400
Received: from sender1.zohomail.com ([74.201.84.152]:25354 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbEQG5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 02:57:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=3czgUf1Q78e5q1mWT2CNDvcwva392YE5am0Bg6HspIbuFHF5J3ipXv2HpdDvhStVcTdGljV3Mcj6
    OzukGvccfruvgYEiY5rcoi05YxIVatqOI/GQy7c31wCv7TG69jK9cKdcnY4Wyg41XD9UG0uI1xPI
    Uw9WrM+WZi/Hjyt2qZw=  
Received: from localhost (f052128250.adsl.alicedsl.de [78.52.128.250]) by mx.zohomail.com
	with SMTPS id 1431845851100226.64134811417705; Sat, 16 May 2015 23:57:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431845814-2541-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_16045_3
X-ZohoMail-Owner: <1431845814-2541-3-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 78.52.128.250
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269216>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/technical/pack-protocol.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 462e206..812d857 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -502,11 +502,11 @@ MUST NOT send a push-cert command.  When a push-cert command is
 sent, command-list MUST NOT be sent; the commands recorded in the
 push certificate is used instead.
 
-The pack-file MUST NOT be sent if the only command used is 'delete'.
+The packfile MUST NOT be sent if the only command used is 'delete'.
 
-A pack-file MUST be sent if either create or update command is used,
+A packfile MUST be sent if either create or update command is used,
 even if the server already has all the necessary objects.  In this
-case the client MUST send an empty pack-file.   The only time this
+case the client MUST send an empty packfile.   The only time this
 is likely to happen is if the client is creating
 a new branch or a tag that points to an existing obj-id.
 
-- 
2.4.0
