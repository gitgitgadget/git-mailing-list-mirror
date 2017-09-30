Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9B82047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdI3Sqr (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:47 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:44161 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdI3Sqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:45 -0400
Received: by mail-pf0-f172.google.com with SMTP id t62so28215pfd.1
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feqgBOvacodni8MQmilXbw1vcHCo3kPKTgfQaxdk5fM=;
        b=oN5bopqxsAo8f3wkHFXOoM2NTGhZ8u5kr7mnOOGBcj4eWw0ofzQT/BWgtKWmc3+mrW
         FUUxGJiYOluh/XzVygHWEbCinNvREybjnD89OOaCp8LCwFMaTqEBBTLsTQePeDIet9BE
         ujnEJHQ90xAduavjaHMpOwgC6bK+eh2i9yXaAv76bL1DeejeiYDB82uWODf0I6D3a1iv
         kljzY9xrdqZrUq7zpYzcuX66bc8OwjhPLRLagdEQy5+s3D0Y8Oebhhue2NTgiola5de7
         klgO/W5tuTQI4z6ozjksA1bzRL6nfFYIM39PaLw/0xgi8+5yfNY6YtVEuArinqGq4yev
         JO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feqgBOvacodni8MQmilXbw1vcHCo3kPKTgfQaxdk5fM=;
        b=cWfr/7auuaNzFZ7jsqIhhI0zKAhwTPZ0IdVjv7LylL2CrtAqjD5zXsSfF8cL88oPP9
         gYDsoTStmAx0QiST1irdj1Z71w/mG+yOAzJNEInTr8VvvigFY4R9Xt4r2YMmk3irYI4W
         VLf4fBXKMNe37DxbvmxJJI7jW2LMQva9bvy7+JikrvteWAb9ZVTK75zCiw/JdMGzMIR4
         mtkNmlNKzIt67tIPeTmtiKPIWtNa04tQHplHoiDQbxQ42J7SB8NKGZqZ/DFeO4sBnbdM
         zS9RLIV6fRLddIRXleyWGPvs4iMbTyJXi++xIpaZbuu9zAsYJHMYugXU3UVWlfQGfumY
         RE2w==
X-Gm-Message-State: AHPjjUiHHFfByMl0cqt+9t5S02nJpZhMlmsdXepjvHB4tkcVyN3iOEoW
        pq8b8SM/4lbid6zg9vskIDYBDdoRmiM=
X-Google-Smtp-Source: AOwi7QA9p+FRzGdH4UDc8iw8606pNJiCQFWiXKnWarYkrKBK+nizbI2G7riggQLhncZsA42/HylVvw==
X-Received: by 10.98.158.139 with SMTP id f11mr11006947pfk.46.1506797204555;
        Sat, 30 Sep 2017 11:46:44 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id y83sm11986701pff.167.2017.09.30.11.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:43 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/6] doc: use modern "`"-style code fencing
Date:   Sat, 30 Sep 2017 11:46:27 -0700
Message-Id: <20170930184629.75900-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184629.75900-1-me@ttaylorr.com>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20170930184629.75900-1-me@ttaylorr.com>
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

