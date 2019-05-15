Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528F71F461
	for <e@80x24.org>; Wed, 15 May 2019 22:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEOWrU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:47:20 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:46916 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEOWrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 18:47:19 -0400
Received: from localhost.localdomain ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id R2g6hewKCnuQZR2g8h9y9W; Wed, 15 May 2019 23:47:17 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=anyJmfQTAAAA:8
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=hZl4FlbxAAAA:8 a=PKzvZo6CAAAA:8
 a=xtxXYLxNAAAA:8 a=_P215tvOIjpIuU0ZxgcA:9 a=YHcIV1kcuJAA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22 a=zNGlSMxTWkni11D5GzKz:22 a=q92HNjYiIAC_jH7JDaYf:22
 a=xts0dhWdiJbonKbuqhAr:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
From:   Philip Oakley <philipoakley@iee.org>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/2] Doc: git.txt: remove backticks from link and add git-scm.com/docs
Date:   Wed, 15 May 2019 23:47:09 +0100
Message-Id: <20190515224709.2936-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.1517.gbad5f960a3.dirty
In-Reply-To: <20190515224709.2936-1-philipoakley@iee.org>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
 <20190515224709.2936-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfM/fnHInAh7W/qjEyVZfe55lZWEtsb1nKhihiDywim+jAkIYHG+3TkwqmOQcNHTu1zTXatsjMKQ0r9XJUgJLOZEw/HV1j/fGWo/zjbft4VZS5Yx/gJJM
 Z2iSVpnb/XRSadGeCccoaYDmFiVvrvlz1lUWKIxXbSqggeMp3INRjhYMiIoseHG4IsA5rkYNzXFH0PZoNxjOVY81o4vE6b2MeMycpSTYmWegpo8sVKpp+p5t
 YEkn3yraWyucLp4wkF8mdkdDU2X/HPxhkNm66CU8SW9WmvbJv/6Gh/WZWWW+fn0nDSv2XMNrrQBhBHo54jQhPUPlqT9uhZiCyMzOINLOjr13CMJZIWIoNPEM
 3gFNoQYOuZDo1tTriVs7lb+VvxXh9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While checking the html formatted git(1) manual page, it was noted
that the link to https://git.github.io/htmldocs/git.html was formatted
as code. Remove the backticks.

While at it, add the https://git-scm.com/docs link which one reviewer
noted had linkable section headings.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dbf92f6ac6..edcb9936b5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -33,7 +33,8 @@ individual Git commands with "git help command".  linkgit:gitcli[7]
 manual page gives you an overview of the command-line command syntax.
 
 A formatted and hyperlinked copy of the latest Git documentation
-can be viewed at `https://git.github.io/htmldocs/git.html`.
+can be viewed at https://git.github.io/htmldocs/git.html
+or https://git-scm.com/docs.
 
 
 OPTIONS
-- 
2.21.0.windows.1.1517.gbad5f960a3.dirty

