From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 5/6] test-hg.sh: tests are now expected to pass
Date: Sat, 12 Apr 2014 15:12:54 -0500
Message-ID: <1397333575-11614-6-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sw-0007aI-1g
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbaDLUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:45 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59687 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbaDLUXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:16 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so583319obc.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7mwPS/e80/8bEYzVgLJBa+1iSu/C9TRrK71OjqOSGo=;
        b=bL+UW4b0gPdPr+HbUDQEKEo0EfkZ2K6b0RRQxEWPMrPjAfNIObb1VYlTi6VAPkL7Tp
         7L4vmP18rptbHWIz6x7qaziBYZLgoU86m4Izhe+fzmtx5Bk4Vp5X4pGoI9+v3ic192GA
         KcSsC3YpGM5fYfFMnOtoAyGsQ9FQk3o/QBvUE1jyuJx85Z+6DovjwUb4cWktJ8fyrbk8
         LmAg/iBKbabZtcCu2h6XBstC6j+BlOKdVZfGXPZ6XIo+iAdQ2lzVZmNqPd37wAQMEW1z
         sADPEaM8/ToJQ1qlRvRZbXtPOI3wjGET8lmElVY5P/9fqckwq70nWa5NpCAVYhzMzcE7
         B12A==
X-Received: by 10.60.62.178 with SMTP id z18mr1808930oer.61.1397334196138;
        Sat, 12 Apr 2014 13:23:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm19183819obk.4.2014.04.12.13.23.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246182>

From: Richard Hansen <rhansen@bbn.com>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 5d128a5..a933b1e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -680,7 +680,7 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
-test_expect_failure 'remote big push force' '
+test_expect_success 'remote big push force' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
@@ -710,7 +710,7 @@ test_expect_failure 'remote big push force' '
 	check_bookmark hgrepo new_bmark six
 '
 
-test_expect_failure 'remote big push dry-run' '
+test_expect_success 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
-- 
1.9.1+fc3.9.gc73078e
