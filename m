Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 21:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJRVth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJRVtY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 17:49:24 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15042CE9A4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:49:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-132fb4fd495so18433938fac.12
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23q4VSQ9noBGDOVcU8Gab12ybg0JU+F8/Ve1j/cymxY=;
        b=kAzIZ4bzds2gy2M7oROu+1wdusmW1WYUS8+TLJ9WouMx7ltYfyC98yGDWhi6Lo20JK
         rSeuXD8tVFt+lO6Wp8LdfiX7BaL8BTv6IV8eZXqE60czuibNly8M0MtTSXf9JpSp/XBd
         z12w9pnYg1S5bMlu6PqCHiALRtO01wbmv4Y9VmD9hHJrO58nQi1x+rm1xFv1SLAxX3KW
         cRIqeyN0TRN9oLA2SxbIXEl7JkPabbxul60tPXCuxiiqxOo9oqlIgYzSJhTWG0udrDTC
         upmdx1O/IqgXPhL4A1XmWD9G14lckWBvcoZuFD7J5X6ZHsYJdfFTx6Gcvshb4GXb2Jk0
         zmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23q4VSQ9noBGDOVcU8Gab12ybg0JU+F8/Ve1j/cymxY=;
        b=slsw0vkDDbmO3T4vYbhYetu7sJ7xiyvnanSlj26/cPsv9kg43Y7wAheUSSZKLD2qvU
         ffCAfS4ztgdDD4YObfvphMIc4AVYt5v6Sm+D315YAVyRT3o/Gg7q4oGCdm2KIXBYPIwV
         6MMh5LI+M39B2s6tMO1OKjkbL8EGkg6vdAZ++Ufhoj+GrxApg95MunTdjoUbIScM323R
         PhRGK38VJ+sZ6a+p23vg0YOOaUs0GG9G29HoWEjO0Ptzz5e45fdepWWc8N21ASe2PHiQ
         2oF6CliDc/X0tALwU4Ua9A9fzOc2MXbfJQJNIB/D23oUx3MMuMlWnE8sc4grtnEaajaZ
         LLHQ==
X-Gm-Message-State: ACrzQf3NfFknNZv3hG0HKu/d6gWWsy0s1Yf104wyjEMTwxj5DM68fOiK
        51ll31rNVg72vyCa4LuXmJNBZgP+R66uD2q+1JD41EVM
X-Google-Smtp-Source: AMsMyM5kBteMq6GbOGkliAnA473Lka34h4ApHSUN44xRyZsOFUk4g7EnHg1nOR8HY7ibZlj4KjbHEflT2XPzHT5NZyA=
X-Received: by 2002:a05:6870:a449:b0:132:7dbc:60af with SMTP id
 n9-20020a056870a44900b001327dbc60afmr2960198oal.120.1666129753610; Tue, 18
 Oct 2022 14:49:13 -0700 (PDT)
MIME-Version: 1.0
From:   Bob van der Linden <bobvanderlinden@gmail.com>
Date:   Tue, 18 Oct 2022 23:49:04 +0200
Message-ID: <CALOmz0szcxWw5jdXPSZqYBztg97KAjNJH74usQ0ve7emJFOHLQ@mail.gmail.com>
Subject: Re: [PATCH] completion: support amend and reword in git commit fixup option
To:     Bob van der Linden <bobvanderlinden@gmail.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seemed to have been a flaky test that was failing. All looks good now.
