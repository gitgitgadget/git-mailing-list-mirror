Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6141F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 12:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbeKVWkF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 17:40:05 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43402 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbeKVWkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 17:40:05 -0500
Received: by mail-pl1-f172.google.com with SMTP id gn14so9188927plb.10
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 04:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FyeP1C1NjG7EqUzRR3WiQQoayaAvrbpeDbnvyG+97oY=;
        b=SIYKMfOU3I38jsVK0DNJIO1DDrnr8ealFvsWTWZ5OoTowXiOIyi0Iy594IFitcm5hp
         6XHPgfDCpUJtae5/jjcm7QbgyvBbxTx8j7ij3/nVoNeQaw+HVA8R7qFI+RfEhY/mfzX1
         Yx+ROaHo/zzJfGp+gTDQBqk0EaL8YBLhH6Wy+kkNnDmeS6Jeo6bTEzJ3+iZ2JoPH3l35
         ONQJK4XjL2PWlA3clLHhIFWemm4VHqLhl6St2U9+sHtyQIpGuT3ZtgXjFUVDppi72Bf/
         aYrMnAZhVox8PfSCROaQWX1/kfJZznvQKZ0AOAFm5lng5Qici5M873qISEkIahtAHZvL
         PqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FyeP1C1NjG7EqUzRR3WiQQoayaAvrbpeDbnvyG+97oY=;
        b=Z/j9jSL8BEhR78LLKs01A3TGz/YPDnIrjMPZjXT2MX38xHYEBeu44aUOaPjtftlo7r
         8/+zm9H0g8vo+G80ihSDPvodecC2uaUMuDflqrynQyt4/IS1KXyh9DIyx2htj3gyvUpG
         elcmEk8vVIVwQBdTmEEwzKbXgMaUwm0Ish3dN+nrpPuUGm4ktEX9bOdqrHn2vsMDKXBW
         RA/6r/aOtVOpZyHAv4DDD1Z+DIXVYvC3t+nqnanTUo/pOjnEGdJ9WQ8rFHHGOlYdM9xf
         eUGyyqlD/E2udjuNjCwHBwn5v1hSgeK0LMu4OeBtCc+NUMQ1nNKSCYT8CA0eCKVBg8TC
         d4Vw==
X-Gm-Message-State: AA+aEWYDt/MnjDOQQRWN7nc2OkZJSUkvguqpYDTbgsptej83hrZFxFH0
        RfRaa1avRBXv34R+2shwc3tiZApw
X-Google-Smtp-Source: AFSGD/VkUry229KTWM62UDPQ/Gjqqgd6+lOI0peQXi2Ax7OYhEYUW1FczioF1irSMJougTKpRH7sag==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr10956390plt.21.1542888059737;
        Thu, 22 Nov 2018 04:00:59 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 4sm69176274pfq.10.2018.11.22.04.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 04:00:58 -0800 (PST)
Date:   Thu, 22 Nov 2018 04:00:58 -0800 (PST)
X-Google-Original-Date: Thu, 22 Nov 2018 12:00:55 GMT
Message-Id: <pull.87.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix Windows build of next
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

The topic ot/ref-filter-object-info broke the Windows build since it entered 
pu, and as a consequence we have no test coverage of the other topics in pu.

Sadly, this topic now advanced to next. Junio, I would like to ask you to
merge this fix down to next and to advance to master together with 
ot/ref-filter-object-info.

Johannes Schindelin (1):
  ref-filter: replace unportable `%lld` format

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: d364d6b33e15dbc6e57d83f9f1457a8e8fe77046
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-87%2Fdscho%2Fno-percent-lld-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-87/dscho/no-percent-lld-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/87
-- 
gitgitgadget
