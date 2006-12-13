X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Document the simple way of using of git-cat-file
Date: Thu, 14 Dec 2006 00:20:57 +0100
Message-ID: <20061213232056.11218.67473.stgit@lathund.dewire.com>
References: <20061213221841.GB4928@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:48:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1767 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:47:48 EST
X-Virus-Scanned: amavisd-new at localhost.localdomain
In-Reply-To: <20061213221841.GB4928@fieldses.org>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34263>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudpn-0003Y8-Bx for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751768AbWLMXru (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWLMXru
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:47:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13115 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751663AbWLMXrt (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 18:47:49 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 7E83F8030B8 for <git@vger.kernel.org>; Thu, 14 Dec
 2006 00:14:24 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 18778-07 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:14:23 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3]) by torino.dewire.com
 (Postfix) with ESMTP id E429D800199 for <git@vger.kernel.org>; Thu, 14 Dec
 2006 00:14:23 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id BF2D728E57 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:21:05 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 jAeXwMlTzBck for <git@vger.kernel.org>; Thu, 14 Dec 2006 00:21:00 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 79ACA28E42 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:20:57 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Since you can give a version and a path name to git-cat-file,
mention it in the man page.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 Documentation/git-cat-file.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 5e9cbf8..7abbf27 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -8,13 +8,14 @@ git-cat-file - Provide content or type i
 
 SYNOPSIS
 --------
-'git-cat-file' [-t | -s | -e | -p | <type>] <object>
+'git-cat-file' [-t | -s | -e | -p | <type>] [<object> | <commit-ish>:<path> ]
 
 DESCRIPTION
 -----------
 Provides content or type of objects in the repository. The type
 is required unless '-t' or '-p' is used to find the object type,
-or '-s' is used to find the object size.
+or '-s' is used to find the object size. The more user friendly variant
+takes a revision and a path name corresponding to the blob you want to see.
 
 OPTIONS
 -------
@@ -57,6 +58,9 @@ If '-p' is specified, the contents of <o
 Otherwise the raw (though uncompressed) contents of the <object> will
 be returned.
 
+If you don't know the object id, you can supply a version identifies,
+such as a branch name, a commit id or tag followed by a colon and a
+path name.
 
 Author
