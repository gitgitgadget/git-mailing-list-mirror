Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F3C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21196109D
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhIACLV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 22:11:21 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:33311 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIACLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:11:15 -0400
Received: by mail-ej1-f50.google.com with SMTP id x11so3346563ejv.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wkHeB3tv/Y0jGghigS2l3ttqPzt3b3t29vul7zwPlnA=;
        b=BVV+CS2xfP/XCqhWQh0xeZ7W+86sLFgqPiJ+RmqtMscLgiHId1XpGBWUET0wiB5KV1
         75caeWHPpQRUR/0khljQ5kBjXz5LaT/6BNyfcCJmXuFK5pXtrxlf0hMJd9EbIw3VQ8sT
         4Vg5rOnKOD0c49WRXeop44WcEDO97/UFBWoLzaQ2BixRp8LWvHC84OUqlaRIM9Fm5BL/
         Yy1/pxhAVg1nZ3tKq+JbnxLyTulRuGeYAx61OKxGv/2C1bY3UC0VP3yR76kv8dUQzI2M
         Vx5bLUYuk7FaUyvsLMybZfEjtBYyuyiCLofj6rK8VK9TIS5ZQ7cOjM3kJKXSmM7b0/ae
         +vng==
X-Gm-Message-State: AOAM5339VitTtFfwpOu5jtrHU9EDNktXDQrO4zi0ip5qU/tfT74ALI7E
        BtoLXjN/3ZyiczQSoYuqwvn+yZnxP2P44lSvkqE7C4cJ
X-Google-Smtp-Source: ABdhPJzzdUZARtLQB6/e/IJCV9i80bRzumWQHNMmLYljULvp40m1i8gVDwxQwmvlX/4xd9sUtSab7JP6o+VgeEz8bGw=
X-Received: by 2002:a17:906:3ed2:: with SMTP id d18mr32777222ejj.311.1630462218817;
 Tue, 31 Aug 2021 19:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
 <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com> <CAPig+cQ1V-sSZzrBwDWZYFEFJY-W8s1aq4igfhg9vPBNdLJusA@mail.gmail.com>
 <xmqqpmtttr56.fsf@gitster.g> <CAPig+cTaJ=xm=K5Y8yn8RiOFHBH-nzhRztYRz3kYsqsyJUTACg@mail.gmail.com>
 <87eea9wdit.fsf@evledraar.gmail.com>
In-Reply-To: <87eea9wdit.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 22:10:08 -0400
Message-ID: <CAPig+cT62CcGW0stAMaK=diMAuWzgmN+y+f-Hjne0UAq91A_Uw@mail.gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jan Judas <snugar.i@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 4:44 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In any case, I was hoping to just send a quick fix-as-a-patch to a tiny
> UX suggestion, and was hoping to not get into the much more subjective
> discussion of how to better reword "git gc"'s error messages in
> general. If that's where this thread is headed I'm afraid I'll need to
> tap out of it :)

Fair enough. I hope that my explicit mention of "bikeshedding" made it
clear that my comments weren't expectations of change but rather "if
you plan to pursue it further, maybe try these ideas".
