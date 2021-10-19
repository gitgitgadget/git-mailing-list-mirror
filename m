Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5446C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 04:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FD461074
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 04:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhJSEjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 00:39:14 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35532 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSEjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 00:39:14 -0400
Received: by mail-ed1-f49.google.com with SMTP id w19so7580248edd.2
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 21:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTMWUKl+qemk6SZEC1Rub4EiwBuZmVdyKHAxf1j5QYw=;
        b=rFdMhxRpCqTDBnD01GHfTThlvPPhS/sKFTuHedwq+3hEq/UBol7j9mMtmgLy1WGSMt
         xd0s5fEcgYj+G91FNvYMv88a+c7jdBdbn2aWnj6oTsE2SSc8h7VQrEnS1PYPPWOsAabq
         GY387a78S2F/0bwcRkz0yS7HuFvpgBwRTbQ112hpfNeTCa5aFfme8npwWuv9P+9Uz6I/
         iOC2n3ktK4YMYj3y5Ci1Wtup4YxTl+rwut/kNGHqABVlVO5W/Txrfixf4Zq/wV76tOVg
         7BGb4Sqmvr1gW+m91YVcUjVKuGfCpEgz224e0eRFUoMxBZfb2otWIFWyzyuqIYlh2Rsd
         ZYDA==
X-Gm-Message-State: AOAM532ZGF3zxmECopJgC6N3KIv/E4b9C2M5l8B1mu2TkbQmhgZOLvTW
        Ioym66uZC/4z88Zlfns/+o6GRISafHHop4xaLnW93Hr/fUA=
X-Google-Smtp-Source: ABdhPJxaHS5zFZAmCtc/sc8JtB51dqnidtkFNHbeMEtuJSTx8s0QXydspLs+/chU682afw5rqfm3SmFUj+58eqb35gM=
X-Received: by 2002:a05:6402:1d49:: with SMTP id dz9mr49693275edb.55.1634618221245;
 Mon, 18 Oct 2021 21:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211018124106.542050-1-bagasdotme@gmail.com> <xmqqzgr6w97p.fsf@gitster.g>
 <kl6lzgr6z1a1.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqwnmaumcz.fsf_-_@gitster.g>
In-Reply-To: <xmqqwnmaumcz.fsf_-_@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Oct 2021 00:36:50 -0400
Message-ID: <CAPig+cQU_TF-MbOv-PaE-0L5dEa_rgDXptOLAu+JOAn=RuJCqg@mail.gmail.com>
Subject: Re: Re* [PATCH v3] Documentation: specify base point when generating
 MyFirstContribution patchset
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] MyFirstContribution: teach to use "format-patch --base=auto"
>
> Let's encourage first-time contributors to tell us what commit they
> based their work with the format-patch invocation.  As the example
> already forks from origin/master and by branch.autosetupmerge by

I think you meant: s/and by/and/

> default records the upstream when the psuh branch was created, we
> can use --base=auto for this.  Also, mention the readers that the

s/the readers/to readers/

> range of commits can simply be given with `@{u}` if they are on the
> `psuh` branch already.
>
> As we are getting one more option on the command line, and spending
> one paragraph each to explain them, let's reformat that part of the
> description as a bulletted list.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
