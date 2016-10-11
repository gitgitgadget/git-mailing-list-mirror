Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF5B20989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbcJKAVe (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:34 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35850 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbcJKAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:32 -0400
Received: by mail-pa0-f43.google.com with SMTP id ry6so3885156pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iB3jPxU/daqlj5fDykNFaagcnttajX2400aSm6Lfjuw=;
        b=Uz5dDDL3ae64oOb34Vrt46XQx2sInc0F2nBmtttYuJr4NBEpCq5EMQXnE7B7z365Km
         smz6gvnsQTXE+Y2TLNg81cCoHrzDjmpBrElRbFgTRSFlpUngS7M5503I0ZeHajqhBMKu
         VbwAgRbrlTlKO2DJVSJcbPMjWSbHpajOTdEAhUIPulwWjz8Qt59MZy6J6uVo2a1w1trc
         KcYUhwY1JJwBsUscAJabp4B6IW4kj2wD9ILNMvlKt45TeLd9KsII1cSHkqpX/0y+OZX8
         5aNbXopLoFJ5DwEmiZS9GhReNgrolApqhtqjfudhmuZq30JE4G9OHyZ17eamV/nn8Alu
         jOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iB3jPxU/daqlj5fDykNFaagcnttajX2400aSm6Lfjuw=;
        b=D6hOvgJlBbKhYJNBtIxwcygAaHHs5rwH3INLMgBsx4dS3Wyz2LxgHzpnJr7bm6GOow
         rtr9xROIo3mrTTZO6Rq7RUQSRPcgnYGomlpJebjzSP0uPN/i4/ayd3aDZQrB5InoRnWV
         f5UJCqrJtx0rHxcHE1be7wsCw+46KVPekuAgb5JApGapIvfE5WZTpaj6pNOaoi8j5h5J
         wZLSpvjToFOulq2k1tSvqDBrEeGlu721ibYWM1aGDsMmedV+uBwRSe6B3BoJHRetxFnS
         JPjoXdGYTDSg3Da2evtEuSnWWcEWAXvwXeMS6vY8lNE2kisqZ5m1e2AGsKr7+raJNCcM
         bOLA==
X-Gm-Message-State: AA6/9Rk7fkz73dQGTVwMHZvKLSjvqnsk59xiDHoJHcnJI7eZHs6vODfuqRciC0nkY441kUMD
X-Received: by 10.66.163.132 with SMTP id yi4mr1720693pab.162.1476145291363;
        Mon, 10 Oct 2016 17:21:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id f1sm527239pff.34.2016.10.10.17.21.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/28] attr.c: complete a sentence in a comment
Date:   Mon, 10 Oct 2016 17:20:52 -0700
Message-Id: <20161011002115.23312-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 05db667..a7f2c3f 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
- * .gitignore
+ * .gitignore file and info/excludes file as a fallback.
  */
 
 static struct attr_stack {
-- 
2.10.1.382.ga23ca1b.dirty

