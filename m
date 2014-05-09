From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 12/25] contrib: remove 'vim'
Date: Thu,  8 May 2014 19:58:23 -0500
Message-ID: <1399597116-1851-13-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZKe-0000XB-Of
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbaEIBK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:10:28 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:45534 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073AbaEIBKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:24 -0400
Received: by mail-yk0-f171.google.com with SMTP id 142so2890901ykq.2
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8aTRU3re50atfraUB6YsrRXhHTOlH+ciiTJZFL4aYA=;
        b=oRfPGwEAjal03Np/jyS/Fw3R1f923rBPhgJ96u2Rl9h7GRNq9ui/tH7hLNEELkgkIc
         4EReGDcxp47NENEPFdrUd9LJn9vjIn7Jg6URrAu4jZt//i1bLu2Y+zoYlBpObsIGi/aC
         jiMBYsyajhIXIx14QZXsv3pwMiGK+NFmLDLEFw5azfxsVU1IxPWlqIulQJgfeaLvqiUa
         XC2jLnTI21FUxiqClExNRgyTN/Z09KaKh8ODOJT5Ds8i2/zPDUT8xMmUVfjbZfF5b7Lk
         OXGfYMAnT5RO1F1FmEfQydAVFv36lHRGImm8wkuQ6xxIa8tmQ5i/IzySGdP1f/UGUVmn
         aAkA==
X-Received: by 10.236.61.45 with SMTP id v33mr10332807yhc.20.1399597823500;
        Thu, 08 May 2014 18:10:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t27sm3906246yho.55.2014.05.08.18.10.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248477>

There's nothing there.

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
1.9.2+fc1.27.gbce2056
