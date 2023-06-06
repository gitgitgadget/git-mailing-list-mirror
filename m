Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4AC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbjFFT5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFFT5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:57:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9610EC
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:57:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so262a12.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686081430; x=1688673430;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iW2MH05SKZUViwK4fKN1o53uD5rxMyZasmeRsSOKwAg=;
        b=0K7M8PgSH693fZTDz0SiHSRt0FpB+dN4cqobu5SmulhjY4wWrige7rHoxR8MY/cyrJ
         dCkAWqTFmC80/ALmjY7uc3qOQ2WprFZ8+Pn3FFx0i+Tt8yvfLnSsSrilhZg1VNqQsJw7
         VrtfhbzSGOHxCfdaijLhGLjSscgKyGzILBcG50pNBHtBGxU91V2CelWNzc1p/w1frM1K
         nLyt4kyi92jqeCajeTiD0uU+7Z+Oo8jy4EiBZTMWcfe6VR4AmQ+5J9kQpyLIhBYmJI44
         sAYulmuPKZJiHVuMLnYnQZ69vVS21QhjUtusnUwGwY1iExawFk44Uwa4yaVmDnHRKAoO
         SDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686081430; x=1688673430;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW2MH05SKZUViwK4fKN1o53uD5rxMyZasmeRsSOKwAg=;
        b=JueqojF5axiFIrJOPkEEpFLIKtfN7yFS8xMS2RvpOVqPkjdFFK98v7IfNq/zYeS+Kd
         UZekkii5aioPl3qSgt4V7hTXclwVaSkHqcbvGSCB2RinqASQg4aTFxvOl0LWrDSSAhlQ
         J+1N+C6cAmtCe7CcZzpldJKseLb2X5U5ERyI1QQZ6iCMZro4nJvrweyyiJbm33mHEF+i
         vs9ArEQu4ywBLYjB2StV3U+S+eJuvNSiWfUIbmz/fiLrJDalD1Kqt9/EvQ0PQsAH6v53
         Huosia86U3zKqBggPAp6BNe2kWm5444Rr3ivvvZ1kBEmQewolz1NCYIlT1KUIBiud40r
         MtFw==
X-Gm-Message-State: AC+VfDyUBM2C1sTOSOyQpXoKIj55sHxJBLlC+2y28eTmzq+9CViYc03z
        bbMzApabzx2cj2lIR1ZELecQV8GKUxIdD7ZECX3MLpprQqInzDJuGFgqQg==
X-Google-Smtp-Source: ACHHUZ583v56VHSAy7OEs2eaJ16dU9qrdVm8x845hytU0vAYEB7DXai+1QhxCRKyzFbsKfXDBQWCHemtjSglaBPIu/s=
X-Received: by 2002:a50:9542:0:b0:502:368:66a8 with SMTP id
 v2-20020a509542000000b00502036866a8mr24815eda.1.1686081430478; Tue, 06 Jun
 2023 12:57:10 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 6 Jun 2023 12:56:59 -0700
Message-ID: <CAFySSZDHTt_Fd1ie2AwV5k5A4O7iAmvSS6XWJVyE-V+c7J6SOQ@mail.gmail.com>
Subject: Join us for Review Club!
To:     Git Mailing List <git@vger.kernel.org>
Cc:     ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Patrick's series to introduce a new NUL
terminated output format to git-cat-file [3]. Let me know if you're
interested and would like
to join (off-list is fine), and I'll send you an invite :)

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal
[3] https://lore.kernel.org/all/cover.1686028409.git.ps@pks.im/
