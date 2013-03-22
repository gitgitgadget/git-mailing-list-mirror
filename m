From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] t5520 (pull): update test description
Date: Fri, 22 Mar 2013 18:01:47 +0530
Message-ID: <1363955508-13368-2-git-send-email-artagnon@gmail.com>
References: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ180-0006rd-2E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123Ab3CVMap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:30:45 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45342 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab3CVMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:30:39 -0400
Received: by mail-pd0-f179.google.com with SMTP id x10so1581772pdj.10
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lWi+ZJj7JyhVmrKYDuh2Dk1Bygc1Ucb93A4MMLprcSw=;
        b=u72U5hihMsa8X+zjSLsCo17O4jvJJWLRgHGDYVu/rXSzA2uUf95z+pE2kXrXcFPRCr
         S/3QlcyHXhhJr9DwdV0PYx84JyD+9oSymZ1+k94NGGBwMhRRvYx0QVlijoy7RBt1ziJG
         uOKA2+tBhsnVdvurx/vSRzFf+rSDFgm5ASEk5Exn6hFAYd40Hk/j/xGf+tN9wkqySb27
         88T4/V0rujC+loLZ+zLYvLsvFOQZUhSihUVD4J+d0vOzRL/rKKvtRU/nMbjZ1R53CurR
         fIGSwpc6hMPnuUFJvnDcBT5pfMohSGpGkNtlZboVKqkGkg8msQkSxESyrPNvdIn7Ql3O
         GUmw==
X-Received: by 10.68.225.166 with SMTP id rl6mr2329744pbc.91.1363955438897;
        Fri, 22 Mar 2013 05:30:38 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ky17sm2808786pab.23.2013.03.22.05.30.37
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:30:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
In-Reply-To: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218800>

d09e79c (git-pull: allow pulling into an empty repository, 2006-11-16)
created the file with the description.  At the time, there were only
tests to check pulling into an empty repository.  The description was
never updated even after more tests, unrelated to the original, were
added.  Fix this now.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 35304b4..e5adee8 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='pulling into void'
+test_description='pull basic functionality'
 
 . ./test-lib.sh
 
-- 
1.8.2.141.gad203c2.dirty
