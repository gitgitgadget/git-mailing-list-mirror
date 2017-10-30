Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9801FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdJ3MrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:47:03 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:41586
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751990AbdJ3MrC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509367620;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Cre68MX7V03tO+yOJSRVK+yJGd/auf4BCqsW2sQYCNk=;
        b=XBgmiq5PExMdMAidR2XXFCyGWHAzRB8Llz2LHW3+L1Lf8d8K9YXyo9WsWV8UMm4o
        2p5lO0f3m4b+seTn+wLTD8YZ7X4HpmkqHZnNFzbeBtpqazFqorwWIIrHUBYogYKap9D
        9pYOjBCueVbhObBlvzUQcI+OI53lIis1GL610+bo=
From:   Eli Boyarski <eli@boyar.ski>
To:     git@vger.kernel.org
Message-ID: <0102015f6d5221d7-eb6c29ae-2c92-41e5-b7e1-735c88fd1e89-000000@eu-west-1.amazonses.com>
Subject: [PATCH] 2.15.0.txt: fixed a typo
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Oct 2017 12:47:00 +0000
X-SES-Outgoing: 2017.10.30-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/RelNotes/2.15.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.15.0.txt b/Documentation/RelNotes/2.15.0.txt
index 248ba70c3dc1c..03792dd9fa28e 100644
--- a/Documentation/RelNotes/2.15.0.txt
+++ b/Documentation/RelNotes/2.15.0.txt
@@ -65,7 +65,7 @@ UI, Workflows & Features
    learned to take the 'unfold' and 'only' modifiers to normalize its
    output, e.g. "git log --format=%(trailers:only,unfold)".
 
- * "gitweb" shows a link to visit the 'raw' contents of blbos in the
+ * "gitweb" shows a link to visit the 'raw' contents of blobs in the
    history overview page.
 
  * "[gc] rerereResolved = 5.days" used to be invalid, as the variable

--
https://github.com/git/git/pull/423
