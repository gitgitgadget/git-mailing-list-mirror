Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD90320A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 03:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLLDrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 22:47:53 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38174 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLDrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 22:47:52 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so5963441uaa.5
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 19:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbJrbIQ1Q6KKdMya1/Bq/faNghmzz2eLIwpydt4ZfbY=;
        b=ZHyf7t6QEIqAHg3n9dAGGd6qtT95VxPxZdHYJ7DL28kG71mdTWHtcvXXSwc8L6/C63
         ttS2UkX3p8pFu6Rb453RNLLgRjKCRtJcYfFONtxN4cx76sZYs/xGcmOdP33Obc86+JmX
         HSdYPx+nuIb2SN498FWfHqyrOEV/0/jBu3zI4QqtH3WeSNeKX62+QM5UWoEIcTpX2YI8
         00LWgHPnHcz5qw01Lc35ht0aWT4y332hEXS0j8lmHdH7lWh83ekSvQnxkIWLX+zT8PDY
         lY1RhdnIdKpJtOK8PajXx6wfSAghfz4msavncu09T5CSUBKLydDvjJs3bvbbFFJwgmpw
         foJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbJrbIQ1Q6KKdMya1/Bq/faNghmzz2eLIwpydt4ZfbY=;
        b=eGfnwNLItTgqmoW6/zcSfcH8pJAxG+C+ir+t7efTr+2vYeWxvkxrK4I96k7C5JV1bf
         yynBFZTdVy+JE3Eg+/jz+OXXbNelZYKw6TWt89zGLp7fN+WdLb0vNojbLRuuuaRhLZIO
         ADKjug8e509E3lOFuqvXxS1pBNrkgxCMbLqH1MiPcDjsSZtVXOVHDfni2rhGV/RWpjD6
         +RMrSfmRf7TIYMPFg17DTqjjYIdQCfTOWgBg04WV4bXFdvZC8uZ6ifgRECSlssa/C2MT
         47g1cL9GJNFuE/a0XnD9AhNx3lcsFJYID7pIwis5aTBSHaKO7XCUnlF1+/1HciqmgBJf
         ONSA==
X-Gm-Message-State: AA+aEWbcDXPNB7kIqIeeMoD2sGZVr/iI0wNditr3pnv7IuMrs1fkyon2
        LAWiEpQXo4o/bzVYgO7wER/kyQ+uhJhtXwlbNTc=
X-Google-Smtp-Source: AFSGD/VlFE41jSfhMJI0B+bPkc9AEv8O0hxYchHSxUs3g1Xz9TDsK+ixXIkTjri0z7OwWD9dliahm5IJwCYyaIGJLMU=
X-Received: by 2002:ab0:2508:: with SMTP id j8mr216612uan.130.1544586471626;
 Tue, 11 Dec 2018 19:47:51 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de>
 <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
In-Reply-To: <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Dec 2018 19:47:40 -0800
Message-ID: <CABPp-BHqJ_Dqpi-N-GVu9difvh-SnD1SZ2-SqaG0ctu5fBX-Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     svnpenn@gmail.com
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 4:51 PM Steven Penny <svnpenn@gmail.com> wrote:
>
> On Fri, Dec 7, 2018 at 11:04 AM wrote:
> > The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
> > is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
> > in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]
> >
> > Instead of duplicating the code, it is extracted into compat/mingw-cygwin.[ch]
> > Some need for refactoring and cleanup came up in the review, they are adressed
> > in a seperate commit.
>
> i have applied the 3 patches against current master, and my original test
> passes, so looks good to me.
>
> however like Johannes i take issue with the naming. as he said "mingw-cygwin"
> really isnt appropriate. ideally it would be "windows.h", but as that is
> conspicuously in use, something like these:
>
> - pc-windows
> - pc-win
> - win
>
> i disagree with him on using "win32" - that doesnt really make sense, as
> obviously you can compile 64-bit Git for Windows. if you wanted to go that route
> you would want to use something like:
>
> - windows-api
> - win-api
> - winapi
>
> further - i disagree with the "DOS" moniker being used at all. DOS is a defunkt
> operating system that i dont think Git has *ever* supported, so it doesnt make
> sense to be referring to it this way. again, a more approriate name would be
> something like "win_drive_prefix".

You seem to want internal function and filenames to be based on the
product or marketing names of currently targetted systems.  I don't
see why this is desirable; could you explain why it is?

I admit that I seem to see things more from Dscho's angle.  However, I
know much less about Windows than either of you.  Perhaps my best
understanding of the situation might help, limited as it is:
  - Using currently targetted system names means future code churn --
we may have to rename functions and files for absolutely no useful
gain, muddying the history, making it harder for developers to
remember how to find things, etc., simply because an external party
renamed their libraries or introduced a new product.
  - For people less familiar with windows,
"windows-api/win-api/winapi" and "win_drive_prefix" may sound like
something only available in newer systems, making them wonder if the
file name or function name is referring to some new windows concept
they are unfamiliar with
  - Mentioning an anchor point where the relevant concept originally
targetted or where it came from (win32/path.c, dos_drive_prefix)
avoids or greatly reduces both problems.


I'm worried based on other emails in this thread that there is a
fundamental difference in frame of reference leading to a
misunderstanding about rationale for naming, and worse that folks
might not even realize where the misunderstanding is coming from,
attributing it to different motives rather than different frames of
reference.  If that's true, I hope this email can begin the process of
clearing up the differences of understanding.  If I'm wrong, then I
apologize for the noise; just ignore me.

Best wishes,
Elijah
