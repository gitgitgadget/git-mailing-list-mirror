Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABCA1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKOJ2K (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:28:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38771 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKOJ2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:28:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so9585764wmk.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=801fuazKCyucsFHaQuO114IA7mGpsYo/C9IAE4P0pJg=;
        b=Dkyc2J33woP0JM7JO+20PTCKJWZIsyg0NA6TviAhDNZ00pMeGiLzjqvPVGSvu9Pp0G
         BXTxsU0rxnsOcSnIy73Pb7Dq5cvjMlP3rvVNw9WnUpVhanjq2z7FfL7SYeaLj7vpdXCW
         8UUJAYBdeGnvIg9ATHM5skX4mPMbwqw6V3qH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=801fuazKCyucsFHaQuO114IA7mGpsYo/C9IAE4P0pJg=;
        b=s5LmtmLr/LJE/SvGcuVnaAU6gR173MogRXSjKTZ2k0AqJGSIONQ3PHyV4XzruvqPWQ
         3aAJK7vTbvY85APWEEv/VXc7fx5FjH6tdUt5bqg55rA1WLrzRiImrKSYeUYzVz0faWeU
         +PT5r+5FuLfU6DV2Aniu1FmiXnbqNzESqNyblM3zfKcl9XURw69RqyllxwqibjW4cj6H
         fq5RwZHwSbII0fjGzwiDR8UsXZQxaVZfuT2bhFjvffZXeF9/slY7dGjkhnl8yW6A4RAi
         JRErVzNN/U2N7h7qUAZ9ug8lPhy9COg+h7DJ26ED4XvzDy8+zQ4GkINKqRt3BsRlkK89
         PvUg==
X-Gm-Message-State: APjAAAVIO2IzVvMIZJopPx3HT4MQWiZpj6GrI4VAApeXAKawyhcr1CgR
        6K/IL7G+ZXGAW1bqZKO2Y9RhZYl7wK0UrO6hh9snqQ==
X-Google-Smtp-Source: APXvYqzVU8gmwMKDHXdSD7GdaD/rxN1sO3/CFQHfYSgVQeDee3roQNesAcKpoDOFzgdpOfnqpnVq6IQN7zGTyl0Wlmk=
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr14420303wmc.52.1573810087714;
 Fri, 15 Nov 2019 01:28:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
 <xmqq5zjn9oaz.fsf@gitster-ct.c.googlers.com> <CAE5ih7-_ZESWAGAiXL4vT-P0aVYtrOAHn6dbhsfTmmeKVkSUWA@mail.gmail.com>
 <CAAvvW8R4ZDofFaptW60=QvuSXRFS4U7zdNRGfUcE4iynRDrhFg@mail.gmail.com>
In-Reply-To: <CAAvvW8R4ZDofFaptW60=QvuSXRFS4U7zdNRGfUcE4iynRDrhFg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 15 Nov 2019 09:28:45 +0000
Message-ID: <CAE5ih7--QUmDttrCCtoTNZ0FTLOnu5gQ4yzwKzAnE3-dmhD=Ag@mail.gmail.com>
Subject: Re: [PATCH 0/2] Feature: New Variable git-p4.binary
To:     Ben Keene <seraphire@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Nov 2019 at 20:17, Ben Keene <seraphire@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 4:52 AM Luke Diamand <luke@diamand.org> wrote:
> >
> > On Thu, 14 Nov 2019 at 02:36, Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > > > Issue: Using git-p4.py on Windows does not resolve properly to the p4.exe
> > > > binary in all instances.
> > > >
> > > > Two new code features are added to resolve the p4 executable location:
> > > >
> > > >  1. A new variable, git-p4.binary, has been added that takes precedence over
> > > >     the default p4 executable name. If this git option is set and the
> > > >     path.exists() passes for this file it will be used as executable for the
> > > >     system.popen calls.
> > > >
> > > >
> > > >  2. If the new variable git-p4.binary is not set, the program checks if the
> > > >     operating system is Windows. If it is, the executable is changed to
> > > >     'p4.exe'. All other operating systems
> > > >     (those that do not report 'Windows' in the platform.system() call)
> > > >     continue to use the current executable of 'p4'.
> > >
> > > I do not use Windows nor git-p4, but the above two changes make
> > > sense to me at the design level.  One thing that needs to be updated
> > > is the configuration variable, though.  It is more in line with the
> > > other parts of the system to name this "git-p4.program", because
> > > binary-ness does not matter much to you, as long as the named thing
> > > works correctly as "p4" program replacement.
> > >
> > > Seeing "gpg.program" is used in a similar way, it also is tempting
> > > to call it "p4.program", but no other parts of Git other than
> > > "git-p4" uses P4, and the "git-p4." prefix is to collect variables
> > > related to "git-p4" together, so calling it "p4.program" may not be
> > > a good idea---it would hurt discoverability.  "git-p4.p4program"
> > > may be OK, if we anticipate that git-p4 may need to use (and its
> > > users need to specify paths to) external programs other than "p4",
> > > but it probably is overkill.
> > >
> > > Thanks.
> >
> > There's some trailing whitespace in 98bae, can we get that tidied up?
> >
> > Otherwise, modulo Junio's comments, it looks good.
> >
> > I agree that "git-p4.binary" might be harder to discover ("Oh, I
> > assumed that enabled binary mode!"). p4program should be fine.
>
> I have updated the Pull Request to change the variable name from
> 'binary' to 'p4program'.  I have also updated the PR description.

I couldn't figure out how to download this. I tried p4-binary-1, but
it gave me the old one. Maybe I was just using it wrong?

Could you update the commit message to say why we needed to do this;
if we have to dig through history in the future to figure out what's
going on, it will be a lot easier if the explanation is in the commit
message, rather than in an email thread. The branch description on
gitgitgadget won't be around either.

>
> Here's the new commit message:
>
> Issue: Using git-p4.py on Windows does not resolve properly to the
> p4.exe binary in all instances.
>
> Changes since v1:
> Commit: (dc6817e) 2019-11-14
>
> Renamed the variable "git-p4.binary" to "git-p4.p4program"
>
> v1:
>
> Two new code features are added to resolve the p4 executable location:
>
> A new variable, git-p4.binary, has been added that takes precedence
> over the default
> p4 executable name. If this git option is set and the path.exists()
> passes for this file
> it will be used as executable for the system.popen calls.
>
> If the new variable git-p4.binary is not set, the program checks if
> the operating system
> is Windows. If it is, the executable is changed to 'p4.exe'. All other
> operating systems
> (those that do not report 'Windows' in the platform.system() call)
> continue to use the
> current executable of 'p4'.
