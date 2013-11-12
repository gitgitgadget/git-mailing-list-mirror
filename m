From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 05/11] test-hg.sh: tests are now expected to pass
Date: Tue, 12 Nov 2013 14:56:59 -0600
Message-ID: <1384289830-5471-7-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9Y-0000cy-PW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab3KLVFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:34 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:55976 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab3KLVEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:21 -0500
Received: by mail-oa0-f45.google.com with SMTP id m1so4599177oag.32
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uf3sPFKXUtqZmiBWoWBxj1AYhq97IMwnSx11bYvO3OU=;
        b=0FspnbTVOqC5tuyJxRISdqS9JiBcXyyvaW6wiiRa21CaAqEECX7VmDyCFFlsZTrHj5
         2eQFGY/zXH3cyQq+HhvdtbuOIJaua8aBASwG0XduhQLZTwa3MN72nPUv7iN7yWYsKXh/
         Rm5WYJGkar1+yyi1inHYZ890NJ8mn84XLNK+ITZJzQzEA7i22oa5ygh3h0GRgTBxeBkf
         da9mcprW4yVrbItIbjJ5Wbz6htoZck1GE4pL4cbF4stOdWR1yYly55XfDKj7z3Yrabwl
         A+tvqWKiE2qqnPZNY5AeR7PAWV9wvIei3KqIcr5QTeEvM94lTHKWJmCX2vejOr6x4IUQ
         l53g==
X-Received: by 10.182.131.196 with SMTP id oo4mr11855461obb.50.1384290260596;
        Tue, 12 Nov 2013 13:04:20 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm35391792obb.5.2013.11.12.13.04.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:19 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237746>

From: Richard Hansen <rhansen@bbn.com>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..aacd8a9 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -599,7 +599,7 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
-test_expect_failure 'remote big push force' '
+test_expect_success 'remote big push force' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
@@ -629,7 +629,7 @@ test_expect_failure 'remote big push force' '
 	check_bookmark hgrepo new_bmark six
 '
 
-test_expect_failure 'remote big push dry-run' '
+test_expect_success 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
-- 
1.8.4.2+fc1
