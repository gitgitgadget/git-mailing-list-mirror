Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617711F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKNURC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:17:02 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:32835 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfKNURB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:17:01 -0500
Received: by mail-il1-f196.google.com with SMTP id m5so6568704ilq.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01BUW50qIAzZ8IHWZyvHwvRN59VaJDwU2+Iw4uPmrGU=;
        b=qZg37I5uOyFc3rP9th8aFoBUCJXZvHNqyRpvCl6Ihg0MMSyeZhWnsn8nJR8sk/rAhP
         +sjhjz8g7+VbzKtnNo35Khl3JVxatddvJ/D3E4/5iGBCh8KgSKtWiHEfazF1X3azr0o/
         aSPUSIB1WnqAxq15Dhl9rhAmdEylLU0V+g2SO/PVZ5jp0woOP7mwbw2k4HBYfYzdFXwR
         IV2trbNoSoKnX4sEPcemzrq2HWReWjNI5U6JLWflrrx1vcsbJfllKZRvFzilchdquYnZ
         qAgQdJs4K52X0B6dPs8zbYhjG7Xa4xJ6wiw6JSC8woqPvPGiGv3a9KvGMRvw9ZEQTtpS
         ScrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01BUW50qIAzZ8IHWZyvHwvRN59VaJDwU2+Iw4uPmrGU=;
        b=rVPrWXntWmJi96ZI/X3AHy17sS7dnM29xMo00kd+ZCYRU2N0/UDnGrdahtOeGg2OK9
         VEWnlwpcUBUeood492HIiOKZlQBH4Z+u9GpvWDzdOGrOCWsi2ZSrAbsF6534NPzHwvkT
         V5vBhh/qqJG7Zm1m/v2I8Oj9GXc0dKztsQ9+Q75qHlaSFV8IZjOSX2xRSy/wUYM0DesO
         YkAfgYDtqkC9si54N+nY/ER0C8t6XjjPlofLb0VrZSUkvycMjjLuFLFRrqSJe1WO4kPX
         caj2Km4dmKaSbJrjm1OiSvZ6wgcryjPSEpdFremOT9yefPLHNHOtaGzLOS7MjJZArLi9
         YNFw==
X-Gm-Message-State: APjAAAULfj2m+OUb88XaG9Titu2L+BvqaVYzqtuclrctCL3h6Ch5ozBC
        KV/q8bvCncM1mrATsqPOdbVGqo10zh9E/PpN2gI=
X-Google-Smtp-Source: APXvYqwW0ptG9ONPu/133CgNzDcVZoknqJcqr2xCw6OLCfpExNra8E+z4Tp3/EI+wOGEr/vmFLmJ1uOM74JuCcwqDFI=
X-Received: by 2002:a92:680e:: with SMTP id d14mr12700512ilc.224.1573762620676;
 Thu, 14 Nov 2019 12:17:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
 <xmqq5zjn9oaz.fsf@gitster-ct.c.googlers.com> <CAE5ih7-_ZESWAGAiXL4vT-P0aVYtrOAHn6dbhsfTmmeKVkSUWA@mail.gmail.com>
In-Reply-To: <CAE5ih7-_ZESWAGAiXL4vT-P0aVYtrOAHn6dbhsfTmmeKVkSUWA@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Date:   Thu, 14 Nov 2019 15:16:49 -0500
Message-ID: <CAAvvW8R4ZDofFaptW60=QvuSXRFS4U7zdNRGfUcE4iynRDrhFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Feature: New Variable git-p4.binary
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 4:52 AM Luke Diamand <luke@diamand.org> wrote:
>
> On Thu, 14 Nov 2019 at 02:36, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Issue: Using git-p4.py on Windows does not resolve properly to the p4.exe
> > > binary in all instances.
> > >
> > > Two new code features are added to resolve the p4 executable location:
> > >
> > >  1. A new variable, git-p4.binary, has been added that takes precedence over
> > >     the default p4 executable name. If this git option is set and the
> > >     path.exists() passes for this file it will be used as executable for the
> > >     system.popen calls.
> > >
> > >
> > >  2. If the new variable git-p4.binary is not set, the program checks if the
> > >     operating system is Windows. If it is, the executable is changed to
> > >     'p4.exe'. All other operating systems
> > >     (those that do not report 'Windows' in the platform.system() call)
> > >     continue to use the current executable of 'p4'.
> >
> > I do not use Windows nor git-p4, but the above two changes make
> > sense to me at the design level.  One thing that needs to be updated
> > is the configuration variable, though.  It is more in line with the
> > other parts of the system to name this "git-p4.program", because
> > binary-ness does not matter much to you, as long as the named thing
> > works correctly as "p4" program replacement.
> >
> > Seeing "gpg.program" is used in a similar way, it also is tempting
> > to call it "p4.program", but no other parts of Git other than
> > "git-p4" uses P4, and the "git-p4." prefix is to collect variables
> > related to "git-p4" together, so calling it "p4.program" may not be
> > a good idea---it would hurt discoverability.  "git-p4.p4program"
> > may be OK, if we anticipate that git-p4 may need to use (and its
> > users need to specify paths to) external programs other than "p4",
> > but it probably is overkill.
> >
> > Thanks.
>
> There's some trailing whitespace in 98bae, can we get that tidied up?
>
> Otherwise, modulo Junio's comments, it looks good.
>
> I agree that "git-p4.binary" might be harder to discover ("Oh, I
> assumed that enabled binary mode!"). p4program should be fine.

I have updated the Pull Request to change the variable name from
'binary' to 'p4program'.  I have also updated the PR description.

Here's the new commit message:

Issue: Using git-p4.py on Windows does not resolve properly to the
p4.exe binary in all instances.

Changes since v1:
Commit: (dc6817e) 2019-11-14

Renamed the variable "git-p4.binary" to "git-p4.p4program"

v1:

Two new code features are added to resolve the p4 executable location:

A new variable, git-p4.binary, has been added that takes precedence
over the default
p4 executable name. If this git option is set and the path.exists()
passes for this file
it will be used as executable for the system.popen calls.

If the new variable git-p4.binary is not set, the program checks if
the operating system
is Windows. If it is, the executable is changed to 'p4.exe'. All other
operating systems
(those that do not report 'Windows' in the platform.system() call)
continue to use the
current executable of 'p4'.
