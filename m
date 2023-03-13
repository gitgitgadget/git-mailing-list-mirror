Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560EC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 23:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCMXXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMXXi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 19:23:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076D65AA
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 16:23:37 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id u32so6980852ybi.6
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678749816;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwYKCwKG/l7ZKnZjPSuqUSx2GQNAB6iK7u7kOjWAJtI=;
        b=R5iqG9LFst3XuewHvBKWXYxt5YlNqAaAFmRPjkPW9UHZh0nS5AXzZFzyH9//DmajJE
         X5OBrfQ5r/kIIvf+DG8BHheC+HD561gJBNLkCPCVE4rG50jrC7Zzo1+JUcl/eErOMk0C
         YdoTUusw+l1hZ6s8TtFIHtoRvelm2911WjiiJiNt7JSuC6BhtWfkv50jVe/ITHFW8dCi
         xOPG2pFvy3ETW5VwD03RWHY4gnpmDZUuCZ5cD1qdai83ZFmimK9Ywghqcii/teeeeZmG
         CDRhYXxenTgN8bT7tlfiw+M5vq38yyKRAVUGLjR/RuvHxvgmnzY/s3Hf45YwRJRbFCaC
         JEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678749816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwYKCwKG/l7ZKnZjPSuqUSx2GQNAB6iK7u7kOjWAJtI=;
        b=YMXRTD6dqQIcN1oKwTWfAyNc3+6SP/jZLTD0MvGkC7IQgZaZXU3tB2JMw0DlYjEKqn
         eL0Nnil1wqZZD1resewnmFBXrfOW9kOgrQbWXQH9BrTi+9cRNmR8jfmDkvgsOCIxotiy
         6Sd/cAx/7s4GBk6sAcNjPASFFhBOHSQj90UcRw0WXd3uPY4tmDbaWhvZTf2qFcV4OC1y
         eK+rwlOmvy2cseal8CbQ34Emk6Z9mGhMlJcbe4cbggTNSToOJXDFI8OUfzQ0MVy7tDUY
         PcwPSgIDq+/XF8mKoJ9BjVNpSvyehPsN8eOpmIPRGncjOJuN6PoWfccpHraJrVK2SR3p
         7qEA==
X-Gm-Message-State: AO0yUKUpBjRr/dC3DK4aMvd7AbcfwKbbxm6U3ohEDL/Xw8CUSRvuvYWX
        SY/BUN4HXf1q/6s2qkqO0A0HQi00tjIYp0l6rTQtzzx2GCehLzAwpvJDwhg3
X-Google-Smtp-Source: AK7set+U3iQLly5ehoCWWyb7vE98aoUbA2aA7VMiAFOOQdLGoirfDnj4Lz+3n8MF6xGgqRUhXpT0rGfS/wUl/OYOXXo=
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr22249754ybp.4.1678749816084; Mon, 13
 Mar 2023 16:23:36 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 13 Mar 2023 16:23:25 -0700
Message-ID: <CAFySSZAYmtT8gMTVunn-6RMYzYeDE=CQ5fjSL75xYYROwOhqbw@mail.gmail.com>
Subject: Join us for Review Club!
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Derek Stolee's new filter for `git
for-each-ref` [3]. Let me know if you're interested and would
like to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/all/pull.1489.v2.git.1678468863.gitgitgadget@gmail.com/
