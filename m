Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FFC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3636102A
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhDSXFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDSXFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:05:08 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E468C061763
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 16:04:37 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [8.42.69.49])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 09BFE80591;
        Mon, 19 Apr 2021 18:54:55 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] git-fast-import.txt: add missing LF in the BNF
Date:   Mon, 19 Apr 2021 16:54:39 -0600
Message-Id: <20210419225441.3139048-2-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419225441.3139048-1-lukeshu@lukeshu.com>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 Documentation/git-fast-import.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28..458af0a2d6 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -437,7 +437,7 @@ change to the project.
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-	('encoding' SP <encoding>)?
+	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
 	('merge' SP <commit-ish> LF)*
-- 
2.31.1

