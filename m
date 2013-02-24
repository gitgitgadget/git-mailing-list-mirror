From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 08/16] git-cvsimport: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:16 -0800
Message-ID: <1361667024-49776-9-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoK-0007hj-3Q
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759469Ab3BXAu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:56 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:57858 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:54 -0500
Received: by mail-da0-f45.google.com with SMTP id v40so939573dad.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UHjXx6HmCOUgYnQazc9w+Sod2aZnCO7gw0xDKOO5hyk=;
        b=hI9PX6Gn/GDiJQHy/dbCmfOMIUbjJaPyLmL3n+sR3RlTMgPiGkBc1aAWH0cvwOyViq
         VnoiGpt424EtxjkKA8iWHjzDGDP6kQ1AawV3vgnchozb5xGZBxgWrWxPXIBypoVcTfzu
         iC24IO8E7WOdWEDi3l/vMvXDyi87TvqDlSm8PJ7rZHzOtDEM5ZEFhCFQiLiGHrhBZaby
         voBRBuUXDGiadw1tBCrLKNDxyQVPwx5or3lrxatZcYaK8/5nMgn0vEXm7loxkCd37bRx
         eXBGjclpWsIoB7oADiI6K1SLP85x2/uKq7hMGU0ZPwB8gGitxC+MzPC1hRomOoGFCTaM
         1UCQ==
X-Received: by 10.66.159.132 with SMTP id xc4mr11499060pab.145.1361667053988;
        Sat, 23 Feb 2013 16:50:53 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:53 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-8-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216967>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3679074..f1c3f49 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -107,7 +107,7 @@ my $work =
 $log->info("--------------- STARTING -----------------");
 
 my $usage =
-    "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
+    "usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
     "    --base-path <path>  : Prepend to requested CVSROOT\n".
     "                          Can be read from GIT_CVSSERVER_BASE_PATH\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
-- 
1.8.2.rc0.263.g20d9441
