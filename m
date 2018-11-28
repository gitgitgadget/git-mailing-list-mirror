Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454021F609
	for <e@80x24.org>; Wed, 28 Nov 2018 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeK2BPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 20:15:32 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35032 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeK2BPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 20:15:32 -0500
Received: by mail-ot1-f41.google.com with SMTP id 81so23646813otj.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 06:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EG5JmcnlO4M48IUy1aOzRNBQhHCiIET1oGWFpIfJXRs=;
        b=OMS/1EeC6cgwTu/7B816HMfjoN8kxGxkXqC39Kb1Jp5faPBo1tt6LZD/lm3ZfHibFN
         pNLHDZRPwJs1N3MXu7+5cc8EabonmBXyORs6NDwBrjV1TWRebUuFZJEGIARY7/geFf9O
         ZZzMwMZ5mK78ey3rCCMQSzDdB1MLu9Ippgbm0l/Kf5Qn9XOASvUTevnC49xwmUkwEpUW
         gOFNs+Y+6EfOj1taFNj2F886u3lNCvonHigoMWWzew0YpSwGDo7Wn39j65B1VMJb0YNM
         593MFO58wqcCyvoIqHgz4/mCil/NqYG9isWkmzTNBhzo861Q5fSdQW5/jbVjjzFJfbzz
         Rr/Q==
X-Gm-Message-State: AA+aEWan0lUxUcrraUZiSdcWZEYZJ17pSuyhSVUJzrr8Bd/jyuFgE8D/
        OJAsKoMwc2um0ClX6J5W/07G65n4woPqd+1E90p7M8eoNuQ=
X-Google-Smtp-Source: AFSGD/XVdJ0U1thGirY0LrB9A0H+LEu1FHKvHDXqr60orMkogj03mpgFHov3gkVBENQJ4nOXXC+TmawDUoWIzQQhjI0=
X-Received: by 2002:a9d:74c3:: with SMTP id a3mr22106442otl.107.1543414423769;
 Wed, 28 Nov 2018 06:13:43 -0800 (PST)
MIME-Version: 1.0
From:   Kenn Sebesta <kenn@eissq.com>
Date:   Wed, 28 Nov 2018 09:13:17 -0500
Message-ID: <CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q@mail.gmail.com>
Subject: [bug report] git-gui child windows are blank
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2.19.2, installed from brew on macOS Mojave 14.2.1.

`git-gui` is my much beloved go-to tool for everything git.
Unfortunately, on my new Macbook Air it seems to have a bug. When I
first load the program, the parent window populates normally with the
stage/unstaged and diff panes. However, when I click Push, the child
window is completely blank. The frame is there, but there is no
content.

This same behavior is seen if I do a `git gui blame`, where the
primary blame window opens normally but all the children windows are
empty.

I have googled but was unsuccessful in finding a solution. Is this a
known issue?


--Kenn
