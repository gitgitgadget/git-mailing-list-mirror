Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37221F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbeFAHql (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:46:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36839 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFAHqk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:46:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so1015387wma.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LjusCNgY+nrFCOXIZDCvXZcZIEEmRq4BhrDvP0i20GQ=;
        b=YCT+cXlCHpVW06x2uyMid+Tp36AV+E3psb7LN9D4ushNP8FK0HRHxPcdztATdRiM2H
         r8yekkuDR/k97UIhev4Cley1aiRxZjUPdVQhy7wSYmFNgeiv/9kv5vhJ3CZsAJkI+hRi
         cLHJW5NjVhaohLUoWzjFPcjMRtuZDqYWo8sPlPTxT8x4cFbxff5Rv1/4gwTxh7S9ztzX
         sHA46+O+xsaUZnuNwQ7O42vkCLJ/iz1pThJ5skXxWbGnaA62jPw46Ois/u1p8GuqpTsM
         q6KJArz6oRun/Ka4TgD+ytCTf5imWt+kTJudbVYCfQoeZvLVc6mYGeVRChWWU14TLTvh
         2HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjusCNgY+nrFCOXIZDCvXZcZIEEmRq4BhrDvP0i20GQ=;
        b=CgqwK6J7z2KTPkWVBsKcFezXiQDjRsBd5CVAXw5VdK+Kq6PhGAWYxZgm+8oJLmzZHm
         vEhksiU/R9Yd2rr64MIoQXgDbMbJ4b4FoOsw512pGnjItc2ULPSnbRjt8mOwabU8QM1E
         B10YY4s9UTYSAn6qIqvN/0wzfqYK/Q0PaR6o9BflwyGzAZnJOduniYsXXSqXY2brG1GO
         JeBO4yimZcqB5PDDa0g0jUXfexjuL9XRG2ZPfXxbCSpdlVAaR4s5WkoBD++eRxiCyJiZ
         +UMypDxxEhuMBtxWYZpWEhfEFSAWGY9bM9AqcVEVyl2dKV7fL0rW46a6sqlKa9P229zT
         zEAQ==
X-Gm-Message-State: APt69E2RrDscPmhykmnA3CKT7Dosj0nY1fZy3Q9cFaFGIeK0aUS9irbu
        w8+3MDZP8CWjWLQeVk847OE=
X-Google-Smtp-Source: ADUXVKKh8QGhrGQABX8aQM35J8nc1j2Jz/ZnAEZPavqowMdjlmAIW0NYJ4HM3SNAgXWA0V/I/adnoQ==
X-Received: by 2002:a1c:64c5:: with SMTP id y188-v6mr1830618wmb.45.1527839199451;
        Fri, 01 Jun 2018 00:46:39 -0700 (PDT)
Received: from ws-ncy-merland.paradigmgeo.net (2a01cb088ab9050021defbf4b392fc27.ipv6.abo.wanadoo.fr. [2a01:cb08:8ab9:500:21de:fbf4:b392:fc27])
        by smtp.gmail.com with ESMTPSA id s5-v6sm43069861wra.48.2018.06.01.00.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jun 2018 00:46:38 -0700 (PDT)
From:   Romain Merland <merlorom@gmail.com>
X-Google-Original-From: Romain Merland <merlorom@yahoo.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Merland <merlorom@yahoo.fr>, git@vger.kernel.org,
        Luke Diamand <luke@diamand.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Jeff King <peff@peff.net>,
        Cedric Borgese <cedric.borgese@gmail.com>
Subject: [PATCH 0/1] git-p4: add options --commit and --disable-rebase
Date:   Fri,  1 Jun 2018 09:46:13 +0200
Message-Id: <20180601074614.7856-1-merlorom@yahoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a daily work with multiple local git branches, the usual way to submit only a
specified commit was to cherry-pick the commit on master then run git-p4 submit.
It can be very annoying to switch between local branches and master, only to
submit one commit.
The proposed new way is to select directly the commit you want to submit.

add option --commit to command 'git-p4 submit' in order to submit only specified commit(s) in p4.

On a daily work developping software with big compilation time, one may not want
to rebase on his local git tree, in order to avoid long recompilation.

add option --disable-rebase to command 'git-p4 submit' in order to disable rebase after submission.

Romain Merland (1):
  git-p4: add options --commit and --disable-rebase

 Documentation/git-p4.txt | 14 ++++++++++++++
 git-p4.py                | 29 +++++++++++++++++++++++------
 t/t9807-git-p4-submit.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 6 deletions(-)

-- 
2.17.0

