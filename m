Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE5820248
	for <e@80x24.org>; Thu,  7 Mar 2019 07:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCGHh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 02:37:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 02:37:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so10794814pfd.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 23:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISRQ7h3woP1gCDDkySe0C+XsdLPjbEyinIBVNLw250o=;
        b=F/0X6qrn7+QK9LAikpFMW/ZGcgsBMr8ihckmebH1/sNXVBi4v2MSSmC1W1D2pHbT0h
         zpIm3pdIwAzt/hvbS9Gu7oqW4C7hr1Z0A8BR4nHRYAWXuBbwawuZfRUPvNOSQBeDSvXz
         4ehdCgHG6zxvwoz+i/1Beo5fLP+7w1iNj8F9nzNgjFi+GeWlgyGK2ryPiFmSW/zjOTnu
         QfPMoqHrVzSYZRIyMs4yXuFp9d+4cjScpdVWGolSIhE3dMUHWO3Z7PJrNrWFFR7FdPtE
         kmJ9pviYwWrz7Sbr38hd6gxN7S5rux70D7BaQ5ul1x/lNESpodOc+DJZL0NY+zJIfcsm
         abGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISRQ7h3woP1gCDDkySe0C+XsdLPjbEyinIBVNLw250o=;
        b=Vn/zGZ643dR0S1xsME6RfYFGGLE6MzDX+oFAhyo+aQLN1pQdhgck7MasvtStrVx6cd
         /fLaasZjehR/Uk5iCj8LUErLB0bEyHX0KT/gpiJ0Z4BGGlEORCl9dvWRfsH91AUd8s+l
         O2GQpyHouUHxlVVtEr5d0kgDTcTr73MmcRCwTdwb7myiVTmTsdfvAVzvWagKZfaJaNYZ
         xV0Wv98qGP+yPziry3zNW5tZyumWn5WL+ihq5b0GTuHtv75QwIf9MNLefZyWxzVNVMxJ
         94aOrJIU8ACOP40tfqBe1dVT+1E6EUsiWTG4wk43A3oohY2Bqs/10gp2pnToEXrQ+MB5
         pVLw==
X-Gm-Message-State: APjAAAXSWd0bpNMAIPYr68aRuOS0Hw9w37xDmgkK4lfV0VG1LRWaTi1K
        ntccSgb0e+KXx8yVqpDz4zTP/kuSDz5eZ59oCYE=
X-Google-Smtp-Source: APXvYqxRLG4UwAwdtrFXyFh1i+ae+OSrw8s5mmB+6lKbBqNl//y08ipwirwtaEi3doMLXpaidTC7+Ua1SuQybMo2wJk=
X-Received: by 2002:a63:4f58:: with SMTP id p24mr10193986pgl.283.1551944277308;
 Wed, 06 Mar 2019 23:37:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551868745.git.liu.denton@gmail.com> <cover.1551938421.git.liu.denton@gmail.com>
 <2eda83517ebad39e14dca9d86b9dc2e0d32e37ef.1551938421.git.liu.denton@gmail.com>
 <xmqqlg1rmati.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg1rmati.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 7 Mar 2019 08:37:44 +0100
Message-ID: <CAN0heSrGT1SBt=w8j8G0nnWXDOrn+VYFuk2iPWH9uk22fqzFKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git-clean.txt: clarify ignore pattern files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Mar 2019 at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> Denton Liu <liu.denton@gmail.com> writes:
>
> > +     Use the exclude pattern in addition to those found in
> > +     `.gitignore` and similar files (see linkgit:gitignore[5]).

> I do agree with the direction to abandon the attempt to be
> exhaustive, which has failed us and will fail.  I am not sure if
> ".gitignore and similar files" is a good phrasing, though.
>
>     Don't use the standard ignored rules (see linkgit:gitignore[5]),
>     but use the ignore rules given with `-e` options from the
>     command line.
>
> perhaps?  I dunno.

Yeah, I like "the standard ignore rules" more than my original
suggestion. Hmm, I now see you wrote "the standard ignore/D/ rules" -- I
believe that's a typo.

Martin
