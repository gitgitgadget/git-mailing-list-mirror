Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E93D1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfD2WEi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:04:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46440 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2WEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:04:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so10489997edd.13
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KlopGQ/MMO/LIP+VQxjiVSKplANtji/zeRKgUMZgros=;
        b=YgqUgeqfuJWliqK5tx2OS5PjPaKfhArv4+dduel27515i30DLekyIsmAlM6oe5qiQp
         Ir8xdzLUF192WCRotA/x1Cyza2a0NTuqb9kwklvCGiI4xSF6rkmCtaU5IPy0HNzL3tjl
         ODvH0ghKblpbvZEVPvQ9sgA56um5pVyp7Ns6xYp198V8LLRKI1M0cwymHUM0KquXGvzM
         cik7DB9GFiIVgVM11uvLWxbQpzc+EyoTFiIq619yBApo+yNJEXNZbJnUeUtMthzW+XpJ
         0/+POBLZeqDT08kA5oveVuJnyfaoPqfLb71afJAqHFG2eOQJ0I0k7JmZXuF+o5sbREss
         EJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KlopGQ/MMO/LIP+VQxjiVSKplANtji/zeRKgUMZgros=;
        b=ppz9zluPrd4CQxaSky02GMhD9zrXL9xqKNu6NWNs+MkU3fAwl7Trus7NnLcbc848iK
         5TPRpt65xsoEZ/lNYDhsREqUjRCNpV21F5lJZb+96JKY8O8vhjFTkIxvQjMX9VEpXRva
         u4Q7w8iOiXeO57h7gfq2Y0fjHkHvt/cnnaVuYOsEbAy9kaXVJ/4+g9hiAub3NbAN65GF
         UbJJ7Fl8ylgtWOc/YgUMyiIQ6gFt6sd3zIbbNipA1I5Eix6trwkDIyDaUPx+/CW1BY+3
         RRz+U1kMTcEz/DFT7yq31c0nGbjtwy8Cutzf5QR8Lai/clp0Zm9MLAZSyrdeB0hnzz6F
         zWcA==
X-Gm-Message-State: APjAAAX8TiB7ABmGxiWN7A+oeQhyMlB4ULdporY1EiZ6VvrGZtz2XTIC
        Q5BT+SRi/7BXcrf/eA28c82myxl2
X-Google-Smtp-Source: APXvYqwqebtvOZCOMbo1zBIaSEaa8dIxXBn40EdR6elCJQsBJLIbEHBEwuuJrP4aja27oahCV+SLnw==
X-Received: by 2002:a17:906:6406:: with SMTP id d6mr32804738ejm.103.1556575476212;
        Mon, 29 Apr 2019 15:04:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t29sm1295834edb.30.2019.04.29.15.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:04:35 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:04:35 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 22:04:34 GMT
Message-Id: <pull.137.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Support git:// with old MinGW
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

The MinGW project (which can now be considered "old", as mingw-w64 is the
standard thing to use nowadays, since it also supports 64-bit builds) had
some problems with our sideband feature, and in Git for Windows <2.x, we
introduced a config setting to still allow using the git:// protocol by
forcing off the sideband channel.

Let's contribute this patch to upstream Git, at long last.

Thomas Braun (1):
  mingw: optionally disable side-band-64k for transport

 Documentation/config.txt          |  2 ++
 Documentation/config/sendpack.txt |  5 +++++
 send-pack.c                       | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sendpack.txt


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-137%2Fdscho%2Fsideband-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-137/dscho/sideband-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/137
-- 
gitgitgadget
