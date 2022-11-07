Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB6C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 23:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiKGXPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKGXPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 18:15:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3C28E13
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 15:15:10 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso6871896pgc.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 15:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGACOCP/Om9GbA3apsoyFA7HGYDcWwK6upfQJ9UxhgY=;
        b=ewE6aRcHAI+fIrHltrj6yk1Z7xRfxufFxxG8+iDhhU72joVUS5tOUHl0D4UgIfJT+T
         HexeFANvEymo3scj9QCe2CykaxYZBKDDqA/peFRL1f77wLKYlm+Fkkb1gZQH4snUi9df
         0HpX1y3WgcEcTqunTIGBYzSMJ5tumOXxxRzCMZWjy8s8rokmteWZM4CLGRdy+pxW2ONq
         AZO06MfUgW/BAJSSpAwVb44k4ItAZfv1Y1eS//v+23I2KSYJbaDIeRaWUcVVVwEcpPgK
         9t2AtssWrGoPY6WETL7kMPxtNDz/W4Ub0kQOrYKrs4rC7YCFjNuXFzylgkP7O9e0D3tf
         AE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGACOCP/Om9GbA3apsoyFA7HGYDcWwK6upfQJ9UxhgY=;
        b=QMgiiQNG5YNcZXremG/ghliCB21YbzuywFu1SN2FT7LXri1vfDR+gI5xQkck1ZKoc2
         TtQ6AuRzZ0K3UA1w7m6Z7P+uQSzNilkQzi0+gPTmv2pVX0+ngML4+ZrmDzbHPHbnNBTp
         x+smBdJjn/5rK/dv1CIfSAOqGbYQ1iaKQ+TRcl5836+jkc1Cr2NsKROpPYL1uDotxNnz
         j3DgBt9oelog8alpFM+ii42xbhBAQ32AS2XNAc1A7OyzxBe4pq/qXdHfMCTF4QT/IhCX
         W0L7PDDf1kpGLwKu27n2TykJRDjN43STmDNDK/XrfyF/krLylseQSDUse9Slg6i4rjV1
         zUwg==
X-Gm-Message-State: ACrzQf1YYZhJnyd48Rdqp2Fy3TxYxhsEk8U5WLk8e7BCTbp0yvMhUJTz
        8+l4571FMOQP7ZezNHUbvxBLMsTQ/3gmeDiliTl1z/Oy3xJEqqSlYksMtAzW4G8WWFO7qOhGJTJ
        mP/mtHhjdmAOqGAzX274XhyMAVuveEWa8s9iU2RUFjw3+S+TD5pQo9MZnY2KHGLo=
X-Google-Smtp-Source: AMsMyM7vV6umTyxeX5fZmfKpVIuAhTX1HmqDBlJwUfKflNm1SeHFfk0WEfaI7yxZyjhywzBFhMC1L4u9Qxo6Kg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:15cf:0:b0:56e:664f:707c with SMTP id
 198-20020a6215cf000000b0056e664f707cmr23861755pfv.39.1667862909536; Mon, 07
 Nov 2022 15:15:09 -0800 (PST)
Date:   Mon, 07 Nov 2022 15:15:00 -0800
Mime-Version: 1.0
Message-ID: <kl6lpmdywe4r.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org, mjcheetham@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8)
(Note the recent timezone change! I personally can't wait for Daylight
Savings to stop being a thing..) You can find more info at [1] and on
gitcal [2]. We run a session every other week, and you can find the full
schedule on gitcal.

This week, we'll be discussing Matthew John Cheetham's extensions to
the credential heper protocol. [3]. Let me know if you're interested and
would like to join (off-list is fine), and I'll send you an invite :) If
you're interested but can't make that time, let me know too!

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal 
[3] https://lore.kernel.org/git/pull.1352.v3.git.1667426969.gitgitgadget@gmail.com/
