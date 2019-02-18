Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348751F453
	for <e@80x24.org>; Mon, 18 Feb 2019 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfBRP4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 10:56:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:54445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfBRP4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 10:56:14 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWo2-1gnXoG0jtW-00AYEE; Mon, 18
 Feb 2019 16:55:58 +0100
Date:   Mon, 18 Feb 2019 16:55:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH 1/1] tests: teach the test-tool to generate NUL bytes
 and use it
In-Reply-To: <xmqq5ztl6jbj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902181652160.45@tvgsbejvaqbjf.bet>
References: <pull.126.git.gitgitgadget@gmail.com> <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com> <xmqqimxm6msi.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902151558080.45@tvgsbejvaqbjf.bet>
 <xmqq5ztl6jbj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+04AW18QGY961kIv6P/RUTJ57tvY89m9Nv5U69vO17gfVd9207N
 LNy3dKac+erj42NNy164W8b9awOq19Vqj3gGYEQmH4G1egm4lk0yghMqfqiP0rTFXZxWIsr
 iPreoTvhjnXT3INgbqdvJRuProSgW2jHQ2FqQC24QyZkcWVlOxWbOV4ersGlHwgBDSJ1Yp0
 CMeQYtj6u2ah62nYK/2DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WsFxx5XXn2A=:B+nXuFvDktftZAH8Vd2+qX
 sELNKfyvOcFBJlEGG7J1MZ0Cl4CEsPmUDNJq2a3XM/ho9oZVAkl+k0gDt2ZSFuPwhG4bpAxBi
 eu2sB/tsUY88+M44eSR5ap9VIrlirO86j6tbGYVwWLUraWAlX7W9x9eQ284Fcw9ca5Ll7fTFQ
 0JvAXKTxTY5aTWDg5rhkTrjzkVAPB8NP2YS7bASq89/GUCbHVUb/tXeXe/rLEfEEFK5y4QYrZ
 VallViQQ4/HnD+PH6wpwJ8pSDPxn39anJ0YK8/V6E1SL4jRt5vOa6nwfN9KgCP5hJ84wWxmER
 7s8HK7BYrCL17ST/Z40aCA6M+cZ/dAT4SLyufXQM2bXJRYLr5qlBLLGFk14FNt/i9aUkuyzyN
 hr30DQsW/FmSiz0IDqVcmhd8RuTqQeXsKeIuJv/sRa75so0MQ5q/hSZ/shPRNkPnKlF4VKGGC
 F2ensSt/zhSk9CQzEmKTnTxQpdCz0UbiD+erd1UsYG+/LHYuCKjmQTDIFu4wFPBGUwCIscZ9V
 skHeTJTIgxztT6/jxFmX9Ajtqozdl4tTmeQfKYizjS2mOFe67H3TYGieid14pZ+zdLaDkKcze
 4UZm2in3wHxS1xp/GOkq9cU9Im6dRHoZfq8deY7UsbJdsB0QFYkxcsUr/50i/dpMq8tvdjsDj
 uGqAtpb6qZkU4/G8R4xMdRhIsT4Bf/cUMrLK0FOwy9oYnhkN7XNPi7VnOxw9Ecz1LBtAQakpK
 EX+xqL2Frpps2NHRxh4jv7IrmTS8lD8PXH5OlxLD9A3dde/KPN/vYJQp1sxyQ6orhzSxGAfxT
 1QLLwGX+Yxle+qb0ocY/lKo9Wf4scOLTqnkhI6Sbp7l/q/v5PpFSC/uGxGFaTvJeU+RtrFMKr
 pmgYEdFXzXhpH9ovc9lN2XPUR15eOFWt/vB0hld4x080kF8v/AyllG3ylJ1ADEaHwUa5zk32B
 kB4UJRGgDSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 14 Feb 2019, Junio C Hamano wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >> 
> >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> >
> >> > In cc95bc2025 (t5562: replace /dev/zero with a pipe from
> >> > generate_zero_bytes, 2019-02-09), we replaced usage of /dev/zero (which
> >> > is not available on NonStop, apparently) by a Perl script snippet to
> >> > generate NUL bytes.
> >> >
> >> > Sadly, it does not seem to work on NonStop, as t5562 reportedly hangs.
> >> > ...
> >> > In the end, though, what counts is that this here change incidentally
> >> > fixes that hang (maybe also on NonStop?). Even more positively, it gets
> >> > rid of yet another unnecessary Perl invocation.
> >> 
> >> Thanks for a quick band-aid.
> >> 
> >> Will apply directly to 'master' so that we won't forget before -rc2.
> >
> > Thank you, that will be good, as the builds still seem to fail. All of
> > them.
> 
> Actually, I am really tempted to instead not apply this, but revert
> that genzerobytes Perl thing.  This assumes that your Azure thing
> did not have the breakage before we applied that patchset.  What do
> you think?

Honestly, I don't care, as long as we can stop *all* of the CI builds
failing, soon.

So whether you revert that commit, or apply mine, it is up to you, but
I'd really rather not see another batch of useless builds.

> Trying four or more possible band-aids that may or may not work
> without knowing what the real cause of the hangs are is not
> something I want to see people spend excessive time of theirs on
> this close to the final.  I'd rather avoid distraction and see
> people spend their cycles on bugs that matter, instead of trying to
> chase test breakages that have always been present for those without
> /dev/zero.  I am not fundamentally opposed to supporting those
> without /dev/zero but I'd prefer to see it happen in 'pu' until we
> identify and fix the real cause---which may well be a real bug in
> the http-backend stuff---and the time to do that is not during the
> rc period where we close the tree for new features and non-regression
> fixes.

While I am quite positive that my patch helps (even on NonStop, because
reportedly the hang is in .13 while my fix is about .15, which the commit
that caused the regression also touches), I am okay with holding off until
after v2.21.0.

But in the long run, the only sane thing really is to move more and more
functionality in the test suite for which we rely on Perl into test-tool.
It is really the only thing that makes sense, from the perspectives of
performance, robustness and portability.

Ciao,
Dscho
