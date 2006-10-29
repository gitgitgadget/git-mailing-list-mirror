X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/2] Mention that pull can work locally in the synopsis
Date: Sun, 29 Oct 2006 21:09:40 +0100
Message-ID: <20061029200940.11233.20277.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:09:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30451>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGyN-0000RE-15 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965368AbWJ2UIu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWJ2UIu
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:08:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:28698 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S965370AbWJ2UIt (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:08:49 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id B3F058030A7 for <git@vger.kernel.org>; Sun, 29 Oct
 2006 21:05:31 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 21221-10 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:05:31 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2]) by torino.dewire.com
 (Postfix) with ESMTP id 5A4068003E1 for <git@vger.kernel.org>; Sun, 29 Oct
 2006 21:05:27 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 6394428E6D for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:09:58 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 gYqY254claQG for <git@vger.kernel.org>; Sun, 29 Oct 2006 21:09:46 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 38E4828E5C for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 21:09:44 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 Documentation/git-pull.txt |    2 +-
 Documentation/git.txt      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 51577fc..2a5aea7 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -3,7 +3,7 @@ git-pull(1)
 
 NAME
 ----
-git-pull - Pull and merge from another repository
+git-pull - Pull and merge from another repository or a local branch
 
 
 SYNOPSIS
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 595cca1..fff07e1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -324,7 +324,7 @@ gitlink:git-mv[1]::
 	Move or rename a file, a directory, or a symlink.
 
 gitlink:git-pull[1]::
-	Fetch from and merge with a remote repository.
+	Fetch from and merge with a remote repository or a local branch.
 
 gitlink:git-push[1]::
