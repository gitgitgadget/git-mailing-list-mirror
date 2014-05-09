From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/17] contrib: remove 'vim'
Date: Fri,  9 May 2014 14:11:28 -0500
Message-ID: <1399662703-355-3-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDB-0000aT-9G
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbaEITL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:11:57 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:53528 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaEITL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:11:56 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so3815707ykr.17
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ncf1LRlBeUM8sgWEY+M/iGUB6dcFx3mIioNTEUfqRAc=;
        b=vjHbHgReq4Ziqh4WYZwuC0gFHAEvgJlSx4Y7jvZnLDcY8et1jjGLkUhtiNIsWwQi87
         ydN6/x9tUIF/KhbfMo4ZjxZYTFwWp69NQCwqEayOKbCnCyP/vMRxTOLDz+DQU3Z/z0Hm
         Zb4osJIm5L2iXxJFzub9/KGYFgSUlhtw0C8u/H4Z8Rqum9NaSXBx4+0lDjFeJegdLi9e
         H4WpuWWwtJG08T3yprfim6QrN2m9wgCTNtkFxCWUNOep3OmOFqS2nD6t9Th5QKUNT+M1
         bNmEzrYPwSPSXjr1tZfTYKwQdIxNGGENmtGYhSxNTq1TanCtghdkYA0PgNwdb5K6A6Pe
         unrQ==
X-Received: by 10.236.100.177 with SMTP id z37mr17803303yhf.123.1399662716232;
        Fri, 09 May 2014 12:11:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm7400654yhb.46.2014.05.09.12.11.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:11:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248615>

There are only instructions for old versions of vim (<7.2) which don't
apply since six years.

The vast majority of people don't need these instructions.

Let's remove them.

Cc: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/vim/README | 22 ----------------------
 1 file changed, 22 deletions(-)
 delete mode 100644 contrib/vim/README

diff --git a/contrib/vim/README b/contrib/vim/README
deleted file mode 100644
index 8f16d06..0000000
--- a/contrib/vim/README
+++ /dev/null
@@ -1,22 +0,0 @@
-Syntax highlighting for git commit messages, config files, etc. is
-included with the vim distribution as of vim 7.2, and should work
-automatically.
-
-If you have an older version of vim, you can get the latest syntax
-files from the vim project:
-
-  http://ftp.vim.org/pub/vim/runtime/syntax/git.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitcommit.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitconfig.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitrebase.vim
-  http://ftp.vim.org/pub/vim/runtime/syntax/gitsendemail.vim
-
-These files are also available via FTP at the same location.
-
-To install:
-
-  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
-  2. To auto-detect the editing of various git-related filetypes:
-
-	$ curl http://ftp.vim.org/pub/vim/runtime/filetype.vim |
-		sed -ne '/^" Git$/, /^$/ p' >>$HOME/.vim/filetype.vim
-- 
1.9.2+fc1.28.g12374c0
