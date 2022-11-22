Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03AC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKVACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVACd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:02:33 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB7D111
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:02:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37360a6236fso127078477b3.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8t+sMg1XrBkED1/t+oZwGojFFGh35jn8cnf/kblr04w=;
        b=WkaUhbRSgji7xivsPzvfSLEmggf6o5V/Q3jYea1PcE5cskpvAR0WVhV+TFnf++wFdh
         2iJ9UWjDyc9roz2M0/2hUjmy8vP83toBw6Y18uF7Q9UuwyCuyQ4w9pO0yP8QgJCNERJG
         SAzjly30aUv7NHt00iAJQilqj0w24rzMKavPLDaTvST0np7jHk54wfhV38iQz2IIVgVb
         y3Wrhc3BAOKvtqzEoDiS39LbFWHVi0qaX2/bVdCFDQ7oA2KMoVvLw7vzzjN5LY2WdrFg
         mKhdT3yZwb+jxMoIfd0fL/SU6Yef73Q+61SHWFtl4T3uT6SdptloO9SnLbeLE7OFX86K
         sCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8t+sMg1XrBkED1/t+oZwGojFFGh35jn8cnf/kblr04w=;
        b=UHnXb7TgrsAbadDtk4jz4aCmFKmXI4BSaU2c3j8PhSa+P0/qtb3VgwhKfQdgQoHpZV
         XBYCsORAaxhXCZ/eKo95u9aDvjx/HVaAC8KkZ2lJ1fUhu2Yb1Ib1txHFRA6TNsltsKi8
         RuVEvKYpSfXRVd/yjoiIOQZeHFut8BPqEa4LhLLN6zq01z8nHzwOQRg3GpUNPaRwkNPZ
         BYaf2NkrQKFabPiWtcQQG7mATmcUAfYVkRNC/cZq0yuDauy5U3+iCflUUnBfEbW2BYo0
         xQEnKVpASCP46AF9L0lr5QfTLuIyV5+IPKBJ0DsIADZ1kzSXwlyvEN6HBmEKkfz6HmUI
         j0Zw==
X-Gm-Message-State: ANoB5pnewLWG09FKHJUEPrkC1OFPea5ZgsWx8XSe/YbiHvxslDzJEOyi
        iecLjj4rRs/w+dEFQNQJcCexn1Tn/kMPrA5rw5XvKNSCOkMtCEzoohRIX7yZFmxKHIHfNrWVCSG
        wqfqYUy8qztks96drc9/rRLkUbyER8BIdYdoxHO6k9qRPJZivwNZ3pCaj7jMvZqg=
X-Google-Smtp-Source: AA0mqf6byMbP2eNuZxiMv8ohsc1XsSxYjJmQsyNGFVQ9Yn+anjaGFPxUfslM66NOCHcGpu21P0qwlxziI75/AQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:c012:0:b0:6ec:d917:b74b with SMTP id
 c18-20020a25c012000000b006ecd917b74bmr1581834ybf.332.1669075352099; Mon, 21
 Nov 2022 16:02:32 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:02:30 -0800
Mime-Version: 1.0
Message-ID: <kl6lr0xveu09.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone :)

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Calvin Wan's parallelization of "git
status" with submodules [3]. Let me know if you're interested and would
like to join (off-list is fine), and I'll send you an invite :) If
you're interested but can't make that time, let me know too!

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal 
[3] https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/
