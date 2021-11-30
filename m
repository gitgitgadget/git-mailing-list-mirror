Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD8C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbhK3WNn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 30 Nov 2021 17:13:43 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:43802 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbhK3WNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:13:31 -0500
Received: by mail-pl1-f180.google.com with SMTP id m24so16053643pls.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjtrOrTUwyddpM5bVJ88xzb520X9/tPbi1dPJ3RSNJo=;
        b=m1MfgYYJQlyhKjeXy6sgvBKKzblXfPhdveOsJOUGj8Bog1BUZiQh1X0hXwHgcR+DnK
         5HM1lIJbJoX2d0pDU9At4X9zpQLeXxDnOCPZ/IC+TaLOoXR+VpTtz/dnFhrnQAJzQbv0
         fJoc4lxjvGR4limMN1Yvu63gy6oCs0ka/s9o8ACFBAYV6x/r+ewCdBfxtTWmyNOAcKz0
         l/qVIFTtb3xRGnqxludYZTyup5VjcLwlUbodSYPhfaRMN4+aV9J3ujGMetPzwX5xbED0
         4PmUfRajbAjoYyDbYxm3TZwLNMB/X7TQp9H38Wu5DfGkvVFr+FG2A6Kc9dd0JXwbiX3W
         rNrw==
X-Gm-Message-State: AOAM5327lU5fw6AUXshSLV/vaafix2MGA/uR9hJ5G7U5xY2fsF2+yvAf
        mXLDZHeEaF7WOA6nrAvPvQq478lrXIv4mMhPBdA=
X-Google-Smtp-Source: ABdhPJx0Fs8uQzKGrVlhaWrYupD0FhJAD9+AeAsZdmxVJ2qss12PfJgTI9ZHopwaSNOyBlc0wijQMcYDLZDRyo+/Cto=
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr2272340pjb.150.1638310209489;
 Tue, 30 Nov 2021 14:10:09 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g> <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
In-Reply-To: <211130.86k0gpcpy2.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Nov 2021 17:09:58 -0500
Message-ID: <CAPig+cSvFgJTiq8pXrWy_7ukQwE1y9ZGwMgKmyjWuQHdNGxiDQ@mail.gmail.com>
Subject: Re: ab/run-command + em/missing-pager (was: What's cooking in git.git
 (Nov 2021, #07; Mon, 29))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 4:07 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Nov 29 2021, Junio C Hamano wrote:
> > * ab/run-command (2021-11-25) 9 commits
> >  - worktree: stop being overly intimate with run_command() internals
>
> I think the only outstanding thing for this topic is Eric's [1] comment
> (on his own code). I think that variable shadowing is OK.
>
> 1. https://lore.kernel.org/git/CAPig+cRi6SeuV7k_+9JCcnf79daLZp5B=EyHK-KxC1VGN0B4ig@mail.gmail.com/

I'm also fine with the variable shadowing and don't consider it an
outstanding issue with the topic (it was just a minor observation in
case anyone complained). I didn't see anything else worth commenting
on in the remainder of the series.
