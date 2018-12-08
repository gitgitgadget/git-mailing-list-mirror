Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D59720A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 00:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLHAt3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 19:49:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32979 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 19:49:29 -0500
Received: by mail-yb1-f193.google.com with SMTP id f125so3096807ybc.0
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CIHZfd/BCDmAvNAJ2WwEKI8Y5Ptumw2ZRRT2RtDJro=;
        b=AHwXhtCXXVNrOqOOIci1nKFKj4Ke+/G2RoseYaNLOVK0VokhiN3BE8HU/wd+EPQA7p
         V4yUH76Po2+W2kmPXHMrvVycbDxpW7aqZhft0xNw6l1QfnmlQZcjdkdVjYQbMXO/Ib27
         cvOCfmlkBrkuq3ngYQ6bdmEqVnN4JSKgOTNKOHII/yhGbgNDjrwFE+xVc0Jr3XAr9llh
         2SRY6uPVHjjHXU/u1DPlGfsbRBbwTmHSyBREca6H+l4DiMc4wfni4kQ3EzB/p0gt2sfI
         zXz5tfMwhUsYY5CShzoprXoYYBtjgpTR+eRp04Rtp4Y2HLJmTFkpEVnSodaBtDJpThhr
         9cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CIHZfd/BCDmAvNAJ2WwEKI8Y5Ptumw2ZRRT2RtDJro=;
        b=hnTUtClT4ur8OxTHH17dC7z2+d23Va5lc6rfToEIkoaqspnLxVHZ9GIeDIF9BaIoNP
         5OLd5LbbgZ2QWxTJRwPDUrPOsKY6RebdUI8cDRjvU0LRwztSnamtofa0lhYD9CE2244d
         yciF8Fu6itMLICW1Zi0egN+b+GfwbDg8YdM1Cbqik2cyQSMOCfBVndviraEXtzQB4E4/
         WxNBStbzlynwo4Ihx32vqbk2QgSuF7dy4hmMqr5chRf9idC4ONncmwAaDFDEakaXeB6f
         W85TTuxlBHmo00TPAC8KwXHIxr6udd6MtD0cAXcZgayn+FfYXeZKWL57s9/1GCqPQ4UX
         9oJA==
X-Gm-Message-State: AA+aEWZTYAkxunW2jp7M1wrYBKF8DpAXiWjdxnLIQ1PtOAZWOKG8Cflq
        JZFx5yJMdIdSqPa9+Q/8keTv97eto0XvIkUKKy4=
X-Google-Smtp-Source: AFSGD/UAfEEeKZaNXcLHsEeO78GUNb2w/Y3mcvXCCtrxl6Vsr86pvb43xb2LaP8j0EPuVzva9HytZ2iaUrC8gbRbEAw=
X-Received: by 2002:a25:8541:: with SMTP id f1-v6mr4456566ybn.506.1544230168037;
 Fri, 07 Dec 2018 16:49:28 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de>
In-Reply-To: <20181207170456.8994-1-tboegi@web.de>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Fri, 7 Dec 2018 18:49:29 -0600
Message-ID: <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 11:04 AM wrote:
> The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
> is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
> in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]
>
> Instead of duplicating the code, it is extracted into compat/mingw-cygwin.[ch]
> Some need for refactoring and cleanup came up in the review, they are adressed
> in a seperate commit.

i have applied the 3 patches against current master, and my original test
passes, so looks good to me.

however like Johannes i take issue with the naming. as he said "mingw-cygwin"
really isnt appropriate. ideally it would be "windows.h", but as that is
conspicuously in use, something like these:

- pc-windows
- pc-win
- win

i disagree with him on using "win32" - that doesnt really make sense, as
obviously you can compile 64-bit Git for Windows. if you wanted to go that route
you would want to use something like:

- windows-api
- win-api
- winapi

further - i disagree with the "DOS" moniker being used at all. DOS is a defunkt
operating system that i dont think Git has *ever* supported, so it doesnt make
sense to be referring to it this way. again, a more approriate name would be
something like "win_drive_prefix".
