From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 05/16] git-archimport: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:13 -0800
Message-ID: <1361667024-49776-6-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoI-0007hj-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457Ab3BXAur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:47 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:57150 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:46 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so734307dan.37
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZAD3/vwTkEvmo20/opKxKRR5zKePsuI8BPBtbvVs+ro=;
        b=lvHzn7xhm7A4fcwhcHWnqY0Xrdsyk8wv2k4nxmF2+8qGxXPfewISAi5GzBmQR/6nCf
         d3/v66khE5X6s3E4rdBt4kdBcZkb4aGwTgSmHgQ1hUQfVK291Kd8rIJSFYDFV2XiIegO
         wXAYE7YUCnvh037FzKcr4+Axr4ezSbld09PcZJlvWz1V1/fQ2YnOzV1VsaHXnuA/MlOT
         wnyfKv5IEAZJ2Hoe8tlCevAsJ0AAsfs8jXBvsrH+c/gaPU0wYMuRjZ87SvVO8O1KdEgF
         ZJ/tXvDCfstklwAlll6a7NzGMHXs68ZK7dsldLvmrwEwyin5sdFdj3/u3UjuvZWlCXlf
         bhMg==
X-Received: by 10.68.189.71 with SMTP id gg7mr10858987pbc.15.1361667045989;
        Sat, 23 Feb 2013 16:50:45 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:44 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216964>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-archimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-archimport.perl b/git-archimport.perl
index bc32f18..9cb123a 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -75,7 +75,7 @@ our($opt_h,$opt_f,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
-Usage: git archimport     # fetch/update GIT from Arch
+usage: git archimport     # fetch/update GIT from Arch
        [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ] [ -D depth ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
-- 
1.8.2.rc0.263.g20d9441
