From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 6/8] tmp: completion: mark SZEDER's tests as fixed
Date: Sun, 18 Nov 2012 11:56:51 +0100
Message-ID: <1353236213-13471-7-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZS-00081T-UI
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab2KRK5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2KRK5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:36 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cvZT3drnz86y0BYkMLzptvflFSryl659cP1voYVAuME=;
        b=pv1VjcqA1+uqs/ctVUdXJqbgbTYhYs4zmcC4HXf2y8Itu8Ym7ZdwpXbyluJEJOSDRf
         60WHEiYUSfZxO1wQ4rOBccGGBlMrUuk1DMf8VTQLx+tEWIYtM5s0nTY2xqR155tfyIof
         kxly0YnS2QoWGLBm2bmsS6nayMCCxjnFLA4ItkkQjlIdrjpoKhuxz/tnYTxgKZGc3feQ
         c+Y0qjMozEds2vq2Yr8qPGDl5Sk5aUFdyISsWeV8kIj0Fh33NvbZEAC1iR7L5kcDZQHk
         G9XY7Z8lIyb/+s5QeRwLX8M2hp6U1Gi+5zI2nrwljP57ufST2S7hT9bf4QLy6BRoR90Q
         xLbg==
Received: by 10.204.4.133 with SMTP id 5mr3902621bkr.21.1353236255319;
        Sun, 18 Nov 2012 02:57:35 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id fm5sm2896102bkc.5.2012.11.18.02.57.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210018>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7fb5b50..4e2f4fb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -174,7 +174,7 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
 
-test_expect_failure '__gitcomp - doesnt fail because of invalid variable name' '
+test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
@@ -213,7 +213,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_nl - doesnt fail because of invalid variable name' '
+test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name' '
 	__gitcomp_nl "$invalid_variable_name"
 '
 
-- 
1.8.0
