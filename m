From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 3/7] Documentation: git-init: template directory: reword
Date: Fri,  8 Aug 2014 10:29:16 -0700
Message-ID: <1407518960-6203-4-git-send-email-linusarver@gmail.com>
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
	id 1XFo0C-00031k-QM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbaHHRah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:37 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:64413 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaHHRad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:33 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so4357034yha.17
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oPNbElGv9yKjc/OUoYpUqvFipA7YJBGRCe5XIaX0Tg=;
        b=lA/c1aAJNTIbD46NOGsxUuzbjWCymPPCEuqYkG51UONcn8yRCIGYOuLJaFiCeW6Lvk
         r3HahXOcUNxOJBkIPepGzOPZ3BuNCIXvOxDNHm8YphxfaKotyiLnbDLEKBoFurQ5tRDu
         DgF6dDbsklt+3Jf00/XheFrkrp6RSWq8WbJ/eIvYQbsvQc6CJw8Qdsk8s+cY1L+3VI9e
         0zjBSYr4gsWf3C28WG0VElQjJ0UCf393IFpRjIo3XfRqN3pkMt/p8ETiuYPgL/9a0TaF
         2Itj339BxewF1WZNDTwD2n2F0qYrTxwVPRFYt8oulgoo3+pP49+wMQ1mPA0P8Zh1YIXj
         tTMw==
X-Received: by 10.236.27.105 with SMTP id d69mr16324536yha.72.1407519033066;
        Fri, 08 Aug 2014 10:30:33 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255057>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index c02ccd0..6ffe721 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -119,15 +119,15 @@ TEMPLATE DIRECTORY
 The template directory contains files and directories that will be copied to
 the `$GIT_DIR` after it is created.
 
-The template directory used will be (in order):
+The template directory will be one of the following (in order):
 
- - The argument given with the `--template` option.
+ - the argument given with the `--template` option;
 
- - The contents of the `$GIT_TEMPLATE_DIR` environment variable.
+ - the contents of the `$GIT_TEMPLATE_DIR` environment variable;
 
- - The `init.templatedir` configuration variable.
+ - the `init.templatedir` configuration variable; or
 
- - The default template directory: `/usr/share/git-core/templates`.
+ - the default template directory: `/usr/share/git-core/templates`.
 
 The default template directory includes some directory structure, some
 suggested "exclude patterns", and copies of sample "hook" files.
-- 
2.0.4
