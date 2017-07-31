Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694661F991
	for <e@80x24.org>; Mon, 31 Jul 2017 14:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbdGaOAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 10:00:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35453 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdGaOAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 10:00:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so26279043pfq.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=/RdC2tKloIjtGmurmCk4GWdAbPqBirSZ48SuM7rIiZY=;
        b=Ohxn5Ext7YjxhYQWkqiSxgjPeC5ZyreHfuPXMR24YbpnoFqZDm7aLSBF6BNhUkFC+K
         R0EY9Y90OAweLZQqpy9SEiUU+mKwfUQ/sDy1UYTdutCYxhKd6P6Lv5jq/dkmsXmk5EXC
         /zt6Gg0Fmg8ecg1fS/37gG+uTTFnaNIVr1FKag5AKxzROmaDCXmsZgg85N7oht/gn5tp
         P4XrwVTDHwCS5FaumXhMokH/i+dFJSSSPtfUkBW+3g1bq6jL+2SE21nPYfFqx4HPcHFT
         J+vIK11LE8SSdpgFtGgNq2g8Hkgr7fZz4swEN1GpOD0VZb116OD2++UP1JHyVEjKycol
         s1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/RdC2tKloIjtGmurmCk4GWdAbPqBirSZ48SuM7rIiZY=;
        b=ZkXISfOyKSWDF7GCUZcwqE8sW9NurJMpRcpRgXl3Nyy/QwOfOrst0qoWuO3FWbJjqZ
         ZRZSwNP+SUWNXmH3y6wyhmqGGMhxfFzltv2miE4IdtpnTby7unbaA1UaZvC1qnaAyeTw
         ykzZPyaC5ZUr5vmATXiB7Cn/n+/b8Xl/J1gFGkRYiFOdHb4PRnYhkyfrbCPdc6FFgOy6
         gYHwUK/DDAPtcnQPy8NwQwks1PSrWxL0sE/dOEQvCE4xgwjyA+YH1DCf35fLfsBlGcdO
         xI8bY8ngVnaUYzmoxFhNqF/dlEHnenKzoCgMLMLKOwJcuMIMNLlN5p88tMTEzNI/Kbvo
         jghQ==
X-Gm-Message-State: AIVw112nm00LFLyNsGVo2mkSJapUzeaYQf19Xm8zEpfoT/CSUslKhUqQ
        +gnTzeXC548TgxSSKhiFExRhd+miOj+v2TA=
X-Received: by 10.99.125.68 with SMTP id m4mr15486303pgn.259.1501509631716;
 Mon, 31 Jul 2017 07:00:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Mon, 31 Jul 2017 07:00:31 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 31 Jul 2017 07:00:31 -0700
Message-ID: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
Subject: [PATCH] Fix minor typo in git-diff docs.
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be honest, I'm a bit overwhelmed by the documentation for submitting a patch!

I tried to follow as best I could, here's my attempt (please advise).

From e88ad689a7587c11f270a10f191a3b6bc52a90d4 Mon Sep 17 00:00:00 2001
From: Anthony Sottile <asottile@umich.edu>
Date: Mon, 31 Jul 2017 06:54:14 -0700
Subject: [PATCH] Fix minor typo in git-diff docs.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 Documentation/diff-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f4..43d18a4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -392,7 +392,7 @@ endif::git-log[]
        the diff between the preimage and `/dev/null`. The resulting patch
        is not meant to be applied with `patch` or `git apply`; this is
        solely for people who want to just concentrate on reviewing the
-       text after the change. In addition, the output obviously lack
+       text after the change. In addition, the output obviously lacks
        enough information to apply such a patch in reverse, even manually,
        hence the name of the option.
 +
-- 
2.7.4
