Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0FC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 17:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJYRKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYRKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 13:10:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3BB1BBC
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 10:10:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dc888dc62so122908227b3.4
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ozr1KbMSDSMrkB4MAe/t/oagrRMyaHduUDpgqzVVZl8=;
        b=mRolDiIsr9yBbZmlYMB5BDIkRO+ylBmk349KIcOQYyQ8w1gH4hFlDuJFr+8NuUJTMc
         GLuAIQzQLLYHdsJQ3oaqhUUJ15g9e6dxreNDyfdd/L+zst7JQHt3G1yCT+wTakbJNeTX
         pYC2kwoLsbXhfsVfsiX8MAKlSoL8Z9RSqyhWTVYq3xLLgEghkNwEARCRKxSKkTSa5Axi
         SMuMVEqoGHo5038m/emo7+JRgHKAfPcuKomfkv/cU8uHWi9l4Rldbmzbix985UxoSvx+
         IEhw2yRTu771pbhApZGd71lww0r7h0k33RyFnUrlQEKrKm/2j4SlNQ7AqEGNYi/6Ofqv
         p0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ozr1KbMSDSMrkB4MAe/t/oagrRMyaHduUDpgqzVVZl8=;
        b=wmhkahLeal7IBIoz5fgW2XqleiJXWOgL6lnjj5U83qGJXjftKHiaJdbWI3wmxwtVAh
         b940FPEugHyTvG1gzjONgaJG8Ls5oNIwmr0MzKU0E1vSyE175Gz+1HuoDgexvJJ0q9gD
         ihhkkBuJtcSCf8ay4Jnbi06kw483mqjY4BxZhSvhnAJ/q3Q8IyiYyoTKWMYq+L3xGOPV
         /6f1r9e8oaR9eEwCmXw1Jk8gDqrs5ccG2KhHKVnatNUWQYqiV2X1dRbAEvlsxaY1Clz7
         Js7krET0FkYAIENLbDCXhf171hynMMhHWj/FZOxKrl5twwi58z4UGCj0SiXuvPM1rB1n
         wk3A==
X-Gm-Message-State: ACrzQf2xcfJ2dJm2yh9/4dJldCtbzmPhgRSDRtTbEf0JJLZWAN7ubtrw
        /NzTU016a5UqG3iaRsjnLpNpfN1oAuO9cvcLvwCJsPIZIttDS7w5C/36TGni++1fGbEm9rEOJE+
        PTNMqvDc/jtkZOA1tyVTh4TzTZn8RCXExAHPJz2/39Vq/QW+N6KCe1KQiqeBYEow=
X-Google-Smtp-Source: AMsMyM6en3pS2G8mgutIsQ2yjEpYb8azW6vG7R/X36E+tCOEyS2/ID2eU02PGqV5JuJFG9dFdnMExbP/gKFOFQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7a01:0:b0:6b0:820:dd44 with SMTP id
 v1-20020a257a01000000b006b00820dd44mr32348729ybc.387.1666717819453; Tue, 25
 Oct 2022 10:10:19 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:10:17 -0700
Mime-Version: 1.0
Message-ID: <kl6l35bbsubq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

The Google-run Review Club is happening again this Wednesday at 14:00
Pacific time (UTC-7). You can find more info at [1] and on gitcal [2].
We run a session every other week, and you can find the full schedule on
gitcal.

This week, we'll be discussing Heather Lapointe's `add
--recurse-submodules to git-archive` [3]. Let me know if you're
interested and would like to join (off-list is fine), and I'll send you
an invite :) If you're interested but can't make that time, let me know
too!

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal 
[3] https://lore.kernel.org/git/pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com/
