Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCCA1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbeKPVQQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:16 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:2587 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeKPVQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv3gYs1u; Fri, 16 Nov 2018 11:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366253;
        bh=PJBFfl63P5M+GRrJlbaCH4djRSXWY5EuZ4Qf8v/4Yuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=joLltVZnasc9fyAewPSP6bLZA2A+pGL/XDUfOcsJPp7eaxCIIv+4m99bES+dTIC/D
         ws3BCfD58yonU2xT1JNISmj0ebHjoxqOZnry8xOnfs1+y5CiiejOtIwgDyrofldkdZ
         +p9w8O8q32DH8EtdRfEGyCsbsQTUhSne2z47oc2M=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=r8A0gJ4v-cBAE6CE6-oA:9
 a=6w-IK5kIZ6GblxTP:21 a=SXTtIeB45e2yxnO1:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 2/9] diff: use whitespace consistently
Date:   Fri, 16 Nov 2018 11:03:49 +0000
Message-Id: <20181116110356.12311-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLjH6KXhI4NEGJyMkK5HiGiHMMJkoHDLt8J2mUqouZhWlXil29pFKDf1HTRAb6lLhuBRH1iSPHGoeD8LVc1D5J4Xo8LM2oVzLacmZnOVKtrkMjypPFdv
 Vq5iQhz/r/bh4d2hJaWxU45NM1rId2EuPHNqF67vwpi7LqOUfQQq5EgLvcrJJrvAQ57ooEhIJ0ybimL9Iwy8RKglaYqcmMs3CQ3ItSQx9AjAlImrQSI8j8Co
 o/thJ4paG7j+tcSxnQ7/dA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Most of the documentation uses 'whitespace' rather than 'white space'
or 'white spaces' convert to latter two to the former for consistency.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/diff-options.txt | 4 ++--
 diff.c                         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 151690f814..57a2f4cb7a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -298,7 +298,7 @@ dimmed-zebra::
 	settings. It is the same as `--color-moved=no`.
 
 --color-moved-ws=<modes>::
-	This configures how white spaces are ignored when performing the
+	This configures how whitespace is ignored when performing the
 	move detection for `--color-moved`.
 ifdef::git-diff[]
 	It can be set by the `diff.colorMovedWS` configuration setting.
@@ -316,7 +316,7 @@ ignore-all-space::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
 allow-indentation-change::
-	Initially ignore any white spaces in the move detection, then
+	Initially ignore any whitespace in the move detection, then
 	group the moved code blocks only into a block if the change in
 	whitespace is the same per line. This is incompatible with the
 	other modes.
diff --git a/diff.c b/diff.c
index c29b1cce14..78cd3958f4 100644
--- a/diff.c
+++ b/diff.c
@@ -320,7 +320,7 @@ static int parse_color_moved_ws(const char *arg)
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
 	    (ret & XDF_WHITESPACE_FLAGS))
-		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+		die(_("color-moved-ws: allow-indentation-change cannot be combined with other whitespace modes"));
 
 	string_list_clear(&l, 0);
 
-- 
2.19.1

