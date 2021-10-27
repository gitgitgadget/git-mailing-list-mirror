Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3889C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E26F610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhJ0UK5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Oct 2021 16:10:57 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38694 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbhJ0UK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:10:56 -0400
Received: by mail-ed1-f51.google.com with SMTP id r4so14721324edi.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8DqBkWo52m33pYn5QrJiKJn5wBnWHu4L2HrAg1i/dL0=;
        b=gLkkibNis6t2V/oe4UFKdM+Jxu9lswWeC1azzpdnZp9Yj1VoBmY9lGuh8rCp8J0gSZ
         tCqkeKDWyxeUakGyrdp3oiIvKpuajYoxxKNrIyeAthqKIKS0C0MzUrf2+TP9Sq3K5/uB
         GlRKbQJiktGtB1j6NEycPeyvcfmxoEIahAjBHJYS6kLzuKJMwNLKXpQNEz0l5Kd6rbmY
         3tAKphXmKyWP3eE42m0k6SDntxBSlU0KpHl28ZEtCyH3Sv0ajyXAtz3B7AjBhSIDtsoT
         B6a+CTwpOiX0ayncShDMZTJh7Ng/vWe55rGpSBp86aKKyOwSsm9llcaT7xd+hWMr+AaS
         CkMA==
X-Gm-Message-State: AOAM533rF8JdQvShI4G7Ipfe/UZ7N/5fMSFQCf7Z8Y6iFpdtYD7IRsQS
        8gJ0MTe+msIXSC4lfuoSGVC7k24eakDMvTMpp4COgQ5B
X-Google-Smtp-Source: ABdhPJw4ADEYiS3uNWS5PZchzviCmoUcXXMf3mapSC3uJ7D7ZcM6jYd0ihj2Hf3Ea+errE3A/1LcHCl0uEwTGnH9w0E=
X-Received: by 2002:a17:907:7244:: with SMTP id ds4mr26871001ejc.392.1635365309220;
 Wed, 27 Oct 2021 13:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com> <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com>
In-Reply-To: <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Oct 2021 16:08:18 -0400
Message-ID: <CAPig+cRUz1x7v=CRseWrLiN2nHX-sE=pMeMH1gqW0z5ZZTt0kw@mail.gmail.com>
Subject: Re: [PATCH] doc: fix grammar rules in commands'syntax
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 2:56 PM Martin Ågren <martin.agren@gmail.com> wrote:
> On Tue, 26 Oct 2021 at 21:35, Jean-Noël Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > -<CVS_module>::
> > +<CVS-module>::
> >         The CVS module you want to import. Relative to <CVSROOT>.
>
> Here's another "<CVSROOT>".

This one might need a bit of special consideration. Not only is
`<CVSROOT>` an argument to the `-d` option, but CVSROOT is also an
environment variable (which can be overridden by `-d`). So, perhaps
this particular instance ought to be simply `CVSROOT` (with the
backticks).
