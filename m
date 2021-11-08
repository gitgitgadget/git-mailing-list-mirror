Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50DC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41AC6139E
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 00:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhKHATA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:19:00 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39507 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhKHAS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 19:18:59 -0500
Received: by mail-ed1-f53.google.com with SMTP id r12so55636592edt.6
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 16:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4lhBIrrvf1La5qrUj9aXtVMU00/9H1Qev29NXQl2Z0=;
        b=qGHU91zeoSEA9BsuNIJfQ3xiVU+5Fc6qPj5JepPwgYZDVtfRPe69v3XyDVfmFSJR2C
         TN6eIQaG/PTRTryNgAPh1j+EjeJx4nRdtdKoUU/WNos4JHi+81LXh8LYEZGofPPtNx8k
         UugO/PkpEeaknjm3FKVZ9nQhCkEKnq2VXa5FM0ueSGGV+9ISMiEvmqZ7JazDiRrbLHAJ
         aRsUY6TPvTmewzXciEZHnnTbhqH2I4GMkvfrgfOfyySZ2ClEQ7iFHHmqTQWXZTGxwQYP
         yFLx0GqO5eAo74NOyNiFD+xsBmbOzBcrZ8v8jrYK6+uiwAxsL6Y4csxPMuVwuQn0OtlI
         15ag==
X-Gm-Message-State: AOAM533WYH2Xr98iXd7tVnRZxCDVHotNsWgDLF2eDnLQtYobba96C8gT
        7EyGrzIJJVjw7vrLgS3JA5VxhkNwO0BBrMLXFtI=
X-Google-Smtp-Source: ABdhPJysVUkHjruY/ShHsSel+/ySSrVSNecO0+DAHbeht4puIfl2G6V5iyzl1AQ5cTftGhZ5cQbBmm6L1zStZzUUBP8=
X-Received: by 2002:a50:fe0b:: with SMTP id f11mr93652567edt.231.1636330575017;
 Sun, 07 Nov 2021 16:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
In-Reply-To: <20211107225525.431138-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 19:16:04 -0500
Message-ID: <CAPig+cTWwmVFggD2UL=Ddd3rc007zRWcRs7nQtEHSS5kgjx4og@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Additional FAQ entries
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 5:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This series introduces some additional Git FAQ entries on various
> topics.  They are all things I've seen in my professional life or on
> Stack Overflow, so I've written documentation.
>
> Changes from v1:
> * Drop the monorepo patch for now; I want to revise it further.
> * Reorder the working tree patch to place more warnings up front.
> * Mention core.gitproxy and socat.
> * Rephrase text in the EOL entry to read correctly and be easier to
>   understand.
> * Improve the commit message for the working tree FAQ entry to make it
>   clearer that users wish to transfer uncommitted changes.

Thanks for re-rolling. FAQ entries are, of course, bikeshedding
fodder, so I left a number of bikeshedding comments and pointed out
one minor typo. Whether any of the comments warrant a re-roll or are
even worth discussing is a matter of opinion, and they could certainly
all be addressed later (by someone) atop the current series if
desired; I don't think any of the comments were blockers.
