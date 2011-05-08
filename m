From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] git-format-patch.txt: update hints for sending patches with
 Thunderbird
Date: Sun, 08 May 2011 20:01:14 +0200
Message-ID: <4DC6DA6A.7010306@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 20:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ8II-00005c-JY
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 20:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1EHSBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 14:01:21 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:50266 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab1EHSBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 14:01:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 638D2DE792
	for <git@vger.kernel.org>; Sun,  8 May 2011 20:01:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Iswzl7K7eA2 for <git@vger.kernel.org>;
	Sun,  8 May 2011 20:01:15 +0200 (CEST)
Received: from [192.168.1.103] (g231229230.adsl.alicedsl.de [92.231.229.230])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id B922EDE791
	for <git@vger.kernel.org>; Sun,  8 May 2011 20:01:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173168>

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---

Using Thunderbird 3.1.10 setting mail.wrap_long_lines to false
somehow doesn't stop Thunderbird from wrapping.

 Documentation/git-format-patch.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index d13c9b2..be63481 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -388,9 +388,13 @@ In Thunderbird 2:
 Edit..Preferences..Composition, wrap plain text messages at 0
 +
 In Thunderbird 3:
-Edit..Preferences..Advanced..Config Editor.  Search for
-"mail.wrap_long_lines".
-Toggle it to make sure it is set to `false`.
+Edit..Preferences..Advanced..Config Editor. Set the following to the
+indicated values:
++
+----------
+	mail.wrap_long_lines  => false
+	mailnews.wraplength   => 0
+----------
 
 3. Disable the use of format=flowed:
 Edit..Preferences..Advanced..Config Editor.  Search for
-- 
1.7.5.1
