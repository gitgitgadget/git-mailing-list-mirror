Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E03C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C0613FB
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbhDVAdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:33:13 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:60064 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhDVAdN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 20:33:13 -0400
Received: from lukeshu-dw-thinkpad (c-73-229-136-185.hsd1.co.comcast.net [73.229.136.185])
        by mav.lukeshu.com (Postfix) with ESMTPSA id D639E80590;
        Wed, 21 Apr 2021 20:32:38 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 1/3] git-fast-import.txt: add missing LF in the BNF
Date:   Wed, 21 Apr 2021 18:27:47 -0600
Message-Id: <20210422002749.2413359-2-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422002749.2413359-1-lukeshu@lukeshu.com>
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
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

