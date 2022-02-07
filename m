Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A1BC47080
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 06:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiBGGj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 01:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381708AbiBGGKF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 01:10:05 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EECC043184
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 22:10:04 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y129so572531ybe.7
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 22:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uMntZ6Ed8257cCICzh9Y98I78P07/3Ibf39QRjoakmQ=;
        b=ScK75BUyOID+oz+0XOYhMsK9m7qoSfHTgXFDPN7LmbJhqkCDRa+IxdH4EVfw4XAvFl
         z3TGl5ULTX/7SJVGT6KeskxvFfNfSIY2bdf5VQwjGhjVzYkj+Tm8bU6mwT606GEPtj5X
         NVRAKNWdpOYl24xD/1Reh5o3zaLa8OQ4S+ktVkSC2BAWwzgcBVZeoV+D5zjqPEoY4Ff5
         vMUAYK4EAJCmoB4+VFER9BGRGlSLh9WxtkDuKL2QcQwoog03+LjT9qPt1EwqtZp9Wcor
         WNjSU+GNQuT4HjWh/6aHFCywzvWs/OXzWhllk4/EpWw41AIhCKS0NmHpu1JbL1G9KGHB
         i4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uMntZ6Ed8257cCICzh9Y98I78P07/3Ibf39QRjoakmQ=;
        b=kTxtsraq6V2KBWaASM5EQx4xRBZZpB1/fEx84qq8Akm/qnqbyqy5opJrUuxaEPme58
         f0OR3ah3vVTVXJ599YjqK99lnBzjK3g3bzZPMq0hiikpXAXjkSX8w4m8aFsQnZ62IAlr
         QIwVGS5A2RA+vU0YSooAbjD/q2Q2fR5iJxzmRN66pdPXGMSjp43fIkJlof3yspxIwluT
         Tl+pQJFX+NAVrjPVXJljxb5ZJ+/k2PC/qoWnQNku3vH9EL00XT9hWpSGEE/2d76bHZT5
         FCmDpCsQv0SQY63vYgT/hrZtc09CzXg8VyYGakC9W5IVHPVmHuwVQYB2UdTSWvNYou0N
         MmhA==
X-Gm-Message-State: AOAM530+Mqaa79VxvQNdD0SwFkou6tKry6SATraJcaIT8PIidzRBAmsL
        OX64SrO8uEKcBH+CZUxE99Fd9oFv5p/B4ZvAZnHFOR89u/w=
X-Google-Smtp-Source: ABdhPJxs35I73C9rCQucSK600iie2tgJTLgxOEI8AuF4pp89NM6P+Rtj5AQYNcPTow+qprmRqnBU297EvB7sgeWaQLE=
X-Received: by 2002:a25:4643:: with SMTP id t64mr8888379yba.424.1644214203616;
 Sun, 06 Feb 2022 22:10:03 -0800 (PST)
MIME-Version: 1.0
From:   Samarth Mayya <samarthmayya@gmail.com>
Date:   Mon, 7 Feb 2022 11:39:52 +0530
Message-ID: <CADy+vq-O09DqzjQ_Fc1nicGkF-JN35z+U3HBdmqXaHD59xtjPg@mail.gmail.com>
Subject: [GSoC][newbie]
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Mentors,
In a prior mail, I had conveyed that I am new to Open Source, and
would like to start by contributing to Git (and thereby, try for a
GSoC selection as well).
Going forward with that, I would like to know if there are any
microprojects that would suit a newbie like me, so that I can get a
good grasp over Git.

Thank you,
Yours sincerely,
Samarth Mayya
