Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489AC64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 07:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBVHJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 02:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBVHJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 02:09:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C82A99A
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:09:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec43so25955813edb.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ojsDRgKPFjzx51nwTtwLz42ytl2FeIdQHfougWRwHc=;
        b=HjeXiDszrXuxD/O/EzBAbXmcQUQe3HT6JlUjUarJndXAseE0pxWvUn/ObF7dEY5C96
         t8kpGVDIyaq8AA1NeXRJH4fD/kPMmeSRa5Nz37s5uHvmKr/WDBpRJfN1PJYyo/JWkYTZ
         wUL6W4kBWi4MDOAwq9WBQmiseuGMxyZmAO3r9nsmxnl05tWOOdm1jDJUeRErNUBV0vNR
         9RqMwP4JuYqrhDC2EKKtZ3obdK4jjHWCR14Pzuk3uvHlnapzRUOW4Ry0O5bx3dg+HnFR
         C2aVFRg6xfyfn/UIHjRCWM292T5CVU6lbJsDSRIOSdxmQUJCidEFNlXv4evDpauJAdz3
         TXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ojsDRgKPFjzx51nwTtwLz42ytl2FeIdQHfougWRwHc=;
        b=JqjJYPTeE6l2K5b3U/gGG9AtGAxSV+oFTfoK7ypHX4G+R2sU2U0pCgPbEdtSWS2am6
         NBn6DvGjaIJCbcCNleijNfxqqycUVXRVNAPj6bgIjV/7clrvStyeCtGRdU4I9MurIGoq
         Ob+btbq5cnX6w6v3Rbc2utWPYEz8i8gwyjZGpzOt5H7DUhm7h5WefeE85IMlvkj1/o98
         hlTX592XL3qQeWFkRkOVQJYrsfxw9Ph0NbLy/8/hJ87mkSlOBAArU+ukUuMDyyukwny2
         CXpJ0DhAdCNeEzZDsRQq3OHIbCvnqThZrlWwO+MfKklqaj7RndahS/D+voEBblff8QYU
         3Nrg==
X-Gm-Message-State: AO0yUKUX8QVXVd+AMIqWULglhfVltfqZZ70FGTnbptZUJIBVIWMqLGvD
        5GmO1UWXLL2qrd8MkjShT8CCEynn9MzIM5C+atQ2DBLXVMCp9A==
X-Google-Smtp-Source: AK7set+ZY02QuSjwxzSH0xQAGfCE/FIdzAix+9UHzC2msliFd/Z2TIVviKPOxiy3XVFAvQTHit9yJY/ss9VF6uPWl0E=
X-Received: by 2002:a17:906:e0cb:b0:877:7480:c561 with SMTP id
 gl11-20020a170906e0cb00b008777480c561mr7008666ejb.1.1677049764946; Tue, 21
 Feb 2023 23:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20230222040745.1511205-1-18994118902@163.com>
In-Reply-To: <20230222040745.1511205-1-18994118902@163.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Wed, 22 Feb 2023 00:09:13 -0700
Message-ID: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
Subject: Re: [GSOC] [PATCH v1 0/2] Modernize t9700 test script
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zhang Yi,

> Subject: [GSOC] [PATCH v1 0/2] Modernize t9700 test script

It is the convention here to start the subject line with the name of the
component you're working on, and it's always good to follow the
convention. Something like:

t9700: modernize test style

Note that the part after the colon should start with a lowercase letter.

> A title in the test script is in old style an a body is indented by spaces.I fix the title style and change indents to TAB.
>
> Zhang Yi (2):
>   Fix title style
>   Change indents  to TAB
>
>  t/t9700-perl-git.sh | 61 ++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> --
> 2.29.0-rc0
>
