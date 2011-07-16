From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] git-config: Remove extra whitespaces
Date: Sun, 17 Jul 2011 03:25:52 +0530
Message-ID: <1310853352-18645-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 23:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiCrW-0003Cp-Tx
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 23:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1GPV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 17:56:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53588 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1GPV4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 17:56:11 -0400
Received: by pzk3 with SMTP id 3so2801466pzk.5
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mr+Hn9jbhcqIx0dVwQsIzx673i9prhurwJ2qTe8rI/A=;
        b=Dtoig4hUiVKHGwyyY4ClZ0znd8jmTrXT9UioSjQFzT0bv13aI7pP0oz2FPYg7hcNe3
         AiOCkn/t4R685B/ojxNs6FDYuoq0O3ImU7bNcawPtR66Qb10jHtGM3hZ1uv9QNWjRzO/
         BvQ+qIl74QjvUFr6Hk8rm4izAdvD4dW5jxAcM=
Received: by 10.142.1.5 with SMTP id 5mr2147956wfa.236.1310853371132;
        Sat, 16 Jul 2011 14:56:11 -0700 (PDT)
Received: from localhost.localdomain ([203.199.213.3])
        by mx.google.com with ESMTPS id e15sm765115wfd.15.2011.07.16.14.56.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 14:56:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.485.gad3dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177287>

Remove extra whitespaces introduced by commits
01ebb9dc and fc1905bb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index b73c449..4183f80 100644
--- a/config.c
+++ b/config.c
@@ -1502,10 +1502,10 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 		}
 	}
 	fclose(config_file);
- unlock_and_out:
+unlock_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error("could not commit config file %s", config_filename);
- out:
+out:
 	free(config_filename);
 	return ret;
 }
-- 
1.7.6.485.gad3dc
