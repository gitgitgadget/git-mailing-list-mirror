Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1281F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDJV0b (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:42373 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id o16so9304365pfk.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XZ0/wJfmJUwuKD8IX64j1MAcNVk39rBSylG4Dudj9w=;
        b=sLrJGmfIsJY+GRrjw4KauYDwdY5nGmpU3Nfk5KUxlN2O0JEUub01Mj5xHP/mYP1DnS
         T3zhBbAoeZ+8nuakrzchpI4kespHJ9Q1T+nx6Z4fcfQtJiqNG69UUUhoHjkMOZHnIthi
         8dPPeKAb267MTYpqsTPBvQ718LJ74FkdxQe9j0apGF+dfTHymage5AXO1ariOpr1TCDo
         zJbuG2M2m+JuT94Col0vberBWMQmsKze8YWG46dShDZ62jqH316IXviKD3rf1nAc+8/T
         0265cR4tdLgw0P9Dp+M9OWIPBCnzeA4mJb9ek4aRVyTgM/5eiQCFM19XP8/IYRqXkD49
         Sc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XZ0/wJfmJUwuKD8IX64j1MAcNVk39rBSylG4Dudj9w=;
        b=YqHed+PVbLgkDYzqCXae4R5/SHALVndKwMUt71UiyYEzl5yovFIv2+uOH772s66nsA
         2KMEdnJnX2sYu9BpXoPrmdXUXg1SaHix0MbaucsMfwIJnZ54ifg9Dg3vYueyZluRYGCG
         jWTdeFfwRcKMR3YfKKeXmz6dwdecusp8ii8PrFy06Q9g90zMNmB+DSJ1YuvKff+3tOgP
         PhzBGNQWXoycIjTYU5pCb08buATipdnDnQzvomujUgNdUM4OK3e2spGApQQNUpzXOZDG
         Evw8E9tJB1K+3gF3DOD3MaVERlA8u2ljwX2x02RdV3AxXuQVNqymQ4aGD954vc80LPJS
         WoeA==
X-Gm-Message-State: ALQs6tCHABSbhCbOed/166Vq/iVRVs+6uDxMi1VuLRee4QtKfOIb+k/j
        /tuQ1c+vYhpyfyIB1Yjco53NLw==
X-Google-Smtp-Source: AIpwx4832pYOIjpPeyaikzhfOYSxbPO0AxfEutuTnjni5mkJQ6OaDlfyPUqSn5u0zJVhlizoTBVorQ==
X-Received: by 10.99.154.82 with SMTP id e18mr1413303pgo.365.1523395589933;
        Tue, 10 Apr 2018 14:26:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s17sm8153323pfk.105.2018.04.10.14.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 0/6] Rename files to use dashes instead of underscores
Date:   Tue, 10 Apr 2018 14:26:15 -0700
Message-Id: <20180410212621.259409-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the followup for 
https://public-inbox.org/git/xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com/

We have no files left with underscores in their names.

Thanks,
Stefan

Stefan Beller (6):
  write_or_die.c: rename to use dashes in file name
  unicode_width.h: rename to use dash in file name
  exec_cmd: rename to use dash in file name
  sha1_name.c: rename to use dash in file name
  sha1_file.c: rename to use dash in file name
  replace_object.c: rename to use dash in file name

 Documentation/technical/api-object-access.txt |  2 +-
 Makefile                                      | 14 +++++++-------
 attr.c                                        |  2 +-
 builtin/add.c                                 |  2 +-
 builtin/am.c                                  |  2 +-
 builtin/describe.c                            |  2 +-
 builtin/difftool.c                            |  2 +-
 builtin/hash-object.c                         |  2 +-
 builtin/help.c                                |  2 +-
 builtin/index-pack.c                          |  4 ++--
 builtin/init-db.c                             |  2 +-
 builtin/merge-tree.c                          |  2 +-
 builtin/notes.c                               |  2 +-
 builtin/pull.c                                |  2 +-
 builtin/receive-pack.c                        |  2 +-
 common-main.c                                 |  2 +-
 config.c                                      |  2 +-
 contrib/update-unicode/README                 |  6 +++---
 contrib/update-unicode/update_unicode.sh      |  2 +-
 exec_cmd.c => exec-cmd.c                      |  2 +-
 exec_cmd.h => exec-cmd.h                      |  0
 fetch-pack.c                                  |  2 +-
 git.c                                         |  2 +-
 help.c                                        |  2 +-
 http-backend.c                                |  2 +-
 http-fetch.c                                  |  2 +-
 http-push.c                                   |  2 +-
 imap-send.c                                   |  2 +-
 list-objects-filter.c                         |  2 +-
 object.h                                      |  2 +-
 remote-curl.c                                 |  2 +-
 remote-testsvn.c                              |  2 +-
 replace_object.c => replace-object.c          |  0
 run-command.c                                 |  2 +-
 sequencer.c                                   |  2 +-
 sha1_file.c => sha1-file.c                    |  0
 sha1_name.c => sha1-name.c                    |  0
 shell.c                                       |  2 +-
 unicode_width.h => unicode-width.h            |  0
 upload-pack.c                                 |  2 +-
 utf8.c                                        |  2 +-
 write_or_die.c => write-or-die.c              |  0
 42 files changed, 45 insertions(+), 45 deletions(-)
 rename exec_cmd.c => exec-cmd.c (99%)
 rename exec_cmd.h => exec-cmd.h (100%)
 rename replace_object.c => replace-object.c (100%)
 rename sha1_file.c => sha1-file.c (100%)
 rename sha1_name.c => sha1-name.c (100%)
 rename unicode_width.h => unicode-width.h (100%)
 rename write_or_die.c => write-or-die.c (100%)

-- 
2.17.0.484.g0c8726318c-goog

