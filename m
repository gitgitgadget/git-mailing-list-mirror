Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D561C1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeG3RSd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47014 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeG3RSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so7456030pgv.13
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZdGlRTIF/tEl6bFcfsOFLA7EHnv1sdO4j4SRHze+fts=;
        b=hmwUR4CbSQLWz2rAHqC6FMTUmryi8PjoFy1nQc60hTH9/Sfkfr2Nt4pzAjCtHNTPK7
         kNpH5qAcRCibCv7dyNNY370Xnc0pOGTO2gga2D9WBwPTCnHKfjiSmcESAQsakAAUnK2I
         o/tQM5n6VgTL2QAEMSrR8Wmubb/oD8K3ZpvGbo9eqccEuGYir77ScBSyLKrQGRiie0DP
         ol4AE58IEflllMhDohiCJaFdMvv8s8vkBvKhcBKYYGIoBmg6TfsnRVIo6dm6ozYUhy0X
         TROT7qSZcPpdzoreclKUW2ZX5E5K9ExO/My3AK2ipy4Datv2xzFph7KdJUIKkV3Zff7w
         9HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZdGlRTIF/tEl6bFcfsOFLA7EHnv1sdO4j4SRHze+fts=;
        b=IKzbZ4HfxNdPuNjDEaar9g1yO7K96qLOEy7qZxyxqmENaIlNxPn2C4IJlWSa6BX4qY
         BzQD/2qe67Dxcjd9YA3Topqa7/Li2TMF4FN9hjDfIMJwcZ95y30hv4BRalpcjHMwFEGO
         ONwyK/YtTiA2PQmRmJi7w+rLjW4Kzk/iPgLmBBPh9rBRCx/ULbEmDm5S2VUUhPkmLWt6
         fDL659xWqbKG3gfhK17z3ZKvHHfgMXuZv2t9jPJSGucSrneWkc3DSa4ToA8T7tsXO3f4
         WMyuoiCObDp9i1GNeQ1LNIFD6DV3QIjJjtuCsaxi/ojTA5NnuPRjifPaIOXIM5XkO9MG
         dLmA==
X-Gm-Message-State: AOUpUlGdMFl5j6NUZARwZSM1phzjVa63+/kSvt2KQC3dPhgqwoix8tBH
        BnCDlQCSWuTZYKiDkqFGXtrPdG/w
X-Google-Smtp-Source: AAOMgpcgvHWn0A/5mx/nZNb8B5pxI/Au4iqmGxGeOGYF00ag4i4qyVgVNABUOZvyiI1HOd4iEpQxPQ==
X-Received: by 2002:a65:49c7:: with SMTP id t7-v6mr17057107pgs.23.1532965379462;
        Mon, 30 Jul 2018 08:42:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id m26-v6sm29654903pfi.102.2018.07.30.08.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:58 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:58 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:42 GMT
Message-Id: <b9c628b8812abb265c4f48f846dc3d3e170649e6.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 9/9] vscode: let cSpell work on commit messages, too
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

By default, the cSpell extension ignores all files under .git/. That
includes, unfortunately, COMMIT_EDITMSG, i.e. commit messages. However,
spell checking is *quite* useful when writing commit messages... And
since the user hardly ever opens any file inside .git (apart from commit
messages, the config, and sometimes interactive rebase's todo lists),
there is really not much harm in *not* ignoring .git/.

The default also ignores `node_modules/`, but that does not apply to
Git, so let's skip ignoring that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index a134cb4c5..27de94994 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -33,6 +33,8 @@ cat >.vscode/settings.json.new <<\EOF ||
         "*.h": "c",
         "*.c": "c"
     },
+    "cSpell.ignorePaths": [
+    ],
     "cSpell.words": [
         "DATAW",
         "DBCACHED",
-- 
gitgitgadget
