Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C0C1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfAIPV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33532 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbfAIPVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so11165290wmh.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=qWFy0vY4utx8kMpfqpRQHs8EE9o2DzNKnjaYNMI7koqSNT6doJyrhAn0Iv1YlZK3qZ
         m2A4SgyqREVRLBNWSYxVr5t55V52PTSfKAjm6DHQ0rVtfhVaKZp+GubxM83puKtI3/sN
         7UpJJ5rkb1gqnJHfOsf2qCNLgvCGmXwazWO1kDWGQbyuBkNesANfNWHT6l1QNQC1H21r
         FOv/o8oWKXo/KPSKfLhcQ0p93HASRCvIt6I1JHjqRc0wVg6wMWASyTmCgiuXm37wjlof
         NndLg1TWVqEck0AjQEydyTSXMfTnm+2FQXq3gGjcd2sEAmYJEH21v3JhjA4feCAYwLpC
         6YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=KFvWs3MtFPh9f4rs4LNngKoc4vcN++p1+neR0WjImg8=;
        b=r/ejfVJhIQbKdK2g5oIPaeIvOBdYWlUNXuI0/yDad1E/ihwsM4eD5Ecxq7IM24NWz5
         Id7azFrQnxvt7QBDXL7PyG7xvyqFzs6oVpACK2ir6i7Wkx8xy1sW3PsPZ/L6qbuiCv+7
         P4wHPaxw9TZZj9mclsKsR6C9RCH921zbPN5ywT6g5lDglOcUwk/Xmk4Cy9VOU9hCwSSW
         rLQBhuqZfFmIMFUdRZwQC8ll/EuMGTvoOUErCRxG+pfjsxMpzNpoyOdKiqGWMHSIoBf6
         Kf1qUZ3qh2W+bnBQXhbZYyNcLn0jXTVQ3ujaDtbnhZ/4xWtyCx5KOg98U7ZixjDwdUIh
         GUqA==
X-Gm-Message-State: AJcUukc+FtLAq6LM9wUfW8FgXBtXJin6SkDXPGW2WbRKif9ro+1x49wc
        C/gXC8VH1c8xGsNwsjXMOt0TkfO9
X-Google-Smtp-Source: ALg8bN6xHMO8CHuSkWw1saeSLxxnrGHO/i0LHJgsunSylk6zXF2RDzAatww452h1mnjkBN98HJfT4w==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr6076743wmg.73.1547047273788;
        Wed, 09 Jan 2019 07:21:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm19815685wmm.26.2019.01.09.07.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:13 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:13 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:02 GMT
Message-Id: <78867859042eea6318da65e236f903d6102ed93b.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/9] Docs: rearrange subcommands for multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

