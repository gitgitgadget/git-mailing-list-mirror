Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D7C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 06:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBZGjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 01:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZGjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 01:39:13 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824FF2691
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 22:39:12 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h31so1826594pgl.6
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6/pZ8xXf5vhuDz3XaGG8TXvmGkV3tTDLU7WHgLDmUo=;
        b=iJs/jf1YHvA4Gb0/RURjY/36z3c1R2lCZEBbzbsc/+BzCou8vxDknAXXQanbyoeoHU
         dmQkM8djEJ9PWDEms01bzrspOQhem8RTISZAPalXKhi3Ms0fk3lWJ7nDM8pksDL6OLqE
         68qJ1E1g0U1w+M++mwGDaJB45l3pC9KFoZChKRcPtB4cUVD2vWDM0wfpS4Ueya60elAF
         /r0FTtNMobjNtM5Kx4g8ym2zz0lVy5Kqd9U9u3ewOgsXcc4Dv9VNpXt134odwnrAEJ1+
         om1iUfhsL+Gy0IlHhRR8WzKTpw09DrpMJanheaYK4Se5oP2LD34hzEbRsLme3QwaF9nG
         k5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6/pZ8xXf5vhuDz3XaGG8TXvmGkV3tTDLU7WHgLDmUo=;
        b=uRrdBjIuPCbHDDqR7lF+RbjUwiqZKcllfDRctyK/jcAsXSzpe0ahumbrEmENLXq9hg
         7VPRtZhK9Fcmum8flUQF+uPDTXjNq9FvW0Tox3eFmvpWKKvKDBZ2ckPFJfcJ8ERQLbHV
         W4/gGH7zcxcCUyZ953j9SlB/LVctBnT9DpcoL9Z31tOuSZ0+lix/REtpCWRwp9XX6WDM
         3ViprmQfTQDk6rqjXig4zuINnT/iPqDOsFmRH4y8N3iAAUBbYIjMBtaCEUy0tQO/ZZfE
         VOM+K20MbuyuPWVgDmcV1PEtZ9dAI+Qwp5oLIzQ5TDg9hmeTkzpmjQ5fYtgQLuxxZ1HT
         x+zQ==
X-Gm-Message-State: AO0yUKWfUp3ZNYocbfqnox5jETAyM+/1RdD1S9pViHK4CpazDALb2CS4
        gVcjEkeQAXVaKjbp6enRICsTtEaZCbpnqeTC7LHm5+pF6WeWoTgo
X-Google-Smtp-Source: AK7set/5futv8ZrKou7SANAmWe2rsYldo/PYxbMQMQS4R12LnPk0zvcM9vgRJS78TRkEEEct3a2nJq5VRExjfDhn4As=
X-Received: by 2002:a62:870a:0:b0:596:78f:1532 with SMTP id
 i10-20020a62870a000000b00596078f1532mr4680597pfe.2.1677393551647; Sat, 25 Feb
 2023 22:39:11 -0800 (PST)
MIME-Version: 1.0
From:   Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
Date:   Sun, 26 Feb 2023 12:08:59 +0530
Message-ID: <CACmM78S=t1ebgohykNwRgixj6mQLG=FCOvBttO8NCL1OC7-=WA@mail.gmail.com>
Subject: [GSoC][RFC]:TODO test in t7012
To:     git@vger.kernel.org
Cc:     git@drmicha.warpmail.net, pclouds@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was going through the codebase and found these tests which
are marked as TODO are these tests still needed or relevant?
If they are any ideas on how should I go about implementing them?

#TODO test_expect_failure 'git-apply adds file' false
#TODO test_expect_failure 'git-apply updates file' false
#TODO test_expect_failure 'git-apply removes file' false
#TODO test_expect_failure 'git-mv to skip-worktree' false
#TODO test_expect_failure 'git-mv from skip-worktree' false
#TODO test_expect_failure 'git-checkout' false

So far I found this discussion
(https://groups.google.com/g/git-users/c/ajdqGuOK-LM)
that seems relevant to these test cases.

Any advice would be much appreciated.
