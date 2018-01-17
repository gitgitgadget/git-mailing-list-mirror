Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294B71F404
	for <e@80x24.org>; Wed, 17 Jan 2018 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750832AbeAQAVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 19:21:52 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37615 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeAQAVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 19:21:51 -0500
Received: by mail-oi0-f45.google.com with SMTP id e144so11944811oib.4
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RCoj8A+NNlGlqrB5U9XuU6Tco47Vw5HtJiwx8mMP/04=;
        b=rn80M3IwdapoJ5I7du6EHVNWkXl0YVckwajyMLH3YpEbms071yfNrkSwE8ERLMCp57
         l/nv24uk8UWimQCH4nWzxjV0e69FAjunShzMBbTWIybr24nPlV43Wd14n4NiIKTvwj/a
         FcdL/teThAsHOixi2WhvbcNZiAdwKiqFTDkaYgeG79XDAYGCZpfoIK4Bx+vtu3KZ/ugL
         qJaBfc6CTxT1n5tdkA8+oImtL80cfY7cJgEikznSwe9RHwGKLjqHqWTCEqSuSVz+EUyT
         FPDs4Td2ztMQ1uThRXvuKFvzjhJCgzshyQIImLRNn8dFc68EtoIXd41NdmfWgzrjMppe
         O6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RCoj8A+NNlGlqrB5U9XuU6Tco47Vw5HtJiwx8mMP/04=;
        b=YFG6rM8AlqfTMopdv11YhmmqZCGbRwbHExy3OdjszqxsMMB/3nWyOoEGC4i1dYc6By
         CysdGD4hKxurV1QOQ3xR/j+UrNV/e2PF1lTEwTMEJeGum+9DfOmCijtq8j+nEVmu5tdQ
         De+6g0Khhhb/X+k+zwiCpb1wl/NqOTL3UcN4mGkM1RfOo5nMokJLCuUHEX+hALPBC+kT
         nApK9/8Xzj6OCmAfsuFbZqXpv29Ti2ldiOQxKEZIPetHoXOSXhoPNQgmTNP0wLiTamh1
         Q3DZv9ybz0w6dZNv0u2kwWLKwVdu9la7x7RlGKerMWI3QFlxWMG/S/qwn3M2NDVm3oX8
         fdnQ==
X-Gm-Message-State: AKwxytcNI3BZdwqNTRbRSt6PCBLL1ylTsbfmxTNGmps3PWvtBv3T/p34
        nqDKQolFEqwk/IWEvN8M5h1xhLtESPpyVp+tJ9U=
X-Google-Smtp-Source: ACJfBoslBdSPTzIsy8haXIPwyzuafCVfb2qgB3e4xK+xBCtomn0xhglnyFrnaVjRvtLBWwe85u3WydKMhY8nBSylKg0=
X-Received: by 10.202.81.212 with SMTP id f203mr93544oib.117.1516148511440;
 Tue, 16 Jan 2018 16:21:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 16 Jan 2018 16:21:21 -0800 (PST)
In-Reply-To: <CA+P7+xohkxpoBHTVcD5i-=gT_evL5HKhCGLyV0LYyj8YdyLmqg@mail.gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com> <20180116103700.4505-2-pclouds@gmail.com>
 <CA+P7+xohkxpoBHTVcD5i-=gT_evL5HKhCGLyV0LYyj8YdyLmqg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 07:21:21 +0700
Message-ID: <CACsJy8BeODhidfBthT2oDWOzBv8jakpg8=O3yz+wMLhu-tAWzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: support --git-completion-helper
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 1:25 AM, Jacob Keller <jacob.keller@gmail.com> wrot=
e:
> On Tue, Jan 16, 2018 at 2:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> This option is designed to be used by git-completion.bash. For many
>> simple cases, what we do in there is usually
>>
>>     __gitcomp "lots of completion options"
>>
>> which has to be manually updated when a new user-visible option is
>> added. With support from parse-options, we can write
>>
>>     __gitcomp "$(git command --git-completion-helper)"
>>
>> and get that list directly from the parser for free. Dangerous/Unpopular
>> options could be hidden with the new "NO_GITCOMP" flag.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>
> Was this possibly avoided in the past due to being slower than simply
> storing the list in the completion code itself?

At least on linux I would not worry too much about performance (but
then I don't know what platforms this git-completion supports and
whether this may become real performance problems for them).
git-completion.bash already executes some heavy commands (getting refs
for completion for example), though this makes the script call git
much earlier.

There's one thing I will have to be careful about though, that to make
sure that --git-completion-helper runs even if the command itself is
not supposed to run, e.g. calling git-status without a worktree will
fail, but calling 'git status --git-completion-helper' should still
work in that condition.

--=20
Duy
