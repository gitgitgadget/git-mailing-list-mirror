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
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A291F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfFYOth (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42285 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfFYOtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so27539161edq.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4f07BskVjja2sCXYPOMaiA7HIs4U1rV1+oT5jx14NzA=;
        b=G/LSA8wUvk5vw0UGQ8y7a2JVUesBk4xfM+h8MzThiqHCWTU5/gzTuJy55m1QVCh3Dt
         z6xYg7hBxg5rrQala1gBsb0YTeKMdIZLctbtN9pZ3lRJJGcUXRrkGvguErwAs8Gora0Q
         R6Ni0/fmnmOrYqZcey47yg9Ril3vhZ0CzBF9B4Fe6y2icsJ5qfrqmv8+wxisv9Zxov3a
         NRoH8WLm/Ydcnxg6duSs9bXIb6o+uy+1zPT9x9IM3JHDrAxiVnuaIERpH5eSzViZSj4N
         6Vf3rLbCoV8eij7tDASkAz17opw54WFXrqtirpsy89Ni5oqzI+dgOFEb7Ay0NO6IvE7Z
         kCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4f07BskVjja2sCXYPOMaiA7HIs4U1rV1+oT5jx14NzA=;
        b=Dc6ewT3IsSIhjZ8ffIqWx0C7E5n9wlstusHs38MSMG2G5g5c0j0IF8PCmsFv1eaA+d
         N+k/iaT72iABEAp8CdnNzB2hXZC8SQar92kBQOFmmQKM4ZIhZbbM+zV8wBgCNd4Q18h/
         q40lfg3PSeMS6r4ZlYsPvfYdxsm+1l/ci+zmMqbA4qifqbKwlbi4LwKJf1ylczn+Pdeb
         pcsNe592p86P/mC3xuHhf21MQ5LhJuLnYvgBly9OKKSad3hBzm7G6qPdC27LU1KFdk7V
         E7W8uIsWFJFDBkkisFK0I6QYsP8kL6+F3NRibXmdTDXZ/Kexissf6d0TmT/wD0lj1rfG
         qS+w==
X-Gm-Message-State: APjAAAVakzy+tQKF+BkVILQtZVlA9TKzbbozrF7lrO2dzW8toKCpFeTG
        qm8ZlzEUBwZGWE7fb0HT/1qIyLrb
X-Google-Smtp-Source: APXvYqw9CwmzyV4n81fy30e21f4uctp+mZq3+q06GHCgtso7wXh765L6EPzx+Oe6+pg11xzc4KseBw==
X-Received: by 2002:aa7:ce91:: with SMTP id y17mr114071601edv.56.1561474174205;
        Tue, 25 Jun 2019 07:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19sm2463893eje.30.2019.06.25.07.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:33 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:33 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:13 GMT
Message-Id: <5c383985a19f8d7edff4a496021c99849840c8be.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 07/20] msvc: fix dependencies of compat/msvc.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The file compat/msvc.c includes compat/mingw.c, which means that we have
to recompile compat/msvc.o if compat/mingw.c changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6ddece0350..473613a20d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -414,6 +414,8 @@ else
 	BASIC_CFLAGS += -Zi -MDd
 endif
 	X = .exe
+
+compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
-- 
gitgitgadget

