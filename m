From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/3] doc: send-email; expand oon the meaning of 'auto-cc'
Date: Mon, 20 Jul 2015 19:26:29 +0100
Message-ID: <1437416790-5792-4-git-send-email-philipoakley@iee.org>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFm0-0006vW-Kd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbbGTS0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:26:38 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:41122 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207AbbGTS03 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 14:26:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CyCQBiPK1VPHMBFlxcgkFSgT2GUIFZuz0EAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEEViMQCEk5CgMRBhOIMshcLI9tAhEBUQeEKwWUUqUogQmDGj0xgQQJF4EnAQEB
X-IPAS-Result: A2CyCQBiPK1VPHMBFlxcgkFSgT2GUIFZuz0EAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEEViMQCEk5CgMRBhOIMshcLI9tAhEBUQeEKwWUUqUogQmDGj0xgQQJF4EnAQEB
X-IronPort-AV: E=Sophos;i="5.15,509,1432594800"; 
   d="scan'208";a="614509314"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 20 Jul 2015 19:26:29 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274343>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-send-email.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bc357b8..ddc8a11 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -282,7 +282,7 @@ Automation options
 
 --suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
-	auto-cc of:
+	inclusion of addresses added via other automation options:
 +
 --
 - 'author' will avoid including the patch author
-- 
2.4.2.windows.1.5.gd32afb6
