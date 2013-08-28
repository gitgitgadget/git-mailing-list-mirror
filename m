From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/8] remote-hg: add missing &&s in the test
Date: Wed, 28 Aug 2013 14:23:09 -0500
Message-ID: <1377717793-27170-5-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPk-0003eS-AR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050Ab3H1T2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:15 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37455 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3H1T2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:14 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so3305547oag.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ugYOpi/F7R9uPdn6kwuelnsUs4p06yQGWL9QJZt2QOw=;
        b=P3sUWxGK1QFkWWuciquTG71y4b3/LLjxIMruI6IvJf0d25CccBDbmS/8ONm2qtlGO2
         p5YInK+D8rnQA6izrgnmlu2JqpGLwI+OwwClNB8V6r8Hz3KE5eOumhXXwF3sZm8nzTaU
         4XrpvkuBmPnO/QW7BMO9Tr77XSZ6Q6ckFovITqJBw6FtY+b2YfmdBlmzUapYYSN+DotY
         IfOcwNR3JusTNDB0olaqt0ePOOWqIVsQkR1QV6kBEOEHRP2ogrXVJJkVwl2M15/ccYcK
         0Rmeh7mU+z1jGxo5OCCft2kao2zBP9iTXXMASnxdh5uvqk50fKDhy2qbMxlgWV8iNBgl
         +ebA==
X-Received: by 10.182.66.82 with SMTP id d18mr7800644obt.98.1377718093830;
        Wed, 28 Aug 2013 12:28:13 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm27527420obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233198>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index cbf8617..94b0bba 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -577,7 +577,7 @@ test_expect_success 'remote big push fetch first' '
 	echo five > content &&
 	git commit -q -a -m five &&
 
-	check_push 1 --all <<-EOF
+	check_push 1 --all <<-EOF &&
 	master
 	good_bmark
 	bad_bmark:fetch-first
@@ -633,7 +633,7 @@ test_expect_failure 'remote big push dry-run' '
 	(
 	cd gitrepo &&
 
-	check_push 0 --dry-run --all <<-EOF
+	check_push 1 --dry-run --all <<-EOF &&
 	master
 	good_bmark
 	branches/good_branch
-- 
1.8.4-fc
