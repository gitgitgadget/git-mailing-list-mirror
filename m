Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B897C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A2020661
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AUYqYN4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgDYN35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:29:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:52253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgDYN35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 09:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587821390;
        bh=Dmds3AL1o7zrj4xe386hutVEb5SCZk/F9flG7itui1Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AUYqYN4YiEYbhLUpWrR0BdzODj8y1fxdAyCzy71tMtj/GLoVfIxDFgBlQ0OqgeDcG
         FYzjWHw73qkBYh5/KNJ2NER8SoQV+W6o6zKwG1GNDWIct6G0O6IVWzWpS2ECV5pDfB
         LVOb7joRTljILOslgXMWaYa4b3jRhTbkLtIZx1Tc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7K3i-1jXoWY1oUO-007pOP; Sat, 25 Apr 2020 15:29:50 +0200
Date:   Sat, 25 Apr 2020 15:29:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-572849242-1587821391=:18039"
X-Provags-ID: V03:K1:erLec5ZmhbNCr+iYM+7cbVnQuBBNtMryoIKr5o5b971gPRvvtKp
 GDGDpINwMO5yfJvy8U7dvIVnQqkGZ9ifxTz8tRcpsRrpedmivA2/HR/p7kv2Szc3Od/1uqe
 S5S5Ilocj5c9/mkgvd88L/VmlvSuGx6PSjNSAjbqp0v/cTtexgJyMiDwmvt3xR5z9sCLLzW
 hOjQfrpJoPNBcwXQu5JbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0m/44xZyMso=:JwjRp1ngEefBaQoXP76SGA
 FGROWATH9raUXcV6Vn+gm9V5y+yu4iU2oQPpXwS1iAZrdJsXI4yiUVmru6a1budbH9lH2N3uu
 9Dgu4/N30Vbz01z+dEq4nVEyi+GGOXH4CVmPt2VWh88oUpiJX6ty6LnkQVLPXfCI8ktHfz65R
 RnZ4pMOF9fvOwo2SxyBWNaIPmOTofzS3HcxdRX84fScRbFhABK7Hph4BgF5RsIogfCKTsrwB5
 wsH51pIKG58BXBBbK1gj6yw7KX79T7U36piePMCpJi9onDopA4LebG+gitVOu5rfQfhgHyZyg
 2DLsD2BMV6ROeJnvdg4nE1cdWiASrrt0xmnVOluBID+u/ECUVKtwyAGIg42ZuB9kT6K/ZP4LC
 YqtKqDM+qspPNfhkNdKi/vT00aoi1iKs7IF4kDOUpNK9Oz2SF1SFaKUOOxwwOeKRg0EUeizIA
 CdXa3PpDvfs2NDNwEqRU2c5n9kkGku1gS7yxhWZAG4TMnDv/j9rxGZWvySt8UCieawmSJYgBx
 jfyEEtWN/ynh6/CWKM45IW8xGlQwROv8yAwa70JGWnwxzCjRUQflMYwiHXQzfUQb45xj+qeVY
 ooCjtNzOa9mnHxmQEuO/6M6dNCvqcqC+VNZHgxMMpfj/kWh+Di6SiviItFUCnkJikKwL+3f9E
 DBW+0zgJP95LMZFyjkGkOno3YwKhKYJM1C/ILVmbSvJxj7M9u4RmlbtN9LGRMq4+7yGLHqnOb
 24zCeFeRfPL26lJzKLm23334h0G1xkzGTRqB2ZVXwtZODX+6Nmz3uHB/7KDdhoXuby6Mf5VsX
 3mN7SP+C2PN0EjaZwZJzeL+3T9dlsXfXfwpyaYFJRFdM1geYBk0xf90kSgj1HVSg3W1hjLVgH
 VI/AvHAciXueD4e2bP9FVcZ+jXTZlgMq7SKiqjLUrveqYUSSnpTnaWdjSRHCE8cdB8BaHSiBJ
 L9K45RfAc2OKuGsaFjXP0c8BvNfBstPmg/2yTRxSTlfeCoQz1FZzWG22aT2QBmCP36F8YQvLP
 id+11W7p5ROnwNKe5qr0LdrvHBbEPuHXdtTc+mln/bHdFS5G7WYkxxb7Ji9o337gwwAufOFPs
 r3fsjFnNMBx2GH1w6uJqP6NlBd2/8anmb42MpM2c4kFyzQYAnOwDxEAHf4JjWooLPTzzdHXzf
 bOev8MyJfSooaEzHjpee1d1P8B23R9HkjN24eBetTOsvf93lYarxpWNB+YcG/TK8Ma3wSnKo5
 GdrKxOxDYfFK3Oemv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-572849242-1587821391=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Sat, 25 Apr 2020, Philip Oakley wrote:

> On 25/04/2020 05:09, Sibi Siddharthan wrote:
> > On Sat, Apr 25, 2020 at 3:13 AM Junio C Hamano <gitster@pobox.com> wro=
te:
> >> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> >>
> >>> The goal would be to maintain a CMake build for Git keeping it in
> >>> sync with the Makefile. The Makefile is not going to be replaced at
> >>> all. The CMake script for now only supports Linux and Windows. It
> >>> does not support BSD, Solaris and others, whereas the Makefile does
> >>> support them.
> >>
> >> So you are doing (1).  I already said that I feel that engineering
> >> burden to divert resources for CMake support would be unacceptably
> >> high.
> >>
> >> Whenever any of our developers need to add source files, Makefile
> >> configuration knobs that people can add to config.mak, etc., you are
> >> forcing them to figure out where in the CMakefile to add them or
> >> devise ways to allow builders who do not use config.mak (because they
> >> use CMake) to do similar tweaks.
> >
> > Adding source files to the CMakefile is going to just as long as
> > adding it to the Makefile, anyone can figure this out and this is not
> > going to take much time at all.
>
> While figuring these things out isn't /hard/ it can be tedious and time
> consuming for those who are not familiar with the particular tool set
> (as evidenced, in my mind, by the poor dev support for Git for Windows
> because of the need to understand two operating systems and their
> awkward interactions) - those that are familiar and understand the/their
> whole tool set are usually the x10 folks.

Is it fair to compare the complexities of the differences between what Git
expects and what Windows provides to the difference to add files to
Makefile _and_ CMakeLists.txt?

When I add a file to the Makefile, what I do (and imagine that _everybody_
is doing in that circumstance) is to find an already-existing file that is
similar to the one I want to add. For example, if adding
`builtin/oakley--helper.c`, I will try to imitate
`builtin/submodule--helper.c`.

And when you do that, you don't really need to understand Makefiles or
CMake. You find the list(s) and add your file there, paying attention to
whether it is maintained alphabetically or append-only.

That is a _far_ cry from the hoops through which you have to jump to
understand, say, the important background details in order to start
working on `compat/mingw.c`.

At least from my point of view, there is very little analogy between the
subject under discussion and what you brought up.

Having said that...

> > As for the configuration knobs I agree that adding the same to CMake
> > is going to a bit longer.
> > But anyone who is hacking Git is going to do it with the Makefile or
> > (if accepted)CMake script, but not both while hacking.
> > So they will continue to make progress with the system they feel comfo=
rtable in.
> > They will only run into an issue when they try for a PR. Currently the
> > CMake script is only used for generating the visual studio solution.
> > We can add a (continue-on-error) to vs-build job to make this process
> > less of a hindrance.
> > If people take the time to hack Git, figuring out how to do the
> > configuration knobs in the CMake script is not going to that much take
> > time
> > compared to the time they spend making Git better.
> >
> >
> >> Any patch that is acceptable to the current project would become
> >> unacceptable because they lack updates to CMake part, but I suspect
> >> we do not have enough people who are so much devoted to give a good
> >> review if updates to CMake part are added.  And it is unclear why it
> >> would be beneficial to slow our existing developers down by forcing
> >> them to become familiar with CMake.
> >>
> >> So..., I am not just "still not convinced", but I am even more
> >> convinced that we do not want this series, after thinking about it
> >> longer.
> >>
> >> Thanks.
> >>
>
> Is there a middle way, given that IIUC there is most benefit on the
> Windows side, that on the git.git side the Makefile could contain a
> suitable comment directing those interested in CMake to the relevant
> part of Git-for-Windows. Is there a part that could hold, and track, the
> matching changes to the primary Makefile?=C2=A0

We already use `GIT-VERSION-GEN` as the authoritative source for the Git
version, by parsing the line that contains.

It would look very similar, at least in my mind, to generate the list of
source/script files by parsing the `Makefile`.

Sibi, what do you think?

Ciao,
Dscho

--8323328-572849242-1587821391=:18039--
