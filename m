Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAD120A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdJAQTF (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:19:05 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:56493 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJAQTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:19:03 -0400
Received: by mail-pg0-f54.google.com with SMTP id n1so1189874pgt.13
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L+xq6Z+tkIdZzHSipzjMp2q/qYAWcGMx2g5Cxu1SKSU=;
        b=TxuT4j801GNnC8rxX+pVTDY/igb3PfOrCezzb+rUqFplxPUflqIaE7M2JYbsI1zVGY
         lw5eAMsGZRdoLlxxsInRP6HUR9FfLqEUoEN6NOykayP+AzNzR+dInt9esdhiYbJfTP1/
         A/x6nfKXTpbgYy++69m59wbZQ+POfZ4AowH3v+et0+LZx/eLAWY3ae88ncJLHd+iv/uP
         6iFPnoD3PocisbEqRPGJ/yDmAGQ3J5GN33h4+fC6JsEaXUCxeaYKYV/CUwsOSIDS9mfV
         Q58TwPNjuUPlYY6MTtLcmUHQzq7NUOtKRyFnn1krRccVt//C6oa2J/1E1KZDFcznyA7F
         VIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L+xq6Z+tkIdZzHSipzjMp2q/qYAWcGMx2g5Cxu1SKSU=;
        b=gdU5oSColrjl1AN1NbN4VqWCw2oxSIdz9/jmgBicAiPDV1MQXWzjbAxDPsQ0MKI11k
         /oDtuMWG1yY9rNqnTioeuM26GEIoAcJxMCa//PPE9tmXtx4eVVbg97sku2QukoFWiowf
         AZxUrrjbbuk/Epv6cWC4Z68Ys4/q6fdMFdJHR15+O8VYDncrZqI8rT6hCCfTu4MBLPw/
         kWExkVgs4bzb8nWYQb0uWEOJc1u7zvm8MXilIZGlyGI/A0fIpTVJHlNJKyZCaV76HIIP
         s3C3GdZL5gSN7ohvxXq/K6eA7MxpCC8I8SSpsJ/sRly8HaI1KthUbsSP+1eMn2sUu9eh
         a8IQ==
X-Gm-Message-State: AHPjjUjTnHU4Hv4DloWxFMFJO5SkhfdmpBLGxAfUbExXnY52BdBePeD1
        8PWKfTs+EOvPyeCrZN6sdtkmvV5Ya6g=
X-Google-Smtp-Source: AOwi7QBbKsXOR+5InCbysi2CP8C2GvZqesaabm8HlChDDwHD07Vxi6hiTxW4HdnD+TgwF59j+XqAvw==
X-Received: by 10.101.82.203 with SMTP id z11mr8411717pgp.387.1506874742239;
        Sun, 01 Oct 2017 09:19:02 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id m1sm5784820pfh.13.2017.10.01.09.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:19:01 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 4/6] doc: use modern "`"-style code fencing
Date:   Sun,  1 Oct 2017 09:18:50 -0700
Message-Id: <20171001161852.84571-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001161852.84571-1-me@ttaylorr.com>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"'"- (single-quote) styled code fencing is no longer considered modern
within the "Documentation/" subtree.

In preparation for adding additional information to this section of
git-for-each-ref(1)'s documentation, update old-style code fencing to
use "`"-style fencing instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 323ce07de..1279b9733 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -213,12 +213,12 @@ and `date` to extract the named component.
 The complete message in a commit and tag object is `contents`.
 Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
-line is 'contents:body', where body is all of the lines after the first
+line is `contents:body`, where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'trailers' (or by using the historical alias
-'contents:trailers').
+are obtained as `trailers` (or by using the historical alias
+`contents:trailers`).
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

