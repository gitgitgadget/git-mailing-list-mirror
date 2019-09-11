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
	by dcvr.yhbt.net (Postfix) with ESMTP id 673A31F463
	for <e@80x24.org>; Wed, 11 Sep 2019 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfIKOw6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 10:52:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfIKOwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 10:52:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so24931683wrd.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eBiCQWkfnADnQSzVsfDlJLmvJQb5zzavxa/1SB/ePTE=;
        b=r6MdlCcdTEZWSFn/nSiuHskbEjnnIUqRdW5ynLaKyRVhPRzsWooO4w/hrnksPx2iSu
         q05fSGh8si+c8wf6f8N/AlWLNRkhOsCi486e20H+h5Ocqm3RZfTtWLAOwbrcfncr2CZW
         3KIFcGPewnAg7ER1fGbumPskArmXZcHcckaF4rTfYjlXQ8Tazq1y0MVd+0MAzvS/q1WV
         Zyx1ZeVkFBOhyCbrsiGy0voK2t/uNLaS37ZKQZ9L+GKhjghCrkPoFmdJpmJ1vO9WFuY0
         W6k24/HjBOhpwmCp8C0MuNPfvcKlGCvwSyDTfrxx3LKCpZi7haitvunRMjzSaVXachdX
         gS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eBiCQWkfnADnQSzVsfDlJLmvJQb5zzavxa/1SB/ePTE=;
        b=bXnJCK1lBUmuTmsNQcsDEEx5yCH9wFzODWsxqqUPmLkqhzeygr+txflwfavzptMhpE
         FEqC/D25xpITxOrfzTCNd0X+h/EALZ+U/HWzAsqcx3qx5O1N0q9WnAXghb5928cgGlSh
         mlHIEHK8s/8+LmGq9A8xwTrT2rbn0WEXQGK2VSojU54hzZebCBr/giw2aZ34R9UzZ13D
         poSd97dRkP/0WZsvuJrnjo2kV2A+LrMPSq7iNure2RLzu5rwiQaB+G4HZFSDyTVgnELJ
         1QKF8Px2CGElusIjiR+yOVM+Uz4NWL45iY7BaXQIcGiJODzOgeBLQV1yobrnkO6I+Rc3
         IJZQ==
X-Gm-Message-State: APjAAAVLyA0C/mnEHYKVm9/J1LLRNLeFjcFAbslQXWf4eQKY68YUHHoQ
        DIlLoew+LmHdlGuvb70TGbcKig8o
X-Google-Smtp-Source: APXvYqxw9zuYogYd2vGSRH42XW6noD9LHAsajLbBjCDjX9b++cf4/yGaZwwjxuXBHNTw6yxjs/6O1A==
X-Received: by 2002:adf:a499:: with SMTP id g25mr8725142wrb.204.1568213572231;
        Wed, 11 Sep 2019 07:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm18930934wrw.4.2019.09.11.07.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 07:52:51 -0700 (PDT)
Date:   Wed, 11 Sep 2019 07:52:51 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 14:52:50 GMT
Message-Id: <8e6400745275e0af317552e73384101e5745a667.1568213570.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.330.v2.git.gitgitgadget@gmail.com>
References: <pull.330.git.gitgitgadget@gmail.com>
        <pull.330.v2.git.gitgitgadget@gmail.com>
From:   "Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] doc: minor formatting fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Cameron Steffen <cam.steffen94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cameron Steffen <cam.steffen94@gmail.com>

Move a closing backtick that was placed one character too soon.

Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 079598307a..b87e2e83e6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -208,7 +208,7 @@ endif::git-rev-list[]
 '%GP':: show the fingerprint of the primary key whose subkey was used
 	to sign a signed commit
 '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
-	minutes ago`}; the format follows the rules described for the
+	minutes ago}`; the format follows the rules described for the
 	`-g` option. The portion before the `@` is the refname as
 	given on the command line (so `git log -g refs/heads/master`
 	would yield `refs/heads/master@{0}`).
-- 
gitgitgadget
