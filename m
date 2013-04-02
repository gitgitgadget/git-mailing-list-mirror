From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Tue,  2 Apr 2013 13:10:30 +0530
Message-ID: <1364888434-30388-3-git-send-email-artagnon@gmail.com>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:40:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvow-0007It-7y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535Ab3DBHjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:39:25 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:52194 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834Ab3DBHjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:39:23 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so92098pdj.24
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=72+v2LQZDmPhbaz+7u1CgRFnkceoKQSmR493iqAkkVg=;
        b=0kzcJpI0zPMmNr+B+HqCOUG0aq53DeZl6w4LS3+IbrFXSlynTGeyYeDIMIF9P6W7PA
         bexfIdEOCEvxpkBy5W/PsYuF3vAbFJrav5xEbpq2f8bW+WhLzQZbY7UNOdRbr+qdJJkh
         gRjTw2TeexB8Ka+81IwVZaNIl7D27eVvwoMb3YXaBddzKtd5QkXARWNF64QfcuuDxO9c
         TsdUR1+LGSp+QKs6L1ko849e+SyRwTntzWas8s0y74qOJHDygC5qsiuafFxwxcY8FDOa
         k0wtLIOAgNRExh972+pXY82cafmqz68tGcXxSFHFSxNhpeSEr9vQwKeFWS+PUb7lfwvE
         qlCQ==
X-Received: by 10.68.64.136 with SMTP id o8mr22717741pbs.59.1364888363252;
        Tue, 02 Apr 2013 00:39:23 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id oq3sm1259341pac.16.2013.04.02.00.39.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 00:39:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.363.g901f5bc
In-Reply-To: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219745>

The file was originally created in bcdb34f (Test wildcard push/fetch,
2007-06-08), and only contained tests that exercised wildcard
functionality at the time.  In subsequent commits, many other tests
unrelated to wildcards were added but the test description was never
updated.  Fix this.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 383a2eb..f394271 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1,6 +1,17 @@
 #!/bin/sh
 
-test_description='fetching and pushing, with or without wildcard'
+test_description='Basic fetch/push functionality.
+
+This test checks the following functionality:
+
+* command-line syntax
+* refspecs
+* fast-forward detection, and overriding it
+* configuration
+* hooks
+* --porcelain output format
+* hiderefs
+'
 
 . ./test-lib.sh
 
-- 
1.8.2.363.g901f5bc
