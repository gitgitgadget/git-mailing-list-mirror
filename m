From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] t: branch: fix typo
Date: Fri, 30 Aug 2013 23:31:49 -0500
Message-ID: <1377923511-20787-3-git-send-email-felipe.contreras@gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 06:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcvS-00061t-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 06:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3HaEgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 00:36:39 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:55763 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab3HaEgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 00:36:39 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so2629883obc.7
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 21:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g4JyOecC9BQF7w0CrYhIhd3a8I6mb5xW+Yvt2aal1V0=;
        b=YvaHdIDe6bsiy5Qyi3j7Qww7g2mKMoK7yf/JujZGtxliPGe5rMUFSvD5MCynORjSYc
         GA1G9WLGS9ual4sxf1Bqngli9DlKHUbnjwqgWj+0NXXxGbw1DEQ7599L8VO4JstxspTk
         KjqEjZkPXSFyYbJbe23aF0GP/0pglR2DhS+gdSJeSIfb0FQsAyyS+cIs1iNvRr5DOioL
         cFODj3zbYBEoXDtjlCQzSksTsZ3/nU8HvbFpSzgCRiuQVn/ks7/80GJaiBGp/SHWeSVH
         W6SCinHaU2fgq16TcmMhTEjtnuzs+taCHRE4estQfGGrzWSxdKrWTQBiUQ5W4mxnQcvU
         HfUw==
X-Received: by 10.182.61.19 with SMTP id l19mr9436010obr.55.1377923798099;
        Fri, 30 Aug 2013 21:36:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm1704059obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 21:36:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233501>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ea548f9..3134652 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -351,7 +351,7 @@ test_expect_success 'test overriding tracking setup via --no-track' '
 test_expect_success 'no tracking without .fetch entries' '
 	git config branch.autosetupmerge true &&
 	git branch my6 s &&
-	git config branch.automsetupmerge false &&
+	git config branch.autosetupmerge false &&
 	test -z "$(git config branch.my6.remote)" &&
 	test -z "$(git config branch.my6.merge)"
 '
-- 
1.8.4-fc
