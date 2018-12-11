Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF59C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLKUft (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 15:35:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35298 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKUft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 15:35:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so7187628pgs.2
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XOhtDN+4VhJqHAmRUzEfcJZ01qJbCNu/bPF03uC8Vd0=;
        b=KD5tWaKQ9Cp32vtewBxjrgX3vBn4glZUa7dUUmxsCJcAGx9QNEH2OV+Y90gAt2Ey/6
         cMgI9t8hDcTi4zKUDLdSGvKgMuegKwteVurvdClHdRL0PdpQWvZrjHHfapouvMK97tZ4
         RUWZ9EvDokmFjFloKSVxgr2EsriTU0la+a1hMgTOs4vuIG75aWQQvKOh+oOxulw6L5UO
         eYOOn418hZ3fedftUopJMj/fn60FR4oXL5P/9nlX6XLBr0OttA8YOsd5m4Cc8dRxBJcv
         IMZfpTOabAudYCW0aB1l77rdcjbkJ68HBggoLuX5AcXaalX2WKQD4WTjxO9rfFi+1Zbq
         UT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XOhtDN+4VhJqHAmRUzEfcJZ01qJbCNu/bPF03uC8Vd0=;
        b=Jc2fBinF8hnHiBuDJ1GuJ1GrywLfI8/uQW/ebtUYyqVMjUhGGSXekERXg7vYyFeFO+
         mRAcjaqxZzAHgx4+y937rGRgOOoLNg1vx2ScihcS9VBpv10V8ed6Ritz93snHX8HeCEZ
         YY9LZTWVi3sxkV19l7K8dVDZvSeQblzVcbhhQMSdoEXAV/u5tzDdWmYTaHbZdEOuzkoh
         71FfBAiBnFkO1K7ETIg3KIrIFfvCBdXVIEgGA5+7DxmDEBxNVNVauUn771USnaYGfQ0+
         kDYZmUsS7wqsYI4WAj7aOyZvrVSdUh4SQTKXxoIDreP3FZW8RQrsy7xg9+e2Eh9KyLMl
         ihWg==
X-Gm-Message-State: AA+aEWbjaWhAe00FGrw3f9ymZZqJNjBWCJW0hXjIYAZXWODbfoUseBxa
        l4aBe9RCTfIkUeUsZGz6x5twkpvj
X-Google-Smtp-Source: AFSGD/UP+O9UiBOaL33VaiMc7gDVmzdUWfiXLJfAJmlNE+6DAom1PYaeH+s+iUCYY4Z270KAkEm+Hw==
X-Received: by 2002:a63:1258:: with SMTP id 24mr3906674pgs.114.1544560547463;
        Tue, 11 Dec 2018 12:35:47 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id h8sm21346060pfo.162.2018.12.11.12.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:35:46 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:35:46 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 20:35:43 GMT
Message-Id: <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.98.git.gitgitgadget@gmail.com>
References: <pull.98.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] .gitattributes: ensure t/oid-info/* has eol=lf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The new test_oid machinery in the test library requires reading
some information from t/oid-info/hash-info and t/oid-info/oid.
The shell logic that reads from these files is sensitive to CRLF
line endings, causing a problem when the test suite is run on a
Windows machine that converts LF to CRLF.

Exclude the files in this folder from this conversion.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index acf853e029..3738cea7eb 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -13,3 +13,4 @@
 /Documentation/gitk.txt conflict-marker-size=32
 /Documentation/user-manual.txt conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
+/t/oid-info/* eol=lf
-- 
gitgitgadget
