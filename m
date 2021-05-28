Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746EC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7282F613BA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhE1FK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 01:10:29 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37677 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhE1FK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 01:10:28 -0400
Received: by mail-ed1-f50.google.com with SMTP id g7so3391175edm.4
        for <git@vger.kernel.org>; Thu, 27 May 2021 22:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfpU9TQZ6EFGswMD7J0dlphxgelrN8xd55HAHGjYL0s=;
        b=oD7z/8viXmKqgDQf9i65CdQ9JS73jIUBk5WcF3sdKv51zceafNEKIlmvnOiRhnn9/N
         K2cfVAYXlTrBMrHhvggT5hYFvWunkdELTBiYFo36iJ2aWpYt6E4NifK6Gr5eUaJJEfqM
         Gq8OCRcV4tfSs8A3ubneUrJxsjh55atlmYvbB4tGylD2sGkdHEy4bUC7FFrkiE0RuiFx
         oWy+h3Du7sR50CO2Jg2encXZQ7aJB+1tCN8uaqFSyEMNYcWnirZCNVp70Un6kZe2C2Kd
         WrsJwRjNkWv3TNBDVOT+P3ynelvnZOae2jtxcYr4qQBNjVi9fIzWw9ifdcJwz7AsEJ9U
         l/YA==
X-Gm-Message-State: AOAM533Vyo3+GVeTIWFyABc8qCfiIs37T79pfo9OYo8+1ykpjR/FJxYs
        qyZjFAiY9QbYRRZcd9x6lpBDhoP7D2mUvmIrJP4L101FYJ8=
X-Google-Smtp-Source: ABdhPJwTvKIE+7GYpu96OQXMwM2Xr6HfuZEh0lt6Gp3OQ6+wJQA7Z4mvJpN7O1P1a+3GVsDV/NaHMtlUc4wsxGNa90I=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr7999161eds.291.1622178532207;
 Thu, 27 May 2021 22:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGua8U25GF=mC+vRARRY99ZgaHoUOA7vppmOUdWoeB=bf3NAA@mail.gmail.com>
 <xmqqlf7z78sb.fsf@gitster.g>
In-Reply-To: <xmqqlf7z78sb.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 May 2021 01:08:41 -0400
Message-ID: <CAPig+cT6ztfUYjbsfFmYZ=UOcyk=9rFKqEuE=EE4y2rdBftGag@mail.gmail.com>
Subject: Re: git rm --pathspec-from-file does not work in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dietrich Epp <depp@moria.us>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:07 AM Junio C Hamano <gitster@pobox.com> wrote:
> I wonder if the attached patch would make both issues better.

The "attached patch" is missing.
