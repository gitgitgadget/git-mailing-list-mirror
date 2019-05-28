Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8751F462
	for <e@80x24.org>; Tue, 28 May 2019 12:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfE1MmT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:42:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33286 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfE1MmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:42:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so31625483edb.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HMQgZHfq9JEs+fc8qhzqeYNjLDHwafxvbtinbB89+p8=;
        b=ZwkADRHUjtu/ptEf43tYVzJwl13lLkD3P5ExsJuIxHAYkkBU9plA5YVyhvy6z7HT1/
         gtEThbiti3zJEmZSL285ZkDdJAhYzAMR/NkTSpzcsw7HYlwbL+Vza58hLBoydLugn1LJ
         PKe6O2RSVhktiieVpvb0wtSulDMu5RA0TSDQ2fSMWi6X/dpGy8hLjiMEKZyPPeSm56Qd
         rpllczhEa4Hrsr470cP/7/1jCXKwEaTn55DWUr6FCEKbHpt5S8WV7NwfRtzA616OOQ73
         8/FLYyvmUFWjoxgurtylegEHm9WNNhz8SXWxU22vAK1yDdhugavKskYwDcbmmtJed8lM
         VE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HMQgZHfq9JEs+fc8qhzqeYNjLDHwafxvbtinbB89+p8=;
        b=irZOTpFewYCtIf6vsBLSmgG5WAevdISftDSqjDURNmEcFYXeYI5IyuPVwLd7CAquvx
         d1kDPIQfdGDe+RWBlpHr79ij1rDIZ2xTfZlvMzkQNCNOjojkWhMsoeArVPbJuQRpVl2t
         XynVyaKuhs5LDCPRKOOwias5AN85ez/ozhK1q98ucRPR5O2szsaExk362XgJ0c51sLIm
         N55dPjko0ddGHHPTioL+vlW8MLCOVrSI4DSNrPZ2I1Mhqp+rI6uBaIA38n1YxFTdgZci
         7l33Qz13Gz/ugPjD6iYdq4Bb1k45YJS2PUIyDuhgPQVDpu3COqU9LVItA/Puu2AX7RRO
         x66g==
X-Gm-Message-State: APjAAAWBVMYMRN29voJqQPa8cJaHWcYEsxeuiT8vHI3itv3b31q30nRR
        Gyl5S5GeFjk3/y8rOZozVGOGZ4G1ACQ=
X-Google-Smtp-Source: APXvYqwk8mUdKPLoXREl7s1yGNZXWE+d8gDKq/cFev/Cu7nXh0uQxhW9RLhiPyDhYWs0sQrmIQPCkA==
X-Received: by 2002:a17:906:d557:: with SMTP id gk23mr19706824ejb.285.1559047336075;
        Tue, 28 May 2019 05:42:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e33sm4227515edd.53.2019.05.28.05.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:42:15 -0700 (PDT)
Date:   Tue, 28 May 2019 05:42:15 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 12:42:12 GMT
Message-Id: <09cdff86fb42ee0dbc6ce6a1e276a17811a72021.1559047333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.227.git.gitgitgadget@gmail.com>
References: <pull.227.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] docs: say that `--rebase=preserve` is deprecated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of Git v2.22.0, the `--preserve-merges` backend of `git rebase` will
be officially deprecated in favor of the `--rebase-merges` backend.
Consequently, `git pull --rebase=preserve` will also be deprected. State
this explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-pull.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 118d9d86f7..a5e9501a0a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -112,8 +112,9 @@ When set to `merges`, rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When set to preserve, rebase with the `--preserve-merges` option passed
-to `git rebase` so that locally created merge commits will not be flattened.
+When set to `preserve` (deprecated in favor of `merges`), rebase with the
+`--preserve-merges` option passed to `git rebase` so that locally created
+merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
-- 
gitgitgadget

