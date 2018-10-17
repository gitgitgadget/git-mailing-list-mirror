Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D121B1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJQU4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:56:12 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:38553 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJQU4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:56:11 -0400
Received: by mail-pg1-f171.google.com with SMTP id f8-v6so12510848pgq.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=URDLp/vNf0fxCZhrrG7SptIxF6iKeIe78OjoAVxM/OI=;
        b=VRzEHujDzpqbPZJJqy4Qh8lQ8acWxCoYDxqpPHeYUlO7n07euHze3ZI8GaX7g3ZeZA
         YiKmC1FqESPZOa7E5Kdg2encM5c9t7mjRY/432nBKwAW6eMbGXtXtPXlKb4sr8u14deH
         chfy/D/D33Z/M1zFnIRgoeY2/qRORG11Lnr2YXqhpwNlcdQnzTjtQtfglD5tDEY7y/uO
         TPjITluTX8YmGHHapxvTYWx/JOrk6MiL8BKUwbnWwUaMBBnjxMSs5WmaA2ufB0Ae0L/9
         UrffIQrEs4jWgiUf9c3o5Izn794Uy77/WyqfJeaOxPwQJfxjq6mDJZY6Yvu/qLTHlEjn
         QZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=URDLp/vNf0fxCZhrrG7SptIxF6iKeIe78OjoAVxM/OI=;
        b=KvjHHeP+DAzbk/0K9DNxCDXFfdf8qvpLJ5jA3qIN0nufmo5VPOSmaripbT1z4qHeMO
         VfSalYSYLE1QxC/Pd6lYkl+7CrzSso4wJlcpXbexfpZ4jO5Prc0HVW1O2UdYGDN4Z3fh
         NiWx5qZ+sRoN2XW+3C10PatCrH2A6UJNH21LuzPNUreNfzRwxrSvYeu8S9P/WOPkC834
         32gkF47uCmqwn5tOKsgFQlSFGrfnkc3xK5Kv875gAbs4g6HN7065NWeSSIYfxvsov88o
         HbD5eZMRLUUww6zW2HhVK92GY5gaOfMugjLFG/zVohYKG3+IdI3JXPJtNUQVmZIJdP2y
         AOXQ==
X-Gm-Message-State: ABuFfoj84r2j13qBU8Ar9vOBxa4gP5+fwD9arATnxItWULNuQ/HtF6O/
        C2yPiuMj+4CCal3TgPfyAeC7ulTq
X-Google-Smtp-Source: ACcGV61lGNkA9MwmFFkenK7rZfkLlTqUzNDJk7d28Eh/bOG2kObWvlNgbmuBktJsfTnUnH+yTUiM2Q==
X-Received: by 2002:a63:6746:: with SMTP id b67-v6mr24553584pgc.310.1539781234886;
        Wed, 17 Oct 2018 06:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id r1-v6sm32115490pgo.81.2018.10.17.06.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:00:34 -0700 (PDT)
Date:   Wed, 17 Oct 2018 06:00:34 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 13:00:30 GMT
Message-Id: <9363be0b9d6d06ec14cdcda37ca4dab72e69e3bb.1539781230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.49.git.gitgitgadget@gmail.com>
References: <pull.49.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] ci: add optional test variables
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

The commit-graph and multi-pack-index features introduce optional
data structures that are not required for normal Git operations.
It is important to run the normal test suite without them enabled,
but it is helpful to also run the test suite using them.

Our continuous integration scripts include a second test stage that
runs with optional GIT_TEST_* variables enabled. Add the following
two variables to that stage:

  GIT_TEST_COMMIT_GRAPH
  GIT_TEST_MULTI_PACK_INDEX

This will slow down the operation, as we build a commit-graph file
after every 'git commit' operation and build a multi-pack-index
during every 'git repack' operation. However, it is important that
future changes are compatible with these features.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ci/run-build-and-tests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index e28ac2fb9a..db342bb6a8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -15,6 +15,8 @@ then
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
+	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_MULTI_PACK_INDEX=1
 	make --quiet test
 fi
 
-- 
gitgitgadget
