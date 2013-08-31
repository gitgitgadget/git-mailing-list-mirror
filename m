From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] t: branch: trivial style fix
Date: Fri, 30 Aug 2013 23:31:48 -0500
Message-ID: <1377923511-20787-2-git-send-email-felipe.contreras@gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 06:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcvS-00061t-94
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 06:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab3HaEgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 00:36:35 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60148 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab3HaEgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 00:36:35 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so3167565oah.39
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWpwhqp18zpGUj+jPThWfDX64ZCW3oHi0+ZmGt/eF+k=;
        b=tyk0T7jjN38yMRy/tFgrd1SKLUwPha1jT3gmEIeRgNYEgCBxI7FybhOAOAKLWbEFXY
         l/ARFqkmK5bI3Y8Uc1S3Qhkyfz3XCPrCI7KxrUbwmDT4itW0Vw8w3imDpZVw7d/CW9Y4
         UHtju5t3aRpcJx3YfzAT1ybpzpkL7/em1U+QCK08AXbi6vdV1GphtmhekTYp4UsioyHV
         IwJn3IbthIQQ0ZdzqoGFM4oWgtOV+59LR03wayQILYW9nL7wES27xN/50dkeWMEMlQX4
         w5zLiuR6YFKO/yD39KzbERBiHwFJri9p4xGjvgSHwm6jZu4fcVLvYLF+D0TL74fiC0id
         ry3A==
X-Received: by 10.182.204.4 with SMTP id ku4mr9474611obc.21.1377923794612;
        Fri, 30 Aug 2013 21:36:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm1738589obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 21:36:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233500>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44ec6a4..ea548f9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -14,7 +14,8 @@ test_expect_success 'prepare a trivial repository' '
 	echo World >>A &&
 	git update-index --add A &&
 	git commit -m "Second commit." &&
-	HEAD=$(git rev-parse --verify HEAD)'
+	HEAD=$(git rev-parse --verify HEAD)
+'
 
 test_expect_success 'git branch --help should not have created a bogus branch' '
 	test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
-- 
1.8.4-fc
