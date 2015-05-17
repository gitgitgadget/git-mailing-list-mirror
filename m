From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Sun, 17 May 2015 08:56:52 +0200
Message-ID: <1431845814-2541-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 08:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtsVv-00067Z-MD
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 08:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbbEQG52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 02:57:28 -0400
Received: from sender1.zohomail.com ([74.201.84.152]:25184 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbEQG50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 02:57:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id; 
  b=ag2gqFI3zZx8UTe8UUP+RunWopBjJYTOGOqQs+3B/0KU65qaJqH+GL/AruIx9YvaUoP+vCj9EMjy
    YipEfjwjBiN4fdCjif9/4zL2yYea1g1OcApWjoy/WFCJEy4yAHbLSVwErrtOpFsqIE8Lh0+jsO7d
    CJEdVTkMhGuQDSxYy6k=  
Received: from localhost (f052128250.adsl.alicedsl.de [78.52.128.250]) by mx.zohomail.com
	with SMTPS id 1431845845020336.3629878842364; Sat, 16 May 2015 23:57:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_16045_4
X-ZohoMail-Owner: <1431845814-2541-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 78.52.128.250
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269215>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-verify-pack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 526ba7b..61ca6d0 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -40,7 +40,7 @@ OUTPUT FORMAT
 -------------
 When specifying the -v option the format used is:
 
-	SHA-1 type size size-in-pack-file offset-in-packfile
+	SHA-1 type size size-in-packfile offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-- 
2.4.0
