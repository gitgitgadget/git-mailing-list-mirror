From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 7/7] Documentation: git-init: flesh out example
Date: Sat,  2 Aug 2014 11:06:57 -0700
Message-ID: <1407002817-29221-8-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:08:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdj5-00082o-IX
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbaHBSIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:08:11 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:33282 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:08:09 -0400
Received: by mail-yh0-f54.google.com with SMTP id v1so3312858yhn.41
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Dy981Dg7tkVR0FPArszy+YHfv53CVi1+3yL2IJyHZ0=;
        b=vD8tNvq6c/h5ZsCgCWOhPC9/ewIlpZr3CFF8ZZiH6IDOhVCSAX8ldsMcNHCg+Yo2di
         DDdFo7Kq5IJTEW+5l8j9zEhLenIoiKdiAzUQBmhYI4Q+5xT/9FE44xwvySjTKJM+UfIf
         HdiO1BzhJbLIX/+vXNt0FHIg6y6ZZTODRBqgbdsctmh/2LRhKfJDEKTVwaHpmdHGehR3
         xwOEtpbXPQoQq0/Ky/cja/9MQvtsQIe0EOjsCdF7xfd433KSDKXFCYEMyU40iXzmH52U
         4gKrxteu5XHEUMqpmGzegiDyGnJMgqHjmSs+ZBsTM4q02wjrQZnvY3m8277jjdVy0rtu
         XKwA==
X-Received: by 10.236.148.209 with SMTP id v57mr20450049yhj.140.1407002889006;
        Sat, 02 Aug 2014 11:08:09 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.08.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:08:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254712>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b94d165..16e9f9c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -138,10 +138,12 @@ Start a new Git repository for an existing code base::
 $ cd /path/to/my/codebase
 $ git init      <1>
 $ git add .     <2>
+$ git commit    <3>
 ----------------
 +
-<1> prepare /path/to/my/codebase/.git directory
-<2> add all existing file to the index
+<1> Create a /path/to/my/codebase/.git directory.
+<2> Add all existing files to the index.
+<3> Create the first root-commit.
 
 GIT
 ---
-- 
2.0.3
