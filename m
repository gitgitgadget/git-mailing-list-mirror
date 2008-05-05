From: imyousuf@gmail.com
Subject: [PATCH v2 1/5] git-submodule.sh: Add Long Usage instead of simple usage
Date: Mon,  5 May 2008 15:09:38 +0600
Message-ID: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:11:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswix-0004pg-4x
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbYEEJKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755651AbYEEJKT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:10:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64628 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbYEEJKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:10:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1027289nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OiuNELfDrq/C6DIcqrzErmupT3kDhW2qo5g4udQt4GM=;
        b=C1oV3o8o99HTwOaaGy6041F8LIsv4QVlpSr3fZy6CHaeEhTINXSx7gsH+O6cSFsk7dFHlRR+Rcw5d47sZGpcD+xJGFTR3mCG+rg0C7t2CFHAGrClktElwG4IQposV8c6xmrcxqdB14FanJf3q5uS9VD/FjVYLPQmasc6PpAc0GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=svv44wqVVyAiHSjSs5LtXu3ptyRFZEHlvQ6K92Ts9I6RJGPrHzINdPe3RR3LaidVqFzTEgGI67KHE7DgBEOx6WwMw6aWovBxKQov5g7Z1cfRIasLxSN4Fznqm5UXoBIlYbpV+TmIx+naSQNPQBCfTQPqteqzGNkeDm9OOrGzwYY=
Received: by 10.210.109.10 with SMTP id h10mr5355822ebc.170.1209978613667;
        Mon, 05 May 2008 02:10:13 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id h1sm11183415nfh.19.2008.05.05.02.10.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 02:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81256>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

With the already available commands the synopsis is quite hard to
read; thus converted it to Long usage instead. In process also
updated the file comment.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ce0f00c..a5ee2e5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1,12 +1,17 @@
 #!/bin/sh
 #
-# git-submodules.sh: add, init, update or list git submodules
+# git-submodules.sh: add, init, update, summary or status git submodules
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
-[--] [<path>...]"
+USAGE="<command> <options>
+Use $0 -h for more details"
+# Did not use '\' at the end of the lines to ensure that each synopsis
+# are in a separate line
+LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
+$0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
+$0 init|update [-q|--quiet] [--] [<path>...]
+$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
-- 
1.5.4.2
