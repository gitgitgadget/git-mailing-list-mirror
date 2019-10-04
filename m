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
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E461F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbfJDPJa (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52377 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389570AbfJDPJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so6222568wmh.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=g9pMzMD/X4LHW3ylNN8AroWlB6oHLsA/DE2zKm97LNnW8kJ7d0JG1BHBcREsOm5QZ7
         3Pndwg2UXwX2pSpe+GKWE+4ruPpBZIv+dSxNx8sXOJ+SXDGvP55fuer5jqyQFQxCW1kR
         Xg6gTnY7WbCpZdzESnPvduMxr50CinQINr1Nv1ToonT5zD8KPctVsgcvsZSaBlx1Jh9u
         V2egkoaPzh3l04xMq6RSqnL2S5eTx/iE+oIdP3zZJhoj0rz6LuzoLcj3GoviRGdqQPMA
         MKZufNyjoM2N60sFoWumzFgMW2lHq9I5p2S+MEYszZjOo9W5xFa42ld9ZsakvQX28tvx
         GTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=JYQBiKCy60qvEoCx5rgmLf7a1UmKH3ml0ONtTr561Lk7QAxMoFmKJ9RIWmViEUuQ6b
         cK+B6gbjBV7awqH1xlAKkVdfFzMAoFUfeFCoEfzXD4JEPvernh+8KP9wcchLDiR0qmGl
         hWzpik6kiTt3YynIYMmIEz7B9W0z9oEYbXZbubluMMqO4TyAbvmoyZ2WBtw03g4Yi8Em
         BvPqN0ibyl13FW4/g0sk51tcRTYvFe4i4eykXxxUEvs48W7lo86RI5pobaVdqcqghkGq
         X7StlgmBwyxMQ6C33bia91zpjd4pCYXzmyvjpeGwlWHy9eL25mW9Vu4DmCZBnh6rFd3k
         pq0A==
X-Gm-Message-State: APjAAAVhzhY0Xf7ll48SdO3b80JHbToyIw/K82zkS5deSEaMxwvS8nyk
        CLtiy7HxmLwurt8FQn/dh7wy3I7D
X-Google-Smtp-Source: APXvYqwWODTLgoSZuGYhXazRGJcD26D78zSdZgQR6/imSq3cfbbTimV4OJT97dnBl6b40fKgE3IJRw==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr10975333wme.77.1570201768163;
        Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q192sm9068299wme.23.2019.10.04.08.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:27 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:27 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:12 GMT
Message-Id: <e632a4eef46720d43fd014644ff24d3dac61ebe9.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/13] winansi: use FLEX_ARRAY to avoid compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSVC would complain thusly:

    C4200: nonstandard extension used: zero-sized array in struct/union

Let's just use the `FLEX_ARRAY` constant that we introduced for exactly
this type of scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cacd82c833..54fd701cbf 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -546,7 +546,7 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 typedef struct _OBJECT_NAME_INFORMATION
 {
 	UNICODE_STRING Name;
-	WCHAR NameBuffer[0];
+	WCHAR NameBuffer[FLEX_ARRAY];
 } OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
 
 #define ObjectNameInformation 1
-- 
gitgitgadget

