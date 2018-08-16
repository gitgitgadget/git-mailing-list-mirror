Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_SPF_TEMPERROR
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668EB1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbeHPNJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 09:09:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHPNJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 09:09:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so1813580pfo.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vq3BPKbvfKhkcY3RDFkpvUJvt0B9u9C49yA+qeMYE9g=;
        b=I8bSYm5eKWBp+qeraGeYtZrS/40Dox2d42iftyb9rf5wlsAAclEkzqCUHi5D4pkkyD
         3NTUfvneHR0woFCbRlzYNLNc/pZj+zVLvpEuqm9Cn16nPJh6roPhyrZX4vlSsr5ImrHY
         1fbZLGGHmu6lCKQUAgKVBCv5JV81wCAAPRPsqtI9TcCLveRX+LO+6Z6Je8YjUL/EnGqr
         Rjui19kXYX6pvIBz0kpMyIV/ZPn8LkpTyyxWo+9F6Vdhhsq6LccynQgbti9zbYbFvq+w
         x+nSSgHc9OolqwtUGTDkQSL7Ywnqw9szUen2sS4tci0DG/vx3JtMrZ5+Cc4+ZQv3ws8j
         AiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vq3BPKbvfKhkcY3RDFkpvUJvt0B9u9C49yA+qeMYE9g=;
        b=CQ/omtnpdpFDFnMQvceD3PosmT9u98pqe02oWlea0NA68ZEp/fhdI/GujC+1nu58OW
         Rp9Ix57A8p21nZmwlyVlNQ8M/31O4SZ8wkL/WBBBe0fZs/uUbG0lC4W/+UXfcHgrvbnb
         xLZXDUmYD1ci4g7Ugm7lCoK6CyIGg4S3PhhzXhK/BT11Yp5d0GXcvGFMxMtG9D/1H9O5
         NlHltdr0/Qfo879YNLr/QUVoRjWgZg5bdCMW1RvqYtdaBLSnwYwL/pfgOz5MmSA9qXKL
         0PzQN/NY9SCRzMYnPHAkC+eVes54bd/kJun/U8FJl3M2ZD4ILs3uCpM15FUPvPMG5SYV
         QMWA==
X-Gm-Message-State: AOUpUlEWHMvULsrDgQ7NvpNPj7xmcsjzyUzWCOndjNdcWri311tTvzSx
        /be2ZqJ5B2yO8HvcGLZiQtjs4MlWYLYYTUuB9pU=
X-Google-Smtp-Source: AA+uWPxl47WN83TNzK9wPvrzpVYz80ZdPKSkSzT5v34VNixhA5tKxPEmEeoiimBBN299MGeETXzQ9Wp3DBM8vV5kNjU=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr31766248pfx.49.1534414334790;
 Thu, 16 Aug 2018 03:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
 <CAN0heSrZXjaQ0H1J1Mmqhv9qhiNbRn4fOJ4oO1XrZFEGO4YFug@mail.gmail.com> <CAPig+cR3g8MUt6VAg0RrO3VBgZ4ChsXz1t75xHgT5Q_9_hRzBQ@mail.gmail.com>
In-Reply-To: <CAPig+cR3g8MUt6VAg0RrO3VBgZ4ChsXz1t75xHgT5Q_9_hRzBQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 16 Aug 2018 12:11:59 +0200
Message-ID: <CAN0heSotUQf=q_uOXr5qP64ATQT6wnB_0XAmUPoastJw3asJ=A@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add --quiet option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, karen@codesynthesis.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 16 Aug 2018 at 10:25, Eric Sunshine <sunshine@sunshineco.com> wrote:
> (/me nudges Martin off the fence onto the side of not bothering to
> mention the obvious)

:-)

Thanks for sanity-checking my thoughts. I agree with everything you
wrote in your reply (and, FWIW, your other findings that you sent
separately).

Martin
