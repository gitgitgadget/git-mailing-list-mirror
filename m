Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28FC1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeGPTJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:09:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43417 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPTJN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:09:13 -0400
Received: by mail-yb0-f195.google.com with SMTP id x10-v6so15815508ybl.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN4vr7v3g4lYnqKmBB+XVDQ/DicMwEnVvTafb8uRix0=;
        b=msY3H74K1olvKzpuhPvU1DQrNKbixK5D5hIO1213rXOINJPafXPF2AJqW/q9TqHo1U
         Ot3C4fyEXxi9+smGI2zI2jeLiLARxnXI6BgqRCfX6De+uCl7tI/a7cpCXPcr85czzPDV
         s5sfphgU02bsE9Qz38ng0rmcV/+9WdS3xbbGgenfNy17YGvu3KOLSRZzovB91mJVh+24
         bZ1wBJOC1g1ofSaUbaglWliWs+exIVETyCvSVO8jYn823SZnTPLrgvM+rOsOYY3rrbOQ
         Y7B/RF+7YzpcT9jbGLOnUTpMnmkoKbERP7wYfXQTKpum9qEgm5j//4nmkidCjHkBJfZ2
         3PGA==
X-Gm-Message-State: AOUpUlFu99H5xbDBvrubJZIDNvt7ZOblfbQzybXKQXoQA+DrqoOzM8Es
        h0tZyioo6z5j9k7YroqrpgBUSZ+o4bJ1H037wcE=
X-Google-Smtp-Source: AAOMgpf+YbCKBXNayS2V/nUcg809DVwsL5zQJKuH3W/yxaiVCMmBhLp10J70J/fsss6VaY9pxVMYHYRMFd+wfoWXJU4=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr9081106ybq.295.1531766432811;
 Mon, 16 Jul 2018 11:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <20180716161821.GB18150@sigill.intra.peff.net>
In-Reply-To: <20180716161821.GB18150@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 14:40:21 -0400
Message-ID: <CAPig+cTVP2kubTEZBms_x1FvnqjGcX3pjTRXfjBMfMtdpbJt=Q@mail.gmail.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:18 PM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 02:54:38PM +0100, Ramsay Jones wrote:
> > This is not your problem, but I find these GitGitGadget
> > submissions somewhat annoying. This series has been spewed
> > all over my in-box in, what I assume, is commit date order.
> >
> > So, patches #4,5 dated 19/06, then #1,2,3 dated 25/06,
> > then #15 dated 28/06, then #6,7 dated 12/07, then #8-16
> > dated 13/07, then 00/16 dated today.
>
> Yeah, they're out of order in mutt's threaded display. And the
> back-dating means there's a much higher chance of them getting blocked
> as spam (e.g., some of the dates are from weeks ago).
>
> git-send-email uses the current time minus an offset, and then
> monotonically increases for each patch:

Junio pointed this out to gitgitgadget developers in [1], which led to
an issue being opened[2]. That issue was merged today.

[1]: https://public-inbox.org/git/xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com/
[2]: https://github.com/gitgitgadget/gitgitgadget/pull/15
