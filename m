X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-update-index(1): fix use of quoting in section title
Date: Sun, 12 Nov 2006 22:28:43 +0100
Message-ID: <20061112212843.GA10481@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 21:29:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31280>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjMsr-0001QT-0Z for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753224AbWKLV2x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 16:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbWKLV2x
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:28:53 -0500
Received: from [130.225.96.91] ([130.225.96.91]:45236 "EHLO mgw1.diku.dk") by
 vger.kernel.org with ESMTP id S1753224AbWKLV2x (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:28:53 -0500
Received: from localhost (localhost [127.0.0.1]) by mgw1.diku.dk (Postfix)
 with ESMTP id 467297700CE for <git@vger.kernel.org>; Sun, 12 Nov 2006
 22:28:45 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1]) by localhost (mgw1.diku.dk
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 06285-08 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 22:28:44 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140]) by
 mgw1.diku.dk (Postfix) with ESMTP id 1EABD7700C8 for <git@vger.kernel.org>;
 Sun, 12 Nov 2006 22:28:44 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225]) by nhugin.diku.dk
 (Postfix) with ESMTP id 8339E6DF84F for <git@vger.kernel.org>; Sun, 12 Nov
 2006 22:25:46 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873) id 057B762A37; Sun, 12
 Nov 2006 22:28:43 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-update-index.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 41bb7e1..0e0a3af 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -216,8 +216,8 @@ $ git ls-files -s
 ------------
 
 
-Using "assume unchanged" bit
-----------------------------
+Using ``assume unchanged'' bit
+------------------------------
 
 Many operations in git depend on your filesystem to have an
 efficient `lstat(2)` implementation, so that `st_mtime`
-- 
1.4.3.3.g9621-dirty


-- 
