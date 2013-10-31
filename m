From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/16] transport-helper: trivial style fix
Date: Thu, 31 Oct 2013 03:25:40 -0600
Message-ID: <1383211547-9145-10-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboci-0008Ez-48
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab3JaJcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:52 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35966 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:51 -0400
Received: by mail-ob0-f180.google.com with SMTP id wo20so2781817obc.11
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Ty11dyjlyd3vvhD5ub8+tdmyqBusNGkwFZL/iYfg+U=;
        b=xi9UKd/XWpX/I2L257+3WLUclzKlUHSslRCz/b7OGmlbR0uF8wawJVdLQUdEUvVrsF
         d0hop65HJGu2e9IvcK8zgL44aP4DMncCKA+Zr+tgA3HfoCMjGicyass/Qpq/HrPwc35s
         nhAsbHzhVHK/R/bNqIWDapDboYg4JVKynhATfG789CmeO9gUAvgHgXyPJ8sTPDkEZPua
         fr88a4CIR11l1JbDhzZh1uLPHiExqp4Mbgn6MOFqCLBQa+/6C9Kih+3njQBrMcHwGEGl
         L+E3wnoa5IB0mRaUKtsc/uIJ2Av4t9piVMJ/UaTK4l2Al6cQ2TP2P3N5k7ckkvkGxw0L
         T0tw==
X-Received: by 10.182.98.162 with SMTP id ej2mr1817079obb.61.1383211970812;
        Thu, 31 Oct 2013 02:32:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm4485051obo.7.2013.10.31.02.32.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237093>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..673b7c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -269,6 +269,7 @@ static const char *unsupported_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP
 	};
+
 static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
-- 
1.8.4.2+fc1
