Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CC120756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdAQXfJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:35:09 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36568 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdAQXfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:35:07 -0500
Received: by mail-pg0-f53.google.com with SMTP id t6so23037738pgt.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WdOpu5x/X5UVbgC5AyX3WbBXkVzocM3rl/2p3BLQvGM=;
        b=QcsqEQ3tffvYmxxprTzH0GMGowJMP9/43heVpknuhzAQJjyp4c9wRu4ED/+Vh3QwS4
         vSAGvk+gXdcp1/oTmA46Br6Gx4YXC7Z9TKFlSMv1k48+mX8DCBjESurrTQgRJf9IT3v5
         PDKxwW0NFku74o7SUFvhagOVdeqosV50ujGqMUnn/mGlvU+bqPTXoYdTt0bLDkJUWRTV
         lDtIxH4n4GxkIVTasvm9BfwEvKgiJNvAWSeaRXpupdOFcW7oWfF/L88T3KctDSwpMnxl
         ifH7Zw83jTg6c9fbgTEtwvMb29BvlJqSLTRUYmfgzNeJNNzDpUYmisfs8cPtdX0sKHlX
         xaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WdOpu5x/X5UVbgC5AyX3WbBXkVzocM3rl/2p3BLQvGM=;
        b=ar2Ta6FavjzTQMW9VYpBdOausNzonbaxRmyMHwA1AIjChQlDpzvNADmB7SlulIlm2t
         7/vU3/7S/8UwWft9/brxUxDs9nsaIPcUf64/MmNK2wqGm8Hsmu4tx6SYlEz1ZztsO9mp
         zQQNjJUAMVtdXjhpQMnvU/qOehA4xUl2MFNVrpxYZjAGe7Fseyz8NUvbHMnwQFRo0tF0
         5dQk/hkfMsUzSH9pjgSpda+MYWFuEg9K2f4b3c60T7yCyGeGHK8tZSNoCuI/I9B+wTI4
         Nq0su4V4HeN5cK3XLYj5tgbsQZVAGIZAtd/Eg+yLOc454eiS7Phxru7ahihvGx7SZPJF
         AF1A==
X-Gm-Message-State: AIkVDXJ8YTu1s+ZXGJWYQ1v6LoiA4eh4hYvWjhRnwTvJh8LwQguJRuGaKx8cO3UHYVDVAfQG
X-Received: by 10.84.171.195 with SMTP id l61mr387373plb.84.1484696106264;
        Tue, 17 Jan 2017 15:35:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id d128sm41135560pfg.56.2017.01.17.15.35.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 15:35:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] start documenting core functions
Date:   Tue, 17 Jan 2017 15:34:59 -0800
Message-Id: <20170117233503.27137-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two single patches[1] are turned into a series here.

[1] https://public-inbox.org/git/20170117200147.25425-1-sbeller@google.com/

Thanks,
Stefan

Stefan Beller (4):
  document index_name_pos
  remove_index_entry_at: move documentation to cache.h
  document add_[file_]to_index
  documentation: retire unfinished documentation

 Documentation/technical/api-in-core-index.txt | 21 ----------------
 cache.h                                       | 35 +++++++++++++++++++++++----
 read-cache.c                                  |  1 -
 3 files changed, 30 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

-- 
2.11.0.299.g762782ba8a

