From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 7/7] Documentation: git-init: flesh out example
Date: Fri,  8 Aug 2014 10:29:20 -0700
Message-ID: <1407518960-6203-8-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFo0E-00031k-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaHHRap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:45 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:44965 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbaHHRal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:41 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so4069570ykq.35
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+RxpmNVvEF3sxCj/nderLrAkUfzEsakAMTVAihlekE=;
        b=Rw0BC+WFPAjq0rlhkj+vCQS6xPYgLKYxrD1zZcHhrNZdFg6UvJ6S7Df2UpWB5Qj5Ed
         15hQCT9wWgrFZE0+nt5LKAIIuKFU/CYTbRRLUyTrHvje9DRRq6xFnGpM9h0CVSOsjHhW
         pqQrqqiO9sUTEIbaspVLjQRwD0npg/9T4hFYnuEhROKZBHV9rE1EQiKcfbLG4qnGozuZ
         GlPLDCQzctSpPLZJe/ibrY6ekEhMmLrBVf783eHn/sxjx73wgacCDBS7zayrUUAB0mYf
         d9aMLBFq4EF92e5TONCSxlXUbuq+75XyOAGzKKOxJ4b7nfcD2AQIixbQFOnjN2GgnwIJ
         D4AA==
X-Received: by 10.236.194.130 with SMTP id m2mr16207446yhn.95.1407519041055;
        Fri, 08 Aug 2014 10:30:41 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255055>

Add a third step `git commit` after adding files for the first time.

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 9f2c7d8..369f889 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -141,10 +141,12 @@ Start a new Git repository for an existing code base::
 $ cd /path/to/my/codebase
 $ git init      <1>
 $ git add .     <2>
+$ git commit    <3>
 ----------------
 +
 <1> Create a /path/to/my/codebase/.git directory.
 <2> Add all existing files to the index.
+<3> Record the pristine state as the first commit in the history.
 
 GIT
 ---
-- 
2.0.4
