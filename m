From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 42/44] ruby: remove GIT_PAGER from environment
Date: Sat, 28 Sep 2013 17:04:07 -0500
Message-ID: <1380405849-13000-43-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2kM-0004Mv-H0
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab3I1WMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:10 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42481 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3I1WMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:12:05 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so4225485obc.9
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRfY92cRmiy43oO/NpkCNIeYJgT/VzBoQGiUH8eiZnA=;
        b=Qbeg7EcexXqGxPHhYgdhpYRqz2P9eaBI51d3XF3Awdb7zIoMixIe7OxKPeCzRH7v1o
         NsRjAU+LvauvCC26gMK70vhsC9vf0K3Tj6bRKWF90nEFNAfnIfg0DtKy3Vl0OXQ2Fo9K
         Rb2sb97sDY4qR0/fAKQykWS7Csw4IasKe5CLbxnnbK+F00FeR3TFAa7RlonT4IquceaY
         3UuuSC3z0VCkqi+WaVGEj+hQChvIpO3Nz4IGEte3JqK+EFmXMz/VOdaluWpSEMiTjsOj
         nbQ6rRTSdHPxAIvlBdJ9QQ8URazeFkiOKNEJQyG2Sj7bhAHwt/31I5nJdxqMH3Vj75Is
         kylQ==
X-Received: by 10.60.45.102 with SMTP id l6mr3708442oem.36.1380406325571;
        Sat, 28 Sep 2013 15:12:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm19518521obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:12:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235562>

We are not calling any git commands any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index fde8d1a..941ff72 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -2,8 +2,6 @@
 
 require 'date'
 
-ENV['GIT_PAGER'] =
-
 patch = nil
 
 def usage
-- 
1.8.4-fc
