From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 17/23] whitespace fix.
Date: Sat, 23 Apr 2011 17:22:46 +1000
Message-ID: <1303543372-77843-18-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCv-00054D-3z
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1DWHYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab1DWHYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:37 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=70IQ5ry7CQXLxqxIhbVkUZ9ewkhhXD+6mTdk3dNruDI=;
        b=KOzWdPXbwUqAjVSB9fNE+VU7RWXSwIhUyDGxmcCQYz9TXlHkXQIaJZLNlS2BWmyKky
         +dDzNvVdkGrWDxZMPsgnhs4ylTeDdy7hGYp6t1882gqtMrLoNHMNszNtcaXgQf7jYiB0
         k0jQavBN6s/4ImlrwBBMboxZKLUkTYabEhom4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=weyZzjc99EGm6seQ98FLm600Z3O4gNaYorJQL/VmcniOtxALBRuD3RLwq7AHKJ3Dvj
         hJv+qPSObDIy447edztXdfXwBliuORcFUq7SZ0c50e+AEBE6/7lFm7MHqZ0GT8oz0NF3
         ccSJhv4KaX+j24Y7tQ3CHdmbFA1QLWWhdIBR8=
Received: by 10.142.12.16 with SMTP id 16mr1104958wfl.253.1303543477213;
        Sat, 23 Apr 2011 00:24:37 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171970>

---
 t/t1520-test.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 78f31fe..ddca519 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -440,6 +440,6 @@ test_expect_success 'existence' \
        --not-tag-exists N \
        --not-tag-exists master \
        --not-branch-exists A 
- '
+'
 
 test_done
-- 
1.7.5.rc1.23.g7f622
