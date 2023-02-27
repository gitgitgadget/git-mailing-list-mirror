Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9DC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 22:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB0WDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 17:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB0WDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 17:03:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F111EA9
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 14:03:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a6-20020a17090acb8600b0023797a1b2f7so2077377pju.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUVB3Qeo8KUG7IoCpS+s9tXnN3Y/FOeHQ37HA1SHA6s=;
        b=O1CW3ZI8eSmGV+zMag5WDW/k48NjTpnpbdJ0hAa20URKLMQeYPeVfpbfJtlIsqmftg
         JmMur08saYx8sSj3dXjXqclzXIIPhfiFCNeMWC/HM66WUHnx7QjxlP1PGfS75veabb3D
         EEeo+Y1zCiLP1Aqk18sFwfZtPQxr5c9v6QuHa6MsM3w0HXH25a366z+X2SJpb+GYrLDm
         Yqm8FhB8Pbl8d5fwBrkHaz+kPRJe74VqqwZ7bWFyLex40pg91GuNKO1yb8L2RZhioNQV
         rEtp9oK2Q2oWOEr0PW9qnF2s+YuqKNeatDoEZTT3aL0CYwokU2ForhZg07oS7bq6FmaE
         fbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUVB3Qeo8KUG7IoCpS+s9tXnN3Y/FOeHQ37HA1SHA6s=;
        b=HLjwdXnbXoC+9uhdWxVG/J+DFynW3+4rpYk1F9vL95g3eURqnT1+oV0NWSFr3XXWqi
         B9ILWhoK5nJH9CqnOYuziIvFTPR7lsMYJAWK0ay39g/RTIU+8zlMEQeocEF3nUWaXb9W
         1pmzA8xZACNgiDS/YNy25R/R2wGcTwF1wprhyYccnUQEE7xBt0uTicXk21+5/CAvHSXh
         zpKN19kw6ui5MYkdW5lepiI0iFjVdtwQsuAOjvhHoWmG6iY03yfMl4eqJ6yFR22Lr45t
         EC5K8NEsJ9xpIC/gw2ASDUnaET/lt3qY+S22iER0ZpiJANkYYmxrjTAKVr7O3xFOBdOz
         jmFw==
X-Gm-Message-State: AO0yUKWPeYfBvtCQsvuBdGwspODotfQJGcbO9gI+oJv4qgWeRSBwvnTI
        BGza6PGx/CTi8hwijnUT/M9smURhowZYDbrRJrUDXAaB/xHu36bSYuRJKHyeJOnXohD+Eqr4Xce
        A5R3tkuZ5VgMqPJzV5m9xbNI+AU2k1YcFIOpgH+bmZZX7HkyGCDXx4eJ6uFMab/s=
X-Google-Smtp-Source: AK7set/mSmkXvyuiJUza0gYURZNidIf5RSzC2KujBO9EGqAtu/zaystOHkr08AlkPasMzY98ha3PqB11QpeqqQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:79c5:0:b0:503:253a:1da3 with SMTP id
 u188-20020a6379c5000000b00503253a1da3mr21745pgc.1.1677535388140; Mon, 27 Feb
 2023 14:03:08 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:03:06 -0800
Mime-Version: 1.0
Message-ID: <kl6l4jr66a1x.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi all!

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
The goal of the meeting is to help reviewers learn from each other, and
to get better quality feedback up to the list afterwards. We run a
session every other week, and you can find the full schedule on
gitcal [1].

This week, we'll be discussing Alex Henrie's "rebase.merges" config
option [2]. Let me know if you're interested and would like to join
(off-list is fine), and I'll send you an invite :) If you're interested
but can't make that time, let me know too!

See you there!

[1] http://tinyurl.com/gitcal
[2] https://lore.kernel.org/git/20230225180325.796624-1-alexhenrie24@gmail.com/
Date: Mon, 27 Feb 2023 14:02:57 -0800
Message-ID: <kl6l5ybm6a26.fsf@chooglen-macbookpro.roam.corp.google.com>
