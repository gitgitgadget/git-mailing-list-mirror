From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] t3400 (rebase): downcase a couple of test titles
Date: Fri, 10 May 2013 19:59:36 +0530
Message-ID: <1368196178-5807-3-git-send-email-artagnon@gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoJC-00020i-NV
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab3EJO2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:28:21 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:47943 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3EJO2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:28:04 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so1002937dan.11
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ChhKktcWlaSyx6Yq31QTytMAsu/gHqjkrYgyshdzPfA=;
        b=gGfNxBaGWaNYPMChX0q9pjRTdJ4jzZXsbsx0Kjr5jJhdikW5e65u1wnVcxu/kHwCLN
         +QYOTj/vDwQBsi/jJCJl4xqa0lOnnKXnSrnYDKtQO7gP6kLBXANmoO60+xfVqRlnvpNR
         CmsI7LChVJcMWJM/S/lHWsFThgLM61qrD/xrrc9TCYwqgmhnrcHyl6pzAmZ9hsUx7bS9
         6RYo98pxNtHmjr15ijjhU4pN1OwPRiupuR6KF3cx/x7slRhbSdT/TEIhPSrY1rPVtxIZ
         5dJdV0iHotG0KSp1VsvI+zKBe7AgmJAUMk7SRf8G0GU7AEqRZzBjFJhNsWN8N8g883k5
         53/Q==
X-Received: by 10.66.26.47 with SMTP id i15mr17970111pag.98.1368196084105;
        Fri, 10 May 2013 07:28:04 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ih1sm2885215pbb.44.2013.05.10.07.28.02
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:28:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223851>

Otherwise they stick out like sore thumbs in the test output, where
all the other titles begin with a lowercase letter.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index a7ca2f1..cb4234a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -152,7 +152,7 @@ test_expect_success 'setup: recover' '
 	git checkout modechange
 '
 
-test_expect_success 'Show verbose error when HEAD could not be detached' '
+test_expect_success 'show verbose error when HEAD could not be detached' '
 	>B &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
 	grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
@@ -184,7 +184,7 @@ test_expect_success 'rebase -q is quiet' '
 	test ! -s output.out
 '
 
-test_expect_success 'Rebase a commit that sprinkles CRs in' '
+test_expect_success 'rebase a commit that sprinkles CRs in' '
 	(
 		echo "One"
 		echo "TwoQ"
-- 
1.8.3.rc1.52.gc14258d
