Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5BC433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A8C206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="V6sVmPI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGZRlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:41:05 -0400
Received: from mout.web.de ([212.227.15.3]:56877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZRlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 13:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595785262;
        bh=1JIT61GVF43l/MZY2KGJKUugdTtAXxcRJfEVItUeNO4=;
        h=X-UI-Sender-Class:From:Subject:To:References:Date:In-Reply-To;
        b=V6sVmPI4DxOh1sXGQo4bum+62AoYrvA0ifaTOnp5IF87O6HvACm9RO9Yrl5SPJgb7
         CzTe+iNEkDesASSXZs84dopYQPNkOtJ1zDpLEuUqoo0S3rjM/Ye0nXeifc4oUGCMX6
         6csiz0RjKnCDwNu2/95i768BjitNOdHHaOkKG7w0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McBct-1kGSqX2B0h-00Jajm; Sun, 26
 Jul 2020 19:41:02 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: git - more like a feature request for pro-lifers
To:     Robert Muchacki <robert.muchacki@gmail.com>, git@vger.kernel.org
References: <B56E3052-2BD5-42D5-A854-2FAB528C3214@gmail.com>
Message-ID: <50665f11-7d33-050f-d4ab-512161bec4b8@web.de>
Date:   Sun, 26 Jul 2020 19:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <B56E3052-2BD5-42D5-A854-2FAB528C3214@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QOvTzyJn8fO3qiraB4SyAstRkbic0gZxAq4aerYBFDyQwUgedpm
 tc7dVgzT7L4ZBZOTxLcXiqWQiDDHd0nXDV6mR/XIk2wfpbduOVI9syzrnf18IvwlSWb/SHi
 6w2mM1Q9dh6Z16PbK9F6WfgRj89fZUTBWC4zUh8Z3bdb/K7kqjhtAYZWkGgzQ8dRkiI8aiV
 jT8y5nQm9+qhsyHuIOGng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tQkcF/QB1i4=:ZUrJHY7K3MYujc6/B+WW5x
 fuZnfNDu50KKzY6V9rQcFzpfVYxJKs9HgOFVW184kIOE9M7B4m5R+1eoWwfKYwO9Y8fmyak5o
 4VZA2tKjgupyzfiGLnwn/OsR01AlUoUWgNGXyc/s9Abb3HckcSEwnPPRJnU2CpVk59ouctlFW
 Ygx21qlpOGrxwGGvs3ZvYNhfp7rw0thJO+wMvO1YWufj/im1Cni9Xb5kURcTmKzj1ojYg1fuX
 mwmm/kfQLtHKh9y1A9aERJA6E+TA8zGKSQ2QZ2eStGyLJ2J1F3bipJJEl4AXWbpV8yyuedSMA
 SpYyRE8dPhiiW5EqLyWYwxEKSh/pqnFMDtHgheX2HQqMTJFCiQ4mPRPqtvTxpG8s/uyPgqS5l
 gs1iXpW/M+424IoVMlGoML0PKYrfikGy6Jp/E6ilxuHk6tPe0ARSbyuOCYpa7ApfkEgAr8WDp
 4T8ae2CbXe7c8q5TkUv9S/aDSgxQTKlq+c/vtubqxVK1fAkAnImEdkMFqkPZR9lc/0o1sZC1h
 VZOOcHttjY0lX6hRJz5a3L7THZgrayldehnLa2pItHb+x5Zllue1FByIvNXJquAaz82NbqYqG
 JhnpCXm2v3djUEwyjYSSQ38rwMM2z70G28fV5Nc1eMMwkO8qAJqWZ/yusc61fnP0reyudcTNe
 AklCMlESy5pBKUjrge06/CEnopc/bpb3R1nKBAUB1fUHCgecu6v2/ojDbd2naxTXpFS6WgOfS
 DTcR6lDd6ge1gfLiyO4cAkGR8ooG53fvp7omsSy8Y9q9Ka1uUC2c0SBH1OPpIH4eoHwumcd1L
 EvgQCsM5lwwCn87bOuML4/yvnmjv8rYz46qCg8f8rYxkUfSiTBeen0fxUBS/WOZji+RuexlSP
 K3+I93Ck6NeAD7zo4m3mtX7AIDtHuyAZ1TFvAdcGHnjOFMk2Yg3bL9jUkUQ8gChvcGf3NgZfu
 Ydc31S03fH/9oIBX3MqWU8B5yOaEhiEO5y7u6PMOyg2GLCjrGjJCIl7jUYIi4T6uDSiBlmBko
 jirPF28i8e6oadPdCaL3Rg8iM+gqhumph1Y2BbfKfAzPG96T/A3ZsP9rv7cJq/KGBRu4rkoY/
 EwPj2w03XIgSxBg5Z3v6cpv/MOUIAjBra0wqkm1pgTapfmtBtFeG1FzhGe03xvudIVLWwZi/S
 JoyLs179NAL/w9GrWLs5bl7vsF8/gBYIMiN490FY+86Kxnz0McZ7ykESec1iffRDLkJdiBwox
 cSmUbBY85MnVGPBSJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.07.20 um 10:28 schrieb Robert Muchacki:
> Greetings!
>
> Attached is a feature request for the pro-lifers. Doesn=E2=80=99t seem t=
o much work to do in the code.

Commenting on attached files is hard, so here's your bug report inlined:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> I tried to switch branches:
> ```
>   > git checkout other_branch
> ```

When I do that I get:

   $ git init -q a; cd a; echo 1 >a; git add a; git commit -q -m1

   $ git checkout other_branch
   error: pathspec 'other_branch' did not match any file(s) known to git

If I create that branch, then I get:

   $ git branch other_branch
   $ git checkout other_branch
   Switched to branch 'other_branch'

If I create yet another branch, commit a modification, then modify the
file and try to switch to that branch, I get:

   $ git branch branch; echo 2 >a; git add a; git commit -q -m2
   $ echo 3 >a
   $ git checkout branch
   error: Your local changes to the following files would be overwritten b=
y checkout:
   	a
   Please commit your changes or stash them before you switch branches.
   Aborting

> What did you expect to happen? (Expected behavior)
> A friendly information, not confusing, not anti-life, that will tell me =
why the process stopped.
>
>
> What happened instead? (Actual behavior)
> I got a non-pro-life informatiom, that noticed that it was ABORTING.

So you got the same kind of message that I got on my third attempt
above, right?  That means some files were modified and switching to
the other branch would have destroyed those changes.  Git detected that
and refused, to protect your code changes.

> What's different between what you expected and what actually happened?
> It should have been STOPPED or ENDED. ABORTING and TERMINATING is unresp=
ectful for the unborn code.

Overwriting unexpectedly changed files would be irresponsible, so we
need to keep this feature.  Users can discard changes in more targeted
ways, if that is really what they want to do.

I don't see how any of git checkout's messages is unfriendly, but you
somehow seem to dislike the "Aborting" part at the end of the third
one.  https://en.wiktionary.org/wiki/abort#Verb lists nine meanings:

1. To miscarry; to bring forth (non-living) offspring prematurely.
2. To cause a premature termination of (a fetus); to end a pregnancy
   before term.
3. To end prematurely; to stop in the preliminary stages; to turn back.
4. To stop or fail at something in the preliminary stages.
5. To become checked in normal development, so as either to remain
   rudimentary or shrink away wholly; to cease organic growth before
   maturation; to become sterile.
6. To cause an organism to develop minimally; to cause rudimentary
   development to happen; to prevent maturation.
7. To abandon a mission at any point after the beginning of the mission
   and prior to its completion.
8. To terminate a mission involving a missile or rocket; to destroy a
   missile or rocket prematurely.
9. To terminate a process prior to completion.

The third, fourth and ninth are appropriate here: A checkout was
started, but had to be called off to protect uncommitted changes.

"Abending" would also fit and it has no other meanings.  "Staying on
current branch." would be more to the point.  But actually I'm not
sure we need that last line.  It's shown to emphasize that the
requested action was cancelled, but I can infer that from the rest of
the comprehensive error message already, or even from the the fact
that an error was reported at all.

Would that work as well for new or less technical users?  Dunno.

>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.27.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Sun Jul  5 00:43:10 P=
DT 2020; root:xnu-6153.141.1~9/RELEASE_X86_64 x86_64
> compiler info: clang: 11.0.3 (clang-1103.0.32.59)
> libc info: no libc information available
>
>
> [Enabled Hooks]

