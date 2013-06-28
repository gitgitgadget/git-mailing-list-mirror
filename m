From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] configure: fix help screen
Date: Fri, 28 Jun 2013 19:19:42 +0200
Message-ID: <39f9e29341ce7818d1b3ed67d108345c7159f01d.1372439910.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 19:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UscKz-0003iQ-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab3F1RTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:19:54 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:34779 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab3F1RTx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:19:53 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so894194bkc.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7pRCzucNDHzvJdHhaK55SSDN7iG4iptAnfkxt/VvlY0=;
        b=UMDu8raGzEVuUeLYY9v8ZmXClU9Vy8l+w8/SM9uEGjI+JZ8hQYa9yTa28HcvPSBFmH
         biFFQw+rl+uYvPDnTKBiVz5L7gv0xE2bAx0whwlbSBN3VIl7aKf4LTapTV+L8h3TTYrF
         zQkvsgxxjsSoDZP4faVJPfUElBy5DY52P+bdZvXMdGZ0aWQEZ6HTzkWTyLsPxD5UcYW2
         VTHl3fhahprngSfWMc1qmtmLm75O/q4d2tSiKjzFdjo/+ju+fAPkuYQO8hr+kXeK8Tyg
         2kWd9pryqqxJUwPtFFrkOWmw4TrFC271uLnJAvYKUbNHXuhJJ2WpgvWZeEIPM6tD67I0
         XLcQ==
X-Received: by 10.205.9.8 with SMTP id ou8mr2006130bkb.76.1372439992295;
        Fri, 28 Jun 2013 10:19:52 -0700 (PDT)
Received: from localhost.localdomain (host166-10-dynamic.13-87-r.retail.telecomitalia.it. [87.13.10.166])
        by mx.google.com with ESMTPSA id eu16sm4068237bkc.0.2013.06.28.10.19.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 10:19:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.605.g85318f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229217>

The configure option to disable threading is '--disable-pthreads',
not '--without-pthreads'.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f3462d9..2f43393 100644
--- a/configure.ac
+++ b/configure.ac
@@ -193,7 +193,7 @@ AC_ARG_ENABLE([pthreads],
   [FLAGS is the value to pass to the compiler to enable POSIX Threads.]
   [The default if FLAGS is not specified is to try first -pthread]
   [and then -lpthread.]
-  [--without-pthreads will disable threading.])],
+  [--disable-pthreads will disable threading.])],
 [
 if test "x$enableval" = "xyes"; then
    AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads])
-- 
1.8.3.1.605.g85318f5
