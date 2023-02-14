Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91801C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBNWkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNWkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:40:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F5305C5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:40:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gd1so5713893pjb.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lSk8ABNz1vMfgrv5QJ06EDBRS7ytha6BKY201TXXRA=;
        b=aJYJk7IgE9KIPDHsZO0G4UbfliDtsgxtuVUF2A6NU7XigjV8RM+Fan0z1KFhbi6a8o
         BpVEzj6kBsKjTjDI4CavmYaWXoSEM+qI2igcnMzRzqQFQ6ejuKpw0H1jigPwJmY54aT7
         DF6UW8iSj5U6CTYPU491iWe6RYUfj/+/4sHoXbTrOsa43YtHyypohrkyVfHSiHqvraEf
         GjfsX8Qv1vpW8s0Lkz7IUourkMcVcCb4RIUolUwlmShuCCcaCh++mSXwr09qxSjxOr4l
         afR6x8iE34t/um3zB1hN3TDaxMFhshcm6HUD49OXhzCJsI4ztGIZ6v0Pd06AfG2zzvLL
         KjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lSk8ABNz1vMfgrv5QJ06EDBRS7ytha6BKY201TXXRA=;
        b=KC5geTHx28t/P5Pxf+DfdoP7RU5ylWNnWwidkZDyynobQzrnfS2a4K8z2bXBG5dsZM
         WCu9JCOxCoJRpmGo1EXDo9me/uV0fCvt+x59qNljyq+lOK9UrbEAkgkTE25jiyp4Fh5h
         NkrXQxUASrvj/fVbGhA7v2mizIpUBKrUchDnxTt0p3sYTupjIGCInH5dvZBlzCzbZc3x
         sIYH4qsYMqRQT78x0LOyCuUfh4lP4HTYnVSuL9osyivj943n9nf7zdqqYQlqzkxRkBF8
         xtuIzDXepTPSik59IDhxByKdR8AcWFWrsX29ntVuHbB+rPrVMjFLB7IC/1Xt4Eus8rb7
         5dyA==
X-Gm-Message-State: AO0yUKXSO38YTPlXR2toBq2FOx/gCFvTvXvUd9mgDPBpvj6gkpENmot+
        ucET+KNi5zR1NWjvX1uC0pjvjiz2w7ceQBK/n307gAyBtKA=
X-Google-Smtp-Source: AK7set+f1caZFSh+YgH2hueoMTjbGA/hfYZbT/nSBAvkFkw7p/oUkdOOJGWimYETMu4UfjiZYDxVbMuacv7RJZEcRI0=
X-Received: by 2002:a17:903:234c:b0:199:4362:93f1 with SMTP id
 c12-20020a170903234c00b00199436293f1mr67389plh.8.1676414404773; Tue, 14 Feb
 2023 14:40:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFySSZBMtLSmGHrqb2KQ+QLZXGKQgQx=p+xAmYxE-oTzrYD9+Q@mail.gmail.com>
In-Reply-To: <CAFySSZBMtLSmGHrqb2KQ+QLZXGKQgQx=p+xAmYxE-oTzrYD9+Q@mail.gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 14 Feb 2023 22:39:29 +0000
Message-ID: <CAGJzqskPCy7n2nvu_eFq=Xa19JSSoMADCcy4JVumGiaAff0nSg@mail.gmail.com>
Subject: Re: Join us for Review Club!
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mirth.hickford@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Feb 2023 at 20:44, Calvin Wan <calvinwan@google.com> wrote:
>
> Hi everyone!
>
> Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
> You can find more info at [1] and on gitcal [2]. We run a session every
> other week, and you can find the full schedule on gitcal.
>
> This week, we'll be discussing Mirth Hickford's new attribute flag for
> git-credentials [3]. Let me know if you're interested and would
> like to join (off-list is fine), and I'll send you an invite :)
>
> See you there!
>
> [1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
> [2] http://tinyurl.com/gitcal
> [3] https://lore.kernel.org/all/pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com/

Thanks Calvin for the invitation. I'd love to join, but 10pm here is
past my bedtime. Send me the link, I'll join if I can, or at least add
some background to the doc.
