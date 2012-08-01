From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] git-rebase.sh: fix typo
Date: Wed,  1 Aug 2012 19:09:09 +0200
Message-ID: <1343840949-3122-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 19:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwcQX-0003iy-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 19:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab2HARJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 13:09:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39681 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2HARJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 13:09:34 -0400
Received: by bkwj10 with SMTP id j10so3882205bkw.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MtXA5lpe56hhws1D/3LXordnZdyeJDRX5kNRzy9p57g=;
        b=tzFkk/gryvnueEsxrsOOb/mwoMvC54hMRXjv9HVbm3vOgdp49GHGKbPbMTtuJIi2SY
         aPUmVnWIorjtJf8Av6wJJNvdYdq2BjNQT7W5UI52ztxiP80obQeKvR1PoMtbPAO2KDzG
         NuTS9z/IcdOgF7ipKsdomCt+eqxJz+t+kuoNw8KvFOZFEIE0TteF5EBrWIDTBlxOGaAC
         OrKgrlDN+Zl1ZHM42nc7N0Cbvi0ruGrxfu7yNk9BZVYZPG7U5ySUS35cvuJOmHQC8bDN
         MjlHLAS24XBFyNIxECEJGmrqEfpuG571cXOcJT4JlxS+k/3eHlyGObJFvbAiJEwtk7FE
         h9iA==
Received: by 10.204.148.86 with SMTP id o22mr7286195bkv.59.1343840972488;
        Wed, 01 Aug 2012 10:09:32 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id u8sm2138067bks.0.2012.08.01.10.09.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 10:09:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202712>

Fix a typo in the error messages which is
shown if it seems that a rebase is already
in progress.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 0e6fd09..15da926 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -348,7 +348,7 @@ then
 	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
 	die "
 $(eval_gettext 'It seems that there is already a $state_dir_base directory, and
-I wonder if you ware in the middle of another rebase.  If that is the
+I wonder if you are in the middle of another rebase.  If that is the
 case, please try
 	$cmd_live_rebase
 If that is not the case, please
-- 
1.7.12.rc1
