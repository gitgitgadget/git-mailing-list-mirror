From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 3/7] Documentation: git-init: template directory: reword
Date: Sat,  2 Aug 2014 11:06:53 -0700
Message-ID: <1407002817-29221-4-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdiq-0007nj-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbaHBSHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:07:55 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:64901 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:07:54 -0400
Received: by mail-yh0-f46.google.com with SMTP id a41so3361526yho.19
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2r2D8iAbwLA4l+6f3jVXqk+JMov+WEUr667x2eKeGoc=;
        b=D7zuLSzZtr23FrrVEWdSBDsl3WWt+57vGBiN43Dns4K5/qQbPhSOcly0GbB/iJYose
         PhoXj1dwxWdMlUQ0WWWfFrfl86R9OUCeDQ1yG8ZNMkCSTMB/tBcjH8HSrEtMUdUpKWNK
         S9VW/K0RNAgZUancmCqGar/ONKMdw2uiz0EdC7PQy9qhg1mryq9h41gQiP3RCC9tvacQ
         Jl+oVokRQ1zqxN+Rk5dTNuXl3o0QZbRqgZAvZDAoRQOe0oDFh0+iSScTUSIrrplZXnQv
         +MhI2wR9j5c2lt5otkBr51I2b/xpLOzYHWW7ZKNixK3ljmn1YY9ecTAJHZNv75xwLZYX
         pMDg==
X-Received: by 10.236.220.100 with SMTP id n94mr20039441yhp.77.1407002873672;
        Sat, 02 Aug 2014 11:07:53 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:07:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254708>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 45501d0..f21b85b 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -113,22 +113,18 @@ line, the command is run inside the directory (possibly after creating it).
 
 --
 
-
 TEMPLATE DIRECTORY
 ------------------
 
 The template directory contains files and directories that will be copied to
 the `$GIT_DIR` after it is created.
 
-The template directory used will be (in order):
-
- - The argument given with the `--template` option.
-
- - The contents of the `$GIT_TEMPLATE_DIR` environment variable.
-
- - The `init.templatedir` configuration variable.
+The template directory will be one of the following (in order):
 
- - The default template directory: `/usr/share/git-core/templates`.
+- the argument given with the `--template` option;
+- the contents of the `$GIT_TEMPLATE_DIR` environment variable;
+- the `init.templatedir` configuration variable; or
+- the default template directory: `/usr/share/git-core/templates`.
 
 The default template directory includes some directory structure, some
 suggested "exclude patterns", and copies of sample "hook" files.
-- 
2.0.3
