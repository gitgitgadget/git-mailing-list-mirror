From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 16/21] remote-hg: add simple mail test
Date: Thu, 11 Apr 2013 07:23:12 -0500
Message-ID: <1365682997-11329-17-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZD-000896-3F
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161516Ab3DKMZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:20 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61876 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:16 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so235603qab.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=om5WTlP2M1o5tffWz7zW/CikRZXsxhy4s8kqSK7bTP0=;
        b=zHQ440uiy8/1MMkevC2buPArxvWuR8fWgLeDcFwy7kJmYLPyQwmGOgNgUTdDhRtu0C
         In28iqtNIJZqMrcaxHcaM7EWvtjlX+V0W28HC7dUG2Dd8jGczzmkMS3Nx530z9g5WMpO
         nViELIMj5AiLeabd2oTKOfbVVUBg7+KWtrFwTyx5a772+388qDA4I80TObIoULy79R+i
         9pgiCT3tbxmJ84OkY+5HmfA1EAvTLplyH1dTfcDed4AG3RJAO3IgYQQ1epNvzC2KsP3q
         hWu7xuTrl/8/R6WuVklzFNsrG8fIdvA3A2axGng/9gcrAzQnZYH6ZaAySo+1WnbAdffH
         6RXQ==
X-Received: by 10.224.178.148 with SMTP id bm20mr6891450qab.30.1365683115601;
        Thu, 11 Apr 2013 05:25:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u13sm6984412qac.7.2013.04.11.05.25.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220867>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 62e3a47..6a1e4b1 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -144,7 +144,8 @@ test_expect_success 'authors' '
   author_test zeta " test " "test <unknown>" &&
   author_test eta "test < test@example.com >" "test <test@example.com>" &&
   author_test theta "test >test@example.com>" "test <unknown>" &&
-  author_test iota "test < test <at> example <dot> com>" "test <unknown>"
+  author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
+  author_test kappa "test@example.com" "test@example.com <unknown>"
   ) &&
 
   git clone "hg::$PWD/hgrepo" gitrepo &&
-- 
1.8.2.1
