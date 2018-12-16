Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B555F1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbeLPV6J (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:58:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42276 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbeLPV6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:58:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so5142877plp.9
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sC/aVNas3nwvZybOCDxxqpd01x5ZzosIW3uKnf2wrXY=;
        b=DqO2nRSr6y2dKw6eY1JIi9SxXncTz5raS2pmStNTZ00kASWKGVMqg3MDsSTc7Ri/zl
         XoiQVMYUqiJ/SbNoG24U0CRLDKki4Pd0suhh2X3uQDXqyCJizVU+AWXQZDvEQD1q1Bpn
         EWO2GyCCdOmbrYpYeVsPg1xVSWH1jfN0h+UN0YCBtc9qPOnICUMOpVllp9m7ERnHrvkG
         cgg/9nlii+j/E5IDFKJBpwhhJsJsDf8//VCVVfCzNg5RH428BBhTwTX1C3lvTTX35STm
         nZlCNst4vxw2l6gtsikVJTReCsuoDpX+giwbyUD7qFnV7Qvc/QcB0HzhLt+Nq+BM8Q2K
         y6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sC/aVNas3nwvZybOCDxxqpd01x5ZzosIW3uKnf2wrXY=;
        b=luqx0ldCmrmE3nEyN+iazDp2zqErZ3RvlKNlpnbGv38GB4ZTFd/DcH98/a+XmoSWCR
         hiG6Xinej83sacsD5OV3UvGmjRezVzS1MFYNOMddAzSIk63AUjTy9lJTNbemd1QO+krh
         ALOMGP7ePs0J46kPHyV4F6Po9c200wyLC6bI38xjQoU/V9inGE0G/7OxeewmFRsP+ufj
         yKGnHppPDTpwWTAxhL9rbuEeRKDM1B3s+VVP84gWfqzkle1MCmmss+bNEA1JgB3cp53e
         miSMwbPfcjQ5Q5rYnP0OBou1aluXxmNXeGJNLtwcmRuksYtxnkgS2ynqhQocotSzj73s
         ergA==
X-Gm-Message-State: AA+aEWbkPIkLbPuLpp9YVewe8ZCgrO8qqsfQTR/8pKL+4s/sZndv9tUR
        Ts04rPvMksY7b3rZck4Eh3kelETC
X-Google-Smtp-Source: AFSGD/WiosOFcgGOsoX5cLeJw3dQt2CYBkc8QTj836KFfV0JZkCgwGNpRBeLCQsE39/QYWLDFwg6RA==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr10199611pld.168.1544997488393;
        Sun, 16 Dec 2018 13:58:08 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id k191sm12736056pgd.9.2018.12.16.13.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 13:58:07 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 0/3] 
Date:   Sun, 16 Dec 2018 13:57:56 -0800
Message-Id: <20181216215759.24011-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181111235831.44824-1-nbelakovski@gmail.com>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Finally got around to submitting latest changes.

I think this addresses all the feedback

The atom now returns the worktree path instead of '+'

I stuck to cyan for the coloring, since it seemed most popular

I added one more change to display the worktree path in cyan for git branch -vvv
Not sure if it's in the best place, but it seemed like it would be nice to add
the path in the same color so that there's some visibility as to why a particular
branch is colored in cyan. If it proves to be controversial, I wouldn't want it to
hold up this series, we can skip it and I can move discussion to a separate thread
(or just forget it, as the case may be)

Travis CI results: https://travis-ci.org/nbelakovski/git/builds/468569102

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: Mark and color a branch differently if it is checked out in a
    linked worktree
  branch: Add an extra verbose output displaying worktree path for refs
    checked out in a linked worktree

 Documentation/git-for-each-ref.txt |  4 +++
 builtin/branch.c                   | 16 ++++++---
 ref-filter.c                       | 70 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  |  8 ++---
 t/t3203-branch-output.sh           | 21 ++++++++++++
 t/t6302-for-each-ref-filter.sh     | 15 ++++++++
 6 files changed, 126 insertions(+), 8 deletions(-)

-- 
2.14.2

