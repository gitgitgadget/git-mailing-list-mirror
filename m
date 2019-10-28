Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316ED1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfJ1NFu (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:05:50 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45166 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfJ1NFu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:05:50 -0400
Received: by mail-wr1-f46.google.com with SMTP id q13so9773680wrs.12
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Bc51JHQ28VNpSCz8h3VUqi2Hw9ECBrudDK8FDmViF+U=;
        b=GbaErGTAfBY7XTGVyC5Dt/qkCkWzLoHUkAT9ZDjYFYITJG1wCF7FuVDpGKxKZmycIR
         jxCdXd8F61tKwNxDLcHHjLb+BgedJ3staHN6s2CqBUZ59wUDPhxUZ8VA/1TH5EyCgqM5
         KxSdYmxI3L0fmw8OAL9Fg/1CqxVXAeR+gMtFVZtvW0wRuAkIlrJEUuU86FJXUP/DgLq0
         pOOIDDDa6XYDmCmhPC65OftIxYnoX5wO+zO2+rGs41zWG+6JspjECg51UWf+zQFtZ5am
         Y4xL0894ag56Zv+Md54uJPaDG7pAaBA2++DOTWdKRB+GKyAV8ILbgew8z2dups+JMZY7
         EF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bc51JHQ28VNpSCz8h3VUqi2Hw9ECBrudDK8FDmViF+U=;
        b=gzLAGIHTMfu+aBYGuPN64xRwivbqzIrFQ78xmuADv4U1u5Y19C52kdzxzick3XWD9j
         9UxswTxJPXPVtiv5ll9EX7aomyov/26hF5I0kNXCw0mfJaN1xUOUmaO0usRNQi6SRrIf
         d3+HmhA2w0ubXEO97WD8r1Qjj4pPFmxm4PrCvu3I6c85sUKWfoRPH1iPVNj1BugRjaC4
         ExXRCSDVbx8RedpXtWDwstWHvnBRM3Y2+gUGcnFYYj29Yc4bWqRUn2ydGmqikFSDVEZQ
         Fn0bTID4OCaubD9ntPK8fSZaPRg7xZc9pGSporYlfANAwf9R9Nw84RBQoTymueWzfyoh
         qqrg==
X-Gm-Message-State: APjAAAVfEYjXlEwJfHoVbMSKiEb/leLbNGa2dohywNlqzvPYUcpv/BJv
        IAIwmOEk8dEG++BKqHc0HMwMtXAy
X-Google-Smtp-Source: APXvYqwG25d1caipBc0vvdC4CkAm0t6vBYqvBCWLfb9DxlwQCnABsujDrZiSGEBiPaTqF28UiDlqJw==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr15252056wrv.54.1572267947695;
        Mon, 28 Oct 2019 06:05:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm11621735wru.83.2019.10.28.06.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 06:05:47 -0700 (PDT)
Message-Id: <pull.433.git.1572267946.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 13:05:45 +0000
Subject: [PATCH 0/1] help: add gitsubmodules to the list of guides
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The guide "gitsubmodules" was added in d480345 (submodules: overhaul
documentation, 2017-06-22), but it was not added to command-list.txt when
commit 1b81d8c (help: use command-list.txt for the source of guides,
2018-05-20) taught "git help" to obtain the guide list from this file.

Add it now.

Philippe Blain (1):
  help: add gitsubmodules to the list of guides

 Documentation/gitsubmodules.txt | 2 +-
 command-list.txt                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-433%2Fphil-blain%2Fadd-gitsubmodules-to-guides-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-433/phil-blain/add-gitsubmodules-to-guides-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/433
-- 
gitgitgadget
