Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB081F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbeLUQ2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41332 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbeLUQ2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so5131246edy.8
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=DWCSuqctHToV04TG5TZI7zTHdWUEcpArSKMYzTENnybmZEtRhEsClHtl7bK5cshCkf
         wuRwg9DlDz21bNj6ZkcfpZnyzhS9I68+6p3+Dnr4lW/ZPM1ELSY6bcg+WjdWWh/xf55B
         5zCrZOlA4nCBn1yf82yxld8N52dJpcITQBk3eMg82U3CHVTpj7QSe8XDpcPD9o/NxTa6
         s/nFD6GAP+4Y79eLjjfDVxsKROw6yNgKR18zJdeNZbuUPCRhG0VHFZzT8fjIFFdjkQM3
         VnmG7cAXk4elfpvE3ppltmUIa4KsZ+eoV8raTq0Ao0a7c1LZIytUh4LXRzZr5N0OOPFL
         bmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=BrFOlSGZIXevNuOkbdEmojTzw+gjJE6xa5mlVtBr2+66mWigwy/oeDB9B+75yiZTbD
         Xy3sr8Yl11BqcM89xowAqgZrpptQvDRZMb1AU59z3tRDZXmE3xyurcIv+WDOex5CWIZK
         X+caG93c8t2VBvvZDqPHs+6wSZJjvk9ET2WArRuLySxfiLppqBW/HxI1ebqm/KB7lPKV
         TgR16OmfteiVjxNcKy7moU9u9TSwDg4Q1GPzs90/Yigi/bpvpgYj4Lg/14gkZm3r7L68
         1ejL+IMnixmrVKUSQR9Spg3VSHpi3JNrrGxTt0z5nDbYPYs2zDDB96NH+Fakw/V1y6KI
         CWgg==
X-Gm-Message-State: AA+aEWazxXPJNP+iouQoPhZtxnsCgFSfEROf6H9MontKGaCneSYTfqIT
        Sze37ieMYBW+xLfpXN2W+6yZAroEr0kT4g==
X-Google-Smtp-Source: AFSGD/Xj+DNXXdoZCvq2rxpYkM2PHcqGRf9TI3ZGCKNcjWSwkEmU73KkMVpGxuVQ0m/tomC+Awfxkw==
X-Received: by 2002:a50:9feb:: with SMTP id c98mr2860270edf.253.1545409719270;
        Fri, 21 Dec 2018 08:28:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c30sm7006609edc.70.2018.12.21.08.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:38 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:38 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:31 GMT
Message-Id: <55df6b20ffdad67f9cb8020f264c1420d381bb9a.1545409716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
        <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/7] Docs: rearrange subcommands for multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will add new subcommands to the multi-pack-index, and that will
make the documentation a bit messier. Clean up the 'verb'
descriptions by renaming the concept to 'subcommand' and removing
the reference to the object directory.

Helped-by: Stefan Beller <sbeller@google.com>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index f7778a2c85..1af406aca2 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] <verb>
+'git multi-pack-index' [--object-dir=<dir>] <subcommand>
 
 DESCRIPTION
 -----------
@@ -23,13 +23,13 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+The following subcommands are available:
+
 write::
-	When given as the verb, write a new MIDX file to
-	`<dir>/packs/multi-pack-index`.
+	Write a new MIDX file.
 
 verify::
-	When given as the verb, verify the contents of the MIDX file
-	at `<dir>/packs/multi-pack-index`.
+	Verify the contents of the MIDX file.
 
 
 EXAMPLES
-- 
gitgitgadget

