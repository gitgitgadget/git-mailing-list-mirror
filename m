Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D808C20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdJBAdU (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:20 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:45314 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdJBAdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:16 -0400
Received: by mail-pf0-f170.google.com with SMTP id z84so2140241pfi.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEvZjNCvS3UQzCOJdkC8R3DQVzOPFIBa4qYJqHIyhso=;
        b=H31WvqvQTrwVuueQiQXan7q3ZFLfd7PxtmfvDkogbNsmlk6aieXWU2ZO9DskfSPmA1
         mX9q0c5jn7zIa+TIlwL0+qTrzA8581Wbsa8lG7O0yYLU84FkJVujhZge2nrMBtWBSLsk
         xk3A1lrgJ1Rl/OtQLqQ/xsDAxQCtx7lMPF1TB5dxt1pn/ioBTLVnRZFXB1lp5xl/LXl6
         JCa0LKqDpmgBPz/AEiB/7yU6zO9TNf9aXDsW86HSFv+d/c9I9c0vOCpszkn1aCI0v/5R
         MTRqJrMp0jP2WyM3tNILVt5Sl/1o8f6vIj6TovOYhTP2SjQWgMAq4TDBwW1IqT88hrvC
         gHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEvZjNCvS3UQzCOJdkC8R3DQVzOPFIBa4qYJqHIyhso=;
        b=Cdx0JAVjuJobx4r1wTjTymmreBgpk4ApE2q2xnAFWduoFm/PHoBsADgS6sWTFu4uUI
         u7UfqSQuNjRMwYA0W8nbV8kzHFwvAwMoH5//n97t0Xg47NO6gFc+O0FO6kwtFLiaj8iY
         q9lVjkMEzKEeZx6/WMQxEEujhNPfGUmDd8KWLtXXTx1B0XHVARzR4uQmcvsRyxfoaNle
         LEHd5aFiEHP8qudlfFn8dl7XxutQt21nPZtaECa9pH0/jd0ylOxDiYi1mqEiiQUfTXiC
         MDdIgG+N6bI8VsgubPIPnKHJGscOlUwlnma5uvFjiHedzARUpk+9/kwnq9azqBjtWPi8
         PT/g==
X-Gm-Message-State: AHPjjUgfvtD8fpP+wQfeKpXvRmVCKXCJDwIst8fqdcD+lwT7M7M5Z3+r
        18ItUy2m9FQli1sWkeOzh1jGPZE4UAs=
X-Google-Smtp-Source: AOwi7QDU6BcNihdClQc60mfkiUN8QEhPoLVHfPGF+6It+d3A1pwlEk+eq6/MmGTBvGQ4xMUkwvZ4WA==
X-Received: by 10.98.49.67 with SMTP id x64mr13472560pfx.11.1506904395576;
        Sun, 01 Oct 2017 17:33:15 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id e3sm16220134pga.80.2017.10.01.17.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:14 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 4/6] doc: use modern "`"-style code quoting
Date:   Sun,  1 Oct 2017 17:33:02 -0700
Message-Id: <20171002003304.77514-4-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003304.77514-1-me@ttaylorr.com>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"'"- (single-quote) styled code quoting is no longer considered modern
within the "Documentation/" subtree.

In preparation for adding additional information to this section of
git-for-each-ref(1)'s documentation, update old-style code quoting to
use "`"-style quoting instead.

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

