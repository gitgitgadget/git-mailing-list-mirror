Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3E51F462
	for <e@80x24.org>; Wed,  5 Jun 2019 15:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfFEPGK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 11:06:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbfFEPGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 11:06:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so6250895edq.9
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwRrATkCPUvhQurAYPdsNkmILiGNQLQmndkRfZCSFys=;
        b=fta6fzTDKRd+iewcNE6Uu8UDWwrC0pgumnEW4/sr17QL0VoIuMTL8XgDYhlGnVCX8m
         p5cmr071YPQM9fD9iQOUUUY9OC1vdfhjz+u4gULP3DlBrc96V7nc49hfZNZQ21tBf8dq
         QrdA8xyyw1XfSWVrbElC10vISjvC5fWt1ATCiCzHMBnVUXoO3m27ipB67WC4xv0ekqNx
         O7ydjANRvQxlDKz6syqB2zy7GxJKtFK4z4V+0CDm4gAyl2BuaaaY2YhtUtIyWjPt8Yms
         zfi8t3Kqa3kmbDQYHjMypteMDKVu+vlS73mt+ebclpf5G6n4Ryd0w1O7o4CFCUzLC1CP
         6Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwRrATkCPUvhQurAYPdsNkmILiGNQLQmndkRfZCSFys=;
        b=oEOUNJBisb8EcRheLNh8uG+wLLDKazYT72z9asKMOvQzgxxQCk2bv7F6+IiF4KqwP7
         8CRSvV57QvVjfvNPQwx0l1DbPwZm/g4wXaSFNlo2eYZA6s1ls3RVaSwZbtolnL9LXlYz
         nbY09Qgth1JH+NurLNzZ4m3xLLToN1KckCx6L1hHMY5pRGMOsNeo9ZBDQ3EI07byPLsl
         I1zVrzpRbUmbzckr51HIuphlq4HGdAz+FRJDqYDGZxxzMuc3EcWKmMhqsR9A+paJOH2j
         5yC6MW8kUXVFlWgDsvhooFEYzgIhVVNUvdiAiMZUDCEB3Z+242itjZG72iKVuawbdnuU
         rljg==
X-Gm-Message-State: APjAAAVo3/Khx/RDQHmYxUW+LQ6yC9JpNnCMNJ3gBOi16KGPMmZHGV29
        bE/xhWX9Uk37og8MTRB/oxrWQAba
X-Google-Smtp-Source: APXvYqx1pJK6StJCAmgau2mN5a13z16JdzddkXfqJ6/ft7SSjC28HUMrGpyiFnHJljCiXB1BH/2ADg==
X-Received: by 2002:a50:905a:: with SMTP id z26mr43711584edz.96.1559747167518;
        Wed, 05 Jun 2019 08:06:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm3691492ejr.19.2019.06.05.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:06:07 -0700 (PDT)
Date:   Wed, 05 Jun 2019 08:06:07 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Jun 2019 15:06:04 GMT
Message-Id: <0074d3da7ad402043d58ebb107435ce955a347f5.1559747165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.255.git.gitgitgadget@gmail.com>
References: <pull.255.git.gitgitgadget@gmail.com>
From:   "Edward D'Souza via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-prompt.sh: update shell variable instructions.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Edward D'Souza <edsouza@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Edward D'Souza <edsouza@gmail.com>

Clarify the need to set variables like GIT_PS1_SHOWDIRTYSTATE before
"source ~/.git-prompt.sh" is executed in your shell init process.

If you set these preferences too late i.e. after .git-prompt.sh executes,
they will silently fail to take effect.

Signed-off-by: Edward D'Souza <edsouza@gmail.com>
---
 contrib/completion/git-prompt.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c6cbef38c2..ab5bcc0fec 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -35,6 +35,11 @@
 #
 # The prompt status always includes the current branch name.
 #
+# The prompt can be customized by setting various shell variables
+# (GIT_PS1_SHOWDIRTYSTATE, GIT_PS1_SHOWSTASHSTATE, etc.), which are described
+# below. Make sure that these variables get set *before* the
+# "source ~/.git-prompt.sh" line from step 2 (above) runs.
+#
 # In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
 # unstaged (*) and staged (+) changes will be shown next to the branch
 # name.  You can configure this per-repository with the
-- 
gitgitgadget
