Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B11F1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEANLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:11:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42135 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfEANLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:11:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so14881581eda.9
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hrhOWgQJcuMFvddKCD1mkss829rkYgbz1EvpajHm/HM=;
        b=f9YQ2qY2NKugZtTW/hsYBr5CBHnZwFDtPMe4N+WSo6/hbWf3kvJVyJG66QmXFG42TZ
         buO/5r+TDIC5mIzLKagw57mOhQYGvOyHl9IrXgXySZCCEsIAGVEpPAwfx6EHWvqp3Prn
         k4HdaTK6C/RsbSTY5I66scLIGT4UPmTtt86jy09kxRwgsmAJxLBwnu4msZSrQDsoMM5J
         cUltk1HrNoYQZZ63VD3V65G4/cPLBhSOER0hAS3kVWd/XWJrv9U5t1/qDZgM9svUxW8m
         tPqlCUCKk7Ax7hkXVavirBLZWNlXwrVPKm19ZowdPS5nm8R8GhcAqMkXqw5PCCay8PdM
         Vxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hrhOWgQJcuMFvddKCD1mkss829rkYgbz1EvpajHm/HM=;
        b=L/DqIBEoa0RTN1eu7ZqISWIjfiTb0GsVIXwe9/lTGk3JygfSJEIh53gemvdtVFaCQX
         jfSvXjUwz32tGtxFppenLXXxfD7mpgQBlIVMquLGKc8vctpbdobQBxiuBq+XmU1UedQb
         YHcS+gUi1dBKAoBo+zSG6wGBeiOuka3rHFZdRzP8/WJ4UjQ4BUteFojF9JQ6GfvCiKJP
         lnmDZcdTKHqZHnxODt26ju+DhtxOx/JpoZnP4BzcZ70FQ7lxZ539AeCEsuLofK6kATFL
         YwupwGgg2eUVqWOF1AORh3e7fTxVMFOvGJTA/zT6OtiZ7dT11MUFAY6jvvfGmS0MsUGq
         moEw==
X-Gm-Message-State: APjAAAUpOhh4OhzoG0hndMFE079nhZDmvnHuPigrElqZEF7fyXi89PZ7
        nml8ubp32ok2qOk5VA3C4YTPdbMg
X-Google-Smtp-Source: APXvYqwrhdgx9UDRHycO4sPp5w0muH9BAwufGaMqgYuEAqdEu8crt8qd0VdJTWv/Xc7m9PJ/wvyhiw==
X-Received: by 2002:a17:906:685:: with SMTP id u5mr957899ejb.125.1556716279648;
        Wed, 01 May 2019 06:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w54sm985212edw.40.2019.05.01.06.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:19 -0700 (PDT)
Date:   Wed, 01 May 2019 06:11:19 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 13:11:12 GMT
Message-Id: <e72bca6c784c5fc727ae4cf661526eec346c478c.1556716273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v3.git.gitgitgadget@gmail.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
        <pull.112.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/6] commit-graph: remove Future Work section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature began with a long list of planned
benefits, most of which are now complete. The future work
section has only a few items left.

As for making more algorithms aware of generation numbers,
some are only waiting for generation number v2 to ensure the
performance matches the existing behavior using commit date.

It is unlikely that we will ever send a commit-graph file
as part of the protocol, since we would need to verify the
data, and that is as expensive as writing a commit-graph from
scratch. If we want to start trusting remote content, then
that item can be investigated again.

While there is more work to be done on the feature, having
a section of the docs devoted to a TODO list is wasteful and
hard to keep up-to-date.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 7805b0968c..fb53341d5e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,23 +127,6 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Future Work
------------
-
-- After computing and storing generation numbers, we must make graph
-  walks aware of generation numbers to gain the performance benefits they
-  enable. This will mostly be accomplished by swapping a commit-date-ordered
-  priority queue with one ordered by generation number. The following
-  operations are important candidates:
-
-    - 'log --topo-order'
-    - 'tag --merged'
-
-- A server could provide a commit-graph file as part of the network protocol
-  to avoid extra calculations by clients. This feature is only of benefit if
-  the user is willing to trust the file, because verifying the file is correct
-  is as hard as computing it from scratch.
-
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget
