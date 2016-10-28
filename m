Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFD12022A
	for <e@80x24.org>; Fri, 28 Oct 2016 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941570AbcJ1KU6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 06:20:58 -0400
Received: from stcim.de ([78.46.73.102]:53096 "EHLO stcim"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936298AbcJ1KUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 06:20:55 -0400
X-Greylist: delayed 1116 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2016 06:20:55 EDT
Received: from 55d41b26.access.ecotel.net ([85.212.27.38] helo=localhost.localdomain)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <contact@stefanchrist.eu>)
        id 1c03zK-00024e-Ha
        for git@vger.kernel.org; Fri, 28 Oct 2016 12:02:14 +0200
From:   Stefan Christ <contact@stefanchrist.eu>
To:     git@vger.kernel.org
Subject: [PATCH] Documenation: fmt-merge-msg: fix markup in example
Date:   Fri, 28 Oct 2016 12:01:26 +0200
Message-Id: <1477648886-12096-1-git-send-email-contact@stefanchrist.eu>
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example was not rendered as verbatim text. Fix it.

Signed-off-by: Stefan Christ <contact@stefanchrist.eu>
---
 Documentation/git-fmt-merge-msg.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6526b17..44892c4 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -60,10 +60,10 @@ merge.summary::
 EXAMPLE
 -------
 
---
+---------
 $ git fetch origin master
 $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
---
+---------
 
 Print a log message describing a merge of the "master" branch from
 the "origin" remote.
-- 
2.7.3

