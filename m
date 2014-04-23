From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 1/3] sh-setup: export GIT_DIR
Date: Wed, 23 Apr 2014 14:42:38 -0500
Message-ID: <1398282160-26151-2-git-send-email-felipe.contreras@gmail.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:53:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3EO-0006c2-LS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbaDWTxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:53:12 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46819 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622AbaDWTxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:53:10 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1606028obc.10
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tr8NL3K5KmmGtI4KBsVbDHm2EBFObMccLlQFc6CW3rI=;
        b=kzAdpqhhDTajj2wdoo6th0sJ/ai3cgS3hWRMGVeVMJuR3sDKiwgWzHXeVWAzFFl/SK
         w6R+AVWFUtOSEOUkTX41vyD/1+hQPuSYCM8MCPoytdyO2fGtg+DNjVA9FD1FXotQNax5
         h8RdW8/xSZrrQndG5cCb2TGtBwo91/mtjCdp+WXOtckJ5nAFD72y9d15MTvwfelIDsTW
         GCTF7GWZ5FMpMGutTExjel0DlFYEAyEvsSyYge8C5TC1kRBGX280S1w1aaklDOayk/SL
         IZJBG+iTxgasKdK7R7u0z9pQLMbRa9QSB8Eev0QwxdSx4dj2LpgPQj1Iyqac8EjSjeQC
         UiOw==
X-Received: by 10.182.81.39 with SMTP id w7mr9270860obx.56.1398282790206;
        Wed, 23 Apr 2014 12:53:10 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm3697492obk.4.2014.04.23.12.53.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 12:53:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246876>

It is what the clients of this library expect.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-sh-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 5f28b32..fb0362f 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -346,6 +346,7 @@ then
 		exit 1
 	}
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+	export GIT_DIR
 fi
 
 peel_committish () {
-- 
1.9.2+fc1.1.g5c924db
