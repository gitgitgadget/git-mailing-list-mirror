From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage string.
Date: Thu, 17 Sep 2009 17:51:40 -0400
Message-ID: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 23:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoOtr-0005uE-4m
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 23:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZIQVwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 17:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbZIQVwF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 17:52:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:24321 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZIQVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 17:52:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so175128qwd.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ii2JWupYtCDcBipsYzo3dPJYADfgPURsbwLW+Ct8Afo=;
        b=SnviE97+r45VhWXuF0BRq+Li6vh4CUttx4zSPaCd9XOGGvCgDl3wuyNEFHADBfLwZd
         t7SspJfGYLyin08ind7ybNUfV2WuSYY5XAubkEODZ7urCBjKH6vfMj+Ic9Wx/64l76wa
         XMIuf78S0SSkuCfkOpBU+xkCLtOThCxiO8p2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=S2ARqmijKQcQZpi9D6AkG89ft0Qlgmqydhd0YW3tkk1ypkyNRBvnUJfniozfpaZw+h
         kCokvd3pY/eIa9YmO6goYskbzYumP35JUZ54BK4SLT33kAaT59wCb6AXFy7pxR3xpcIY
         B6VsadYXwgUjTps+wlrfzm25WyEO7zPPaOHXU=
Received: by 10.224.102.212 with SMTP id h20mr855836qao.40.1253224326829;
        Thu, 17 Sep 2009 14:52:06 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 6sm424169qwd.3.2009.09.17.14.52.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 14:52:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128774>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-pack-objects.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7a390e1..4494a68 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -22,15 +22,15 @@
 #include <pthread.h>
 #endif
 
-static const char pack_usage[] = "\
-git pack-objects [{ -q | --progress | --all-progress }] \n\
-	[--max-pack-size=N] [--local] [--incremental] \n\
-	[--window=N] [--window-memory=N] [--depth=N] \n\
-	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
-	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [--include-tag] \n\
-	[--keep-unreachable | --unpack-unreachable] \n\
-	[<ref-list | <object-list]";
+static const char pack_usage[] =
+  "git pack-objects [{ -q | --progress | --all-progress }] \n"
+  "        [--max-pack-size=N] [--local] [--incremental] \n"
+  "        [--window=N] [--window-memory=N] [--depth=N] \n"
+  "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n"
+  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n"
+  "        [--stdout | base-name] [--include-tag] \n"
+  "        [--keep-unreachable | --unpack-unreachable] \n"
+  "        [<ref-list | <object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
-- 
1.6.5.rc0.dirty
