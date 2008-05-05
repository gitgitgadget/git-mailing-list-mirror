From: imyousuf@gmail.com
Subject: [PATCH] git-submodule.sh: Add Long Usage instead of simple usage
Date: Mon,  5 May 2008 14:44:07 +0600
Message-ID: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 10:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswKE-000634-Eb
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbYEEIoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbYEEIoq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:44:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44279 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYEEIop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:44:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1024831nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OiuNELfDrq/C6DIcqrzErmupT3kDhW2qo5g4udQt4GM=;
        b=OCLFEmGLuQftTCEsO8/wfOsngJs0V7lRBfLqvp2OAVEFI8HPPG0pXGNkS8IT1d3JBGmQ3Oz1f2Awc4ex6b0rT7PGWHPlsybB7Oai6rvDY10cOe4y/QaC7WPBoun/3kqjtcV5BGGbTFvCNnJFBO3J3PEKNd+NQv1yMtkHsZ5nRNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hmZun9nbLiPTDUnM1Mik5k6M1u40O4wTMe6rh+YwIY6mK+4uF/c12Ac0hMIxBGQCfTEXp+5RM4cVND0vOKoi8et6J4EiAj1i/pXeiT4mCqPSjhEwYkY0tIxbAHSn2zg9rjbNUOhAeOa6K8SLBIQ89guwnQiSAfx+OqEyoNQ2dog=
Received: by 10.210.34.5 with SMTP id h5mr5355021ebh.84.1209977083762;
        Mon, 05 May 2008 01:44:43 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 35sm25149074nfu.4.2008.05.05.01.44.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 01:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81245>

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
