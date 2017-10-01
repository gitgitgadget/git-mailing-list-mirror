Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8814A20A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 00:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdJAAKx (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 20:10:53 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:49087 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdJAAKv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 20:10:51 -0400
Received: by mail-pf0-f177.google.com with SMTP id n24so1378350pfk.5
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feqgBOvacodni8MQmilXbw1vcHCo3kPKTgfQaxdk5fM=;
        b=OebUOhJooUm2zzoU6vOryY/Yn/S3/i33Yi+c/r5C/cF3ACYa+tRY4X8Ha2Zv/C/K/5
         cZCQbC7iciU3FdNYfMllKtN5GuKizQ0iqETJ6/RTkFdP8PtdSGfxfC3axcOwcszDXLhL
         tnItyfd3ytkCQ8oLC+AC26KWi1Tz+2UazNZzxTc2wsJMZg3ShQJk4nza6ZFgOmMcJGgV
         ist/ONjP/BMQa/nORWP/PipzJW6D2eh+IveMJgRnEscFIWNoGMteHB6rmpTPkEIrMuJG
         42eOoJ1xDJn8CHaI8t5io+VmR0aH1/x0MAQwiPnvi4CKO2Qttp3kikvYzGj+hc+bn6ke
         60Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feqgBOvacodni8MQmilXbw1vcHCo3kPKTgfQaxdk5fM=;
        b=b/g/zksrzQPmsT/WLoyoHLE7wtS3WLJNjtFreUV5V1pPOwjf6FFCgRxWWX1c5EISfc
         4cR/ZCIuQQ7grluHdpm4C8vp9tCE+6KzN92sxhys/l1K8+RwIX7s/574fZVm3tYLnywj
         1u6w6s8NZhRCnZhmAhJS6q1aMJIkgHO6odCT3vjw3gtXluPxGj4BQP4s3AbYM2u3RYPp
         Hj8Eca8S1MFGnN7F3uTkjx4K7H2mLHUGgx+vn9NZd0YKPEIrWJk0yVqq3LKOfMavpEGC
         g5m7EI0V2GD0HwYSSSHdwD5Mrr02xS1GvqBN0IhpL0ZmvkgAuL9n26YkSXxrzBe8o8CZ
         v6tQ==
X-Gm-Message-State: AMCzsaXMXBiJ0jykW1j7gha4hUf2bYKntp2F5C0LVbal0s6Gh2wtJqTN
        PqJaR2QUWNBbZEROsUypU7O1c/4KciI=
X-Google-Smtp-Source: AOwi7QCMVKkA6n8GOOrA42zD0Bwwf1i3nzvZyyIS8lTCqp2QzinCqwwfBg6HRpYhDc3AGmXUhYN6ew==
X-Received: by 10.84.213.16 with SMTP id f16mr5957322pli.262.1506816650573;
        Sat, 30 Sep 2017 17:10:50 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id o17sm10926378pfa.22.2017.09.30.17.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 17:10:49 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 4/6] doc: use modern "`"-style code fencing
Date:   Sat, 30 Sep 2017 17:10:35 -0700
Message-Id: <20171001001037.23361-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171001001037.23361-1-me@ttaylorr.com>
References: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
 <20171001001037.23361-1-me@ttaylorr.com>
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
index 6b38d9a22..b6492820b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -209,12 +209,12 @@ and `date` to extract the named component.
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

