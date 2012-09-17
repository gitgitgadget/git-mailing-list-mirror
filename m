From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t/perf: add "trash directory" to .gitignore
Date: Mon, 17 Sep 2012 22:36:18 +0530
Message-ID: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDemZ-0007aY-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab2IQRGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:06:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48822 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab2IQRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:06:27 -0400
Received: by pbbrr13 with SMTP id rr13so9315306pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=4zGo0SUbXq2tS5CF5jXtxwNAEJKs8gnH8t4dTrNAakI=;
        b=IgHx7k95Pv7YyjiGuputtI2gYIeu7FNSSIAXvC0Nrrak6f9wvgnD44nYUuEbmslfPs
         U1jOfG+h0NQlieHwzlAqubPt37bf8lpJxBz/GSkooJ+gakMxuTrDQGfRkOD9db1iFY34
         LBBTuJuQubmqRiO8f7sRtmBW9fJjiLw7WePZMU5x+jQlv70b47hsw9y29vRquCUg02LW
         bE/60rNF3JsAfmIF/0JqD9mH8ISGFqGloDNm3tAetX4TVs8SanO4Um1Qtd/uJ2cHFlyr
         Urp3OI+zt6ReLjv3Q3JfNNVhjUSQueqbe7mvytIkReNSHfDL8f5ivRpKZ0jRjt2Gyg5k
         ELgw==
Received: by 10.68.217.97 with SMTP id ox1mr23429153pbc.138.1347901586693;
        Mon, 17 Sep 2012 10:06:26 -0700 (PDT)
Received: from localhost.localdomain ([49.206.170.14])
        by mx.google.com with ESMTPS id te6sm2196915pbc.29.2012.09.17.10.06.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 10:06:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205711>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/perf/.gitignore |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/perf/.gitignore b/t/perf/.gitignore
index 50f5cc1..0061cbc 100644
--- a/t/perf/.gitignore
+++ b/t/perf/.gitignore
@@ -1,2 +1,3 @@
-build/
-test-results/
+/build
+/test-results
+/trash directory*
-- 
1.7.8.1.362.g5d6df.dirty
