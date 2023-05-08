Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9FC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjEHSyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHSyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:54:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4F5FE6
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:54:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f2548256d0so2645e9.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683572046; x=1686164046;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naqMjxswbwD71JRwT0hJrrT6Km0NPEboe3ejeyS5kpA=;
        b=ikp8Wci1BaGyviPQnKdG/xQ+wxMeAUNQmzuclLl5Cc6XMXMZJQgJLVmu+xMFj+8xPB
         GOSkP/5iHPk4DnwhP0/I5/oE9znE/66uTqyyJ7eBF7+dBsIX8DlCUQogQpeDXNfD2XqV
         VFPIK49mn2zHFYr0m1lsaT/O3xp8FDsjtm9eTSknHy0tjGJYSTOZhlj/Rr9Orh3Z4TDU
         MJVCTGYSgy8f6FiiTcYJfzFgvACdS2yZJQOrOk7MmIipu0y9QawSNFA/FvN2tBtAdkt1
         imo61T0MIANtNOdIsMbY+k/Cd7ThVY1+bsF1kNvKMPoF97mqjlbMHkQTpdfu1qnF6El7
         mQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572046; x=1686164046;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naqMjxswbwD71JRwT0hJrrT6Km0NPEboe3ejeyS5kpA=;
        b=FmdfgT6X4AmAWQZL93RvLi+X/mhC17Bm0u+rrf31pX9EMheABuNRQLNI4PC++JH0jp
         d9Svwju8J6Dbc0CuKHZf9L8W/UmTSsVlMXoTiIdJrEoYqYBVkO2cb3fLVchv96/D50sk
         zjbVYKRnPWMVtEgzfI673TN8OlN5Z4E5uW0bs5Yzndisw0HhqqRigmjTcDpg7i4My4sc
         t/belLbJFLmq142QmeAkpVcEd8C/VaN7DZHD251AxgylE4LZkzfauSZfsuh5vs0a2avS
         SLllyUmWB+NO12BgxKK1FYALAwRe6Shvf2KKXzV+igoOw11dNmF84G7GdrrJBPDVvCxb
         Uj7w==
X-Gm-Message-State: AC+VfDwETYquwX4Yfe/TyV4CbpQVBEGicvr7z6DBm2gZe/2t7t45P+05
        AIZyLjIocygZjQITEBgZrt9rYqHc+K6eUqki6HjeeRJSxhDSAJyx/GPE5g==
X-Google-Smtp-Source: ACHHUZ5rYcW75EK9adJnGzm6BGxqx0Y8b5zoVebaE+oX6D9lyAnixaBKJlzo3CiBwoIfnX98k2diZ15GbSVqckmltqo=
X-Received: by 2002:a05:600c:b41:b0:3f4:2736:b5eb with SMTP id
 k1-20020a05600c0b4100b003f42736b5ebmr22379wmr.1.1683572046076; Mon, 08 May
 2023 11:54:06 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 May 2023 11:53:54 -0700
Message-ID: <CAFySSZD6hJZij9MyM_aKntZw_yMHgOvMjf-WdQaf-gZZsTXqVw@mail.gmail.com>
Subject: Nominate a Series for Review Club!
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

We're looking for nominations for Review Club this week. If you think
your series or anyone's series would be interesting for us to look at
during Review Club this Wednesday at 14:00 Pacific time (UTC-8),
please reply to this or send me a message off-list. I'll send out a
mail tomorrow with the selected series.
