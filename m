X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Document git-diff whitespace flags -b and -w
Date: Sun,  3 Dec 2006 17:24:41 +0100
Message-ID: <11651630814064-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sun, 3 Dec 2006 16:25:28 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=lqdeheSxErCK4fZXiKOwa1A2g9T+33u0RWTAbNy0Hn69BH2okzx2eV0uG7dXNTzWxou/TENvmG6oAvXBjEK5YYwA6LbmhtFKvTlP7TGV3ivG2k2wD5nYulZfYVaIwu7L9QAscTDAC4usL20bo7wTns1NnLI5dkCBd1/U93r8DT0=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33115>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqu9d-0005PX-8z for gcvg-git@gmane.org; Sun, 03 Dec
 2006 17:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756297AbWLCQZV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 11:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756336AbWLCQZV
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 11:25:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:7122 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1756297AbWLCQZU
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 11:25:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2785359uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 08:25:19 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr10508570ugi.1165163118868; Sun, 03
 Dec 2006 08:25:18 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 b23sm12437350ugd.2006.12.03.08.25.18; Sun, 03 Dec 2006 08:25:18 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kB3GOiHJ024334; Sun, 3 Dec 2006 17:24:45 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kB3GOgPG024333; Sun, 3 Dec 2006 17:24:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Document git diff options -b / --ignore-space-change and
-w / --ignore-all-space, introduced by Johannes Schindelin
in commit 0d21efa51cc7de5250d5da46bceacda78ba35373:
  "Teach diff about -b and -w flags".

The description of options is taken from GNU diff man page and
GNU Diffutils info documentation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Inspired by kblin (Kai Blin) asking on #git about git-diff option to
ignore whitespace only change.

 Documentation/diff-options.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e112172..9cdd171 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -129,5 +129,21 @@
 -a::
 	Shorthand for "--text".
 
+--ignore-space-change::
+	Ignore changes in amount of white space.  This ignores white
+	space at line end, and consider all other sequences of one or
+	more white space characters to be equivalent.
+
+-b::
+	Shorthand for "--ignore-space-change".
+
+--ignore-all-space::
+	Ignore white space when comparing lines.  This ignores
+	difference even if one line has white space where the other
+	line has none.
+
+-w::
+	Shorthand for "--ignore-all-space".
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
-- 
1.4.4.1
