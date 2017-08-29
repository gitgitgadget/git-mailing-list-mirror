Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E419208CD
	for <e@80x24.org>; Tue, 29 Aug 2017 01:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdH2BMr (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 21:12:47 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36224 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdH2BMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 21:12:46 -0400
Received: by mail-pg0-f46.google.com with SMTP id r133so6223721pgr.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VK/OawKOwkLQm/fTtkduV1kjL/IoOGtakVr7A2dDBYw=;
        b=shCje7jG4urc06rgI09/V7I3ATSN/ce5ikaG/MlMDv27nMUMOYrgUvfibK2xdUEzPZ
         hh0hvWEgbh7xYxtNvH2edgO/O44iL0enjwoAExNnw+FKj3Frg6/R7LcWSCY336BWLU/E
         FiyJfdsmbvQD0MM8BrgszDQKI+xaawq7KPFuqpxqwdWoZQ9HoU4WsssHt0fxAbPq7OJo
         tszQjTV6Pg21m9ohCbcMmp21cD/yMaStFyu4UC4YUrUYbBGParVT5L7EKK8jHY96ZAzm
         ZSr4f4WO8TnWS06lPvPs56+9KgopL6uqkfON4LOv+EZcxO28YND9UQAuVXFDaBgV1mDJ
         zADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VK/OawKOwkLQm/fTtkduV1kjL/IoOGtakVr7A2dDBYw=;
        b=FJ1aVRmiLcSL3jUB4xF3XlBmpaQtZ0QqpaUTvTCOV4osvh9qhzlmA9vXUDaKpYM/AX
         xXVtp28byS/mkkzcQ1uAV9s+5mXNYQnIkAHoa00blOhyUcx+hwz9TICmTBX57MjfcvFH
         FGiWZvAvlYecKDwbEbw4GocApw3Vjr8Wjtb/qnvE+obtw3xdzCpy/XyDKqhvRNctw7Jl
         lGK3abOtGa7YP86fLa/SuWS0EPd18QUfYDWX58l0fpUlNI2V92cU22iTidK6OvkNflIL
         Sw9S0ilmO6fNi5x/ZMQVrmRwlTC/ULZKA0tXchr2z+Sj71o1AI8dwJX/CKM4EzBwtZsg
         8Q4A==
X-Gm-Message-State: AHYfb5jo1mll8ptKqBfMUVOEnsoFAAY6SKnU+rXWkhYZ/vFuiTFf0hsA
        oiqPmjUwWlZGwFxIKG6mHw==
X-Google-Smtp-Source: ADKCNb6QRMHRUdej8MRjJJHftar7CUbaO60P0HsxzJlM0tnAPZxeb0FxZUp6pKQp9pJum9p9JBmb2A==
X-Received: by 10.84.232.71 with SMTP id f7mr2972071pln.352.1503969165379;
        Mon, 28 Aug 2017 18:12:45 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id g7sm2108014pgr.52.2017.08.28.18.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 18:12:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] Remove inadvertently added outgoing/packfile.h
Date:   Mon, 28 Aug 2017 18:12:41 -0700
Message-Id: <20170829011241.26889-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.581.gf28d330327-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This empty file was inadvertently introduced in commit 4f39cd8 ("pack:
move pack name-related functions", 2017-08-23). Remove this file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 outgoing/packfile.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 outgoing/packfile.h

diff --git a/outgoing/packfile.h b/outgoing/packfile.h
deleted file mode 100644
index e69de29bb..000000000
-- 
2.14.1.581.gf28d330327-goog

