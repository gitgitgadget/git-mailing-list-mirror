Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B591F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJ1Pfr (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:47 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39309 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:46 -0400
Received: by mail-lj1-f169.google.com with SMTP id a28-v6so1767941ljd.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzwTBBSGiD0WKj3qKO6TyF8QppC39Mls0aoi7h8vW6s=;
        b=MwjFjRGXoA35Y4ULUpN1xQBXfaqRRf4/8zvc0J8B2UO1PHilD4HPZavZtUaCkkeYgw
         Hg66XNEyEtkEdfQ0NmKOlGsFdN3C7WEVTfz42OU+LvuQ8GW9RA+LLfEcRCWyiK2zVA6X
         kIkGkRRr0JahAUCbZXFO8gIHDDZ+BwnSyxbLCzR3YL0QI1lUTLaeRth5quFbAoLkJeAh
         uWCoq03JmrfQxvdgfLs7Y+UP7nOhgzcg5O2XjBpGa6N00JSSjtkusLOIY4knc0fNKMJs
         IG6pyqzY9SQKZh9U8LxeYGOO90sG2Mbu14NqArYfz21FlZmrEBx+EFWhi46A8nyI2oaw
         fCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzwTBBSGiD0WKj3qKO6TyF8QppC39Mls0aoi7h8vW6s=;
        b=r9OfgWMX1zaoShj8mx81o8Fnw8YLM22R3pYxlflHS0hWc5kz+2W9A7eoB34mY6Wc1q
         QrRdnQWVaqSm7/PQKCFRs+3Wpp5BNhO0RYyyh79sZyolOpKWJKs7RYKjsTnN9P2oAp1h
         PqkbPu3KdXWwsJsw2ywlsCZbzYYxYVRxYsXFgoStBphbHPXdXG58+bFkV4l+bMcTVg1C
         shNDpnfWgckWzMqJwOvmnTaQv0xuakltzor4088mQyKXxVcARR2fJc/yP72p0GsZVZjj
         EzfeZWIdEXalCdSb4vGVOuic8bCLH9x190l4S/NQddB1etxF5JE3qJhgY4g5FAWvSlKn
         t/CQ==
X-Gm-Message-State: AGRZ1gJnNWdKa25t7/6k+lcAY0tCjGTGZeKGp7uCLQ1q6G7bzU3YC+71
        V5UWO1EMTkfDiMNe7+o0IuCkLwLF
X-Google-Smtp-Source: AJdET5fI2GPgiUSJvmHNsQyUYe+xx5FuT7gDf3eOat1YeYqNO5SjSzuQApd4F0wp79pSkBI5hhrgBw==
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr6984555ljs.74.1540709522469;
        Sat, 27 Oct 2018 23:52:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/12] Mark more strings for translation
Date:   Sun, 28 Oct 2018 07:51:45 +0100
Message-Id: <20181028065157.26727-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much to write here. I make a note whenever I see unstranslated
strings during review and this is the result. There are some more code
changes than just adding _() though, e.g. 10/12.

Nguyễn Thái Ngọc Duy (12):
  git.c: mark more strings for translation
  alias.c: mark split_cmdline_strerror() strings for translation
  archive.c: mark more strings for translation
  attr.c: mark more string for translation
  read-cache.c: mark more strings for translation
  read-cache.c: add missing colon separators
  reflog: mark strings for translation
  remote.c: mark messages for translation
  repack: mark more strings for translation
  parse-options: replace opterror() with optname()
  parse-options.c: mark more strings for translation
  fsck: mark strings for translation

 alias.c                    |   4 +-
 archive.c                  |   8 +--
 attr.c                     |   2 +-
 builtin/fsck.c             | 113 ++++++++++++++++++++-----------------
 builtin/merge.c            |   4 +-
 builtin/reflog.c           |  34 ++++++-----
 builtin/repack.c           |  26 ++++-----
 builtin/revert.c           |   3 +-
 git.c                      |  32 +++++------
 parse-options-cb.c         |   7 ++-
 parse-options.c            |  64 +++++++++++----------
 parse-options.h            |   5 +-
 read-cache.c               |  73 ++++++++++++------------
 ref-filter.c               |   8 ++-
 remote.c                   |  49 ++++++++--------
 t/t0040-parse-options.sh   |   4 +-
 t/t1410-reflog.sh          |   6 +-
 t/t1450-fsck.sh            |  52 ++++++++---------
 t/t4211-line-log.sh        |   2 +-
 t/t6050-replace.sh         |   4 +-
 t/t7415-submodule-names.sh |   6 +-
 21 files changed, 264 insertions(+), 242 deletions(-)

-- 
2.19.1.647.g708186aaf9

