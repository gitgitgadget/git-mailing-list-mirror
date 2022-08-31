Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF499ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiHaTyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaTyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:54:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C8EE6A1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661975669;
        bh=AiAXBXRl+wc30fl/Ni4fhjooA6qdmfmKcbhsvA8zuAQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=avcI39nlxi2k0JZM0FvTCOo9fMdJsMpegMtmJzY31MVcprLkJX1rN2lSBpUEDkZPC
         y3Drstr4KEWVWPClN/VjRpptHrWoSzLblxEjt4Hc7ecE1cqd9EncvND7/jKMWsf0eV
         N5+7lbq1/rp9uO4P/UCljFWV/mKFVAwZmEzw+wa0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC34h-1oYeqm1wYH-00CTmS; Wed, 31
 Aug 2022 21:54:29 +0200
Date:   Wed, 31 Aug 2022 21:54:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: js/add-p-diff-parsing-fix (was: What's cooking in git.git (Aug
 2022, #10; Tue, 30))
In-Reply-To: <b0a368a1-a6cc-1940-4804-3cbcae1db235@gmail.com>
Message-ID: <578r404o-r7or-6pnp-2s59-o6s0525nn38p@tzk.qr>
References: <xmqqilm9k0bc.fsf@gitster.g> <220831.86bks0ajy7.gmgdl@evledraar.gmail.com> <b0a368a1-a6cc-1940-4804-3cbcae1db235@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-377237880-1661975671=:189"
X-Provags-ID: V03:K1:AboD2ZOiH1JEFd9jeFRHAsfdesE/urCQxH39ktx9bmQNtDd+Oxk
 g2rrcHIkdS1i+stcHFaYfVhrqJHIUD1wgjpVFi9f3NjclGCiSXzW9l0Kx7U37NvHzPjvp81
 Jb3vXj51eXvWd5RnNLO9Y7Q0Y2meBlf1IyjGLfmo6o8Q5pi0uRYIDID7KM92WQU/j8DnzzW
 NJSmwGOOF/3lr+Oc5Do9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AwrdlocwR6Y=:6Fd+80ItcMkR/ksqueS6KY
 sHbH8zQaKcp3c7iw5UWxdEW3OFBxsRLNOYxZXTAxAmhSJTiQ51xj4aT4lx4OI4m/w5RjqQHCP
 zijHPc8sRiaEtJaAUYHWIEZO0+/yUWuLP+uoPZH9toBGvwbUGwRSmQYHd8zcgm9Uihn4Bnw9N
 Mx37ttQqfn7gzHQmgtMcv6RXkJOysfOKz0LsGx7p//UIL+3Ki6Z/hvSshfzxoncBUoHnIskWI
 kvpDe/dx13wbtBGanrWJSvwy7uy7PTlmWZXbjyV7ywd07xyN1wFkQ+FG4PLhrgwqbqHbPnuTV
 hsq6Au74DzWZHxnAe7pZ4GphrKbNyW2VWh2Wp2dTcOurT7WiTh6FTW+VZWJKkuAgfrUIjiVni
 xEVas6E1ESbYMLzDIQvbXmcD8Fk3Q8j2W81PTflcwvez5rPguejH9vXF2Q+XLAgrPTJ4roESw
 xxemnlAfxHWiUWo0VFlM2qke8mnNsblV7XIxwXMAgc+SJvDH9sVBf+dpZ+qj473EL3vMQJQy7
 UzOZEHcfnAkMQQ9EP99qP02jxJqVkacsB/ybJzzMKTJiaPVXF1lhYKqLThY6XFrjxxV02tL3Z
 DrxuuTQkwSLWwBTDZMkX6ZmrVqE+sKcD42e+xtSgLYPDZyqKsKjFs/esj3BUyfNIISuvstyWP
 jQBiKQ871Y5ALddsYF8UkPm9LAvYqpBGUIj1c3VJlienbVniMV3U1MPy+nPoxrJrXkaE7C9JK
 41ebbpCFTBbuGHCGjnT5q/5IR48x5yA5d5HEDV3oiEfNMEPt1gmGRfPcPMTlsDM7aJ0sy/jHF
 Y/AtQlvmRTvUePFOd1IOGSez0vjZkQUqmvnU+3ChcoGbLPtc+ZP90U+IKtmQXBSfugn/87af6
 W0H894FRX8tpi+amQrA6q2RbgJ/o6CcxYoCmNOyt99Rz5qKm8VRnP/sDinUTt8V/3Q0ZXC+TM
 W9Bj6609JLaDKd1RcTQamwvKOtoYjaN/mPiKFaOZKLGV078v2iIMmmmHcbGW2Jqjl2PcAR3Eb
 cCVyygtgVwVYHU4lrRCOZ6QMd62MfqzAb8vHo4d5YVQczWuDS78wGsHyHCC0xr8FfHBtvu9pE
 CFehUXWR/I8HkVAKheSTFSAhcYrBkmm7ELLvvT98O82ECGTWIH05Fg4lQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-377237880-1661975671=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 31 Aug 2022, Phillip Wood wrote:

> On 31/08/2022 09:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Tue, Aug 30 2022, Junio C Hamano wrote:
> >
> > > * js/add-p-diff-parsing-fix (2022-08-29) 5 commits
> > >   - add -p: ignore dirty submodules
> > >   - add -p: handle `diff-so-fancy`'s hunk headers better
> > >   - add -p: insert space in colored hunk header as needed
> > >   - add -p: gracefully ignore unparseable hunk headers in colored di=
ffs
> > >   - t3701: redefine what is "bogus" output of a diff filter
> > >
> > >   Those who use diff-so-fancy as the diff-filter noticed a regressio=
n
> > >   or two in the reimplemented "add -p", which has been corrected.
> > >
> > >   Will merge to 'next'?
> > >   source: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
> >
> > This LGTM.
>
> I'm not sure that the different output from the builtin version compared=
 to
> the perl version when using interactive.diffFilter is an improvement. Th=
e perl
> version leaves the filtered output alone but the builtin version has sta=
rted
> prepending @@ -a,b +d,c @@ to the "hunk header" lines produced by the fi=
lter.

A convincing argument!

And after implementing this (and dropping the patches that implemented a
deviation from the Perl script's behavior), the patch series looks so much
more elegant, too!

Ciao,
Dscho

--8323328-377237880-1661975671=:189--
