From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 16/20] remote-hg: add simple mail test
Date: Mon,  8 Apr 2013 12:13:30 -0500
Message-ID: <1365441214-21096-17-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfr-0005gW-N9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934702Ab3DHRPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:35 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47590 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934588Ab3DHRPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:33 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so6385792oah.24
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Zbr0m975j9suJPqzsyNQUbQZ7hKZTwdiJ6kMMscXwAU=;
        b=zG5go9I5OPLVwYD+6/W37wu3trrT5mfZfIOEWfN36/L+T3lgfk2UKbmOh8OHZy+T5Y
         rmEDnWgGWLJ/EMs3Q1ZKBL/JuHPBaGTqvPTqLzr7OsAyayqNSBV1BjDP9du61WPOWaRg
         2hclKiKvPbqS+8WvylLdKIlk84jQFOFdjetWuLiOcrjAbVNsfSpQYy+zmCe8DvV5Yqnh
         rRvD3yHGi92BEmVjvULnVQ+UlrVk+ljB7BHiWCxfjBrH+PIi3MmNQ/ZcD2zkKBimS85o
         4BCJfIT59dk7UPPZE61cHQw15lofpW+cO/nbksVJWiq4CN5dsRCy2HJM+/+FuCSGFIge
         szzw==
X-Received: by 10.182.61.6 with SMTP id l6mr5607883obr.69.1365441332980;
        Mon, 08 Apr 2013 10:15:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id jw8sm5319203obb.14.2013.04.08.10.15.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220454>

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
1.8.2
