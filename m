Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF1CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjJLRal (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbjJLRaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:30:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86610B
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:30:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so2165214a12.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131836; x=1697736636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xrPsLKpDHViYgK2LpEXW5S8foewhICn3wIwZ/giA0sM=;
        b=KlDbtHCe/UpICGf9tpXQWwzBLL4zAYnSjiKJ/XowkMgHt7ArABTuG4c9FogRF86hu0
         /C/KXlqwE4jfWq2z+rXFd8rC6JQPROneNgXdXD72R+LLbzC9bTKkri+OMDkkrdkFcP6H
         56XWm3Ctwg+bOZ8Az+NlAysYJOtjZ3syZlox4XudOGwr1xszASFjDuBv4OLwOaaQLmev
         v53XwNaK6sElwDkrD/69kWqIRTBops0H6zXz77TgqulJjXSkYt6Zu5eyTYf21cERwT7G
         7Dp2p6t3yMGUL3SyedXAnXXFugPannwgSrm0KVHFbK3eHcY2OIzhMq3VpiRZGKUiS8V7
         76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131836; x=1697736636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrPsLKpDHViYgK2LpEXW5S8foewhICn3wIwZ/giA0sM=;
        b=Bk3MutqCba7DyrKyrRfvKfOcgoEuu4T377plseH43U3rIvo4QNHpM85jAa98djK8FS
         iouUFl5R6SlCKMCrOWYAVQqRL8ypc6usntCvVLOnLQFTJa5FtjPpeYz1cZlOtw4CUWti
         CZ0oeQAKwtIbc0lrcx+GJlyPl1svp2vdMYmH82RNps/Lnd9p4ut7tk+LSRkIHS9MDy3r
         JHeeDGOi5qLjkSxp6XlJERCFm/3QGfpCT5JXQ34tm6AQhDpVTpcsqRocKnN///uPL59l
         pfDsvAhcv4arL26UmATxQSkbvCPZwWh0rO/+T3glBDBVxvDYWbHnYAlMQhAvYufhD3bD
         MFvw==
X-Gm-Message-State: AOJu0YwMmSjKXGwgKLjSwmdvIL/vhTeVbfykHhrjMr7jsIdw5hUSqTXu
        kpfffakB710C4fG9IsZabE6shw3HG9U=
X-Google-Smtp-Source: AGHT+IHJ+LbXxyDnozNX0Gx3LdlySvZkuNDaVw3qcFnEUmMkNfGGNu0MolDuo4LuXH67ETYQ9ijy9g==
X-Received: by 2002:a05:6402:5192:b0:53e:2c49:8041 with SMTP id q18-20020a056402519200b0053e2c498041mr1116632edd.8.1697131836170;
        Thu, 12 Oct 2023 10:30:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd19-20020a056402207300b0053e31113ff7sm165061edb.94.2023.10.12.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:30:34 -0700 (PDT)
Message-ID: <pull.1592.git.1697131834003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Oct 2023 17:30:33 +0000
Subject: [PATCH] mailmap: change primary address for Derrick Stolee
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <stolee@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

The previous primary address is no longer valid.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    mailmap: change primary address for Derrick Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1592%2Fderrickstolee%2Fmailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1592/derrickstolee/mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1592

 .mailmap | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index dc31d70b8c1..82129be449f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -59,9 +59,9 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
-Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
-Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
-Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>
+Derrick Stolee <stolee@gmail.com> <derrickstolee@github.com>
+Derrick Stolee <stolee@gmail.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
+Derrick Stolee <stolee@gmail.com> <dstolee@microsoft.com>
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>

base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
-- 
gitgitgadget
