From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] git-unpack-objects.txt: fix inconsistent spelling of "packfile"
Date: Sun, 17 May 2015 08:56:53 +0200
Message-ID: <1431845814-2541-2-git-send-email-ps@pks.im>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 08:57:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtsW1-000695-05
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 08:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbEQG5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 02:57:31 -0400
Received: from sender1.zohomail.com ([74.201.84.152]:25199 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbEQG5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 02:57:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=gAoW/NZ7OKTTMQ7y4ggf7jjYheAvGlS87/E9KOqNNYi8MbpJzylJkxOqqpRYMhm2o7TNdwoas/Hg
    O4uc091TJ60Q4obQ4yHJJr3AZQEButon2yszwvZisNh/MG75YhBokdjOIeXL+Vqm/jVKN1s/nN4q
    BYRa0HpZJPaDxgpUwwQ=  
Received: from localhost (f052128250.adsl.alicedsl.de [78.52.128.250]) by mx.zohomail.com
	with SMTPS id 1431845847988356.77845856601743; Sat, 16 May 2015 23:57:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431845814-2541-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_16045_3
X-ZohoMail-Owner: <1431845814-2541-2-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 78.52.128.250
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269214>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-unpack-objects.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 12cb108..894d20b 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -19,8 +19,8 @@ the objects contained within and writing them into the repository in
 "loose" (one object per file) format.
 
 Objects that already exist in the repository will *not* be unpacked
-from the pack-file.  Therefore, nothing will be unpacked if you use
-this command on a pack-file that exists within the target repository.
+from the packfile.  Therefore, nothing will be unpacked if you use
+this command on a packfile that exists within the target repository.
 
 See linkgit:git-repack[1] for options to generate
 new packs and replace existing ones.
-- 
2.4.0
