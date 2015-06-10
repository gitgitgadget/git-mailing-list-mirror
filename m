From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH] doc: format-patch: fix typo
Date: Wed, 10 Jun 2015 23:01:14 +0200
Message-ID: <1433970074-12497-1-git-send-email-fransklaver@gmail.com>
Cc: Frans Klaver <fransklaver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2n7L-00016e-55
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbbFJVA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:00:56 -0400
Received: from mail-wg0-f68.google.com ([74.125.82.68]:34319 "EHLO
	mail-wg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbFJVAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:00:54 -0400
Received: by wggx12 with SMTP id x12so9143379wgg.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=La6DafVrKNtgRGOUAzbNnXKpy5571gu3qj+iYB3JuyE=;
        b=KUqr4PcJbSyroW/loyV85zUaat0ZoZfAqof/wgAf9eimlrbVbdMO4wkqgA7bvk4EAo
         aN8jAJjxBSwhoHRrG9xvMCUAZF7bEAZZH6lsNeOerMS9VCBwYpWlo7iu4NkadfaW4kH6
         N2AR8xnE9TzAQnn0y35Nr4ags37/TxnEotjKHkeGIRVs02wx2LBmhBa5rGD8MQCAhPPN
         aEalmmnsJQ4uJAx6r+iPp39c7t2Z2AeKBZ4pJ/rRJldCl8vUXU5DWp0yUFtcfDAnt22w
         uU6WIUwmcBFFfTdq/L65R0LHT09jlwMLjWBKM1QIulOsTSMf3QPpIiB772XABkooPeS0
         zvIA==
X-Received: by 10.180.77.193 with SMTP id u1mr22442478wiw.50.1433970053199;
        Wed, 10 Jun 2015 14:00:53 -0700 (PDT)
Received: from localhost.localdomain (82-171-48-45.ip.telfort.nl. [82.171.48.45])
        by mx.google.com with ESMTPSA id r9sm16250632wjo.26.2015.06.10.14.00.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 14:00:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271354>

reroll count documentation states that v<n> will be pretended to the
filename. Judging by the examples that should have been 'prepended'.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 Documentation/git-format-patch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index bb3ea93..0dac4e9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -170,7 +170,7 @@ will want to ensure that threading is disabled for `git send-email`.
 -v <n>::
 --reroll-count=<n>::
 	Mark the series as the <n>-th iteration of the topic. The
-	output filenames have `v<n>` pretended to them, and the
+	output filenames have `v<n>` prepended to them, and the
 	subject prefix ("PATCH" by default, but configurable via the
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
-- 
2.4.0
