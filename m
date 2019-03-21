Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D5720248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUOa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:30:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:48661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUOa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553178617;
        bh=MQbEycVDWwongfNlolAeBcRPb3qTRQZCFcpaZ7UPU6k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P2mrwQ8npmravaORV5ev/YBzT15wxrH0+/QJbFJH1qYvd1lrGRxB5oNyzK8lFM6zo
         ZfGt6JXkfGTwEhI9Z4WZ5eEtwu4kk79OrTMYWBP2hHC7bE91QW6sYaJcV4Zs2OV3fv
         GmhfyabCcoYNzmQizCPAQWRfxrgdw1h4H0XQz8+M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1h4CTz2sLy-007Fer; Thu, 21
 Mar 2019 15:30:17 +0100
Date:   Thu, 21 Mar 2019 15:30:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
In-Reply-To: <87k1gxa8cm.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet>
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com> <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com> <87k1gxa8cm.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-902831370-1553178617=:41"
X-Provags-ID: V03:K1:mSQozhc4DPmePVLY2Us3a7XjOjhQh/N7p8ijdXvFxuiIm0ezpso
 TIHyBdMXspV/hZQ3kkllItTUjFsMJk//D+7rzPt8HKfxz4Cx+IhKH0qAgA8nL4pAuA4SJy7
 d5YJU8NQ7Mb0vWqqi+v5ETH66i70m9Ysc31BHnIDfoHyAQnLx2yvf/qyo+hPFfGxu+1SLCM
 S0IsPLRxsMnLRS1Xs9IxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNwc1NUZFOU=:65CERUxFdowX2uTQvUTqgY
 LzSXHtT/Axd2Pk3VWOxO+S1qgF6W9WzwccCFNUB769gVmAj90pyy6wCQW+Q6YBvP0pFkg03kE
 5hW5eL14toZyBW5P7WEzlnM0Epg7O1izvFWkKMaUyqWLJyUXj4DewhUCIRpTepL6D5SB9F845
 yFU1cDZVQ0zhHM4HEzOBZy27/xmvfFDfr4HIA60jZw+JZiu58aRwGaROzLsxMHE95ufMPg75h
 LIl6I0FIuv2bgmqRCekIIRc+2AZjU9tY0Hdf80FUFEcRTEO78eumrMHER3zxP30L7SJ83ZX/i
 LyZyL2c/u20Eb8voKGUrDLu8cXYIwZsS2BjGbHKxcacLBhrvvG3LoOQcmYydL6V+EuJ7rrhgB
 teoCyPTDmfLe1INuu42qOv2BpeDuvGNj7erkOYuWdwQd4tHbjqqTifmeBCM8ijgtvu1/f+UnA
 kZx18D5GRQyKkFq7Af7Z68xCuFKoh9545JNabrTKoRQWnRAswRksmIv20qtmyUkzD/Pe19u4Q
 BvyHhqYEAt/2GVO7byTJdLFhecxP07zLzSNpK61TAS48PdN3qP9/kzzKz28TYQg8bVdKPmsuU
 eUDGyvBr6qajxDBOFkiStbapdz5sXyFiJMC7KR/tqWjxa65JAyYe/Nabm+CEkDyIvFRcpkzR3
 frIzcdgarjojhuAa/PtnLCGnFE6/NkDV0fwf+w4lNKCkY7kJfajuGgjyjq6fMNCFE5lNECloN
 Q2hYM4OdijlcMQsWPXGYAvp3UjDk5KObHfeLbI0J+BmJjrHD/FlLRNJFoVdKb84TLUN0Gypv8
 x5gAaxLQdmtSpuP3/0zxj9z3+TpJeMZAlAdwt+jov3kZbL7s0rfo7sce7xGMpwu4lQOaNKiti
 vRBjJ+iQhDTMwBSfZu9c7NelHjTCz/P9lEr/O4eu9oJmuE+phCzON+2pjvUM4tMiU251uuRg7
 vxmGd0ano7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-902831370-1553178617=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 17 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Fri, Feb 15 2019, Jeff Hostetler wrote:
>
> > On 2/14/2019 7:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:
> >>
> >>> V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h
> >>>
> >>> There are no other outstanding comments that I'm aware of.
> >>
> >> Not a comment on this, just a follow-up question. I started looking i=
nto
> >> whether this could be driven by config instead of getenv(). A lot eas=
ier
> >> to set up in some cases than injecting env variables, especialy if th=
e
> >> log target supported a strftime() string, is any of that something
> >> you've looked into already (so I don't do dupe work...).
> >>
> >> There's the chicken & egg problem with wanting to do traces way befor=
e
> >> we get to reading config, so I expect that such a facility would need=
 to
> >> work by always trace record at the beginning until we get far enough =
to
> >> write the config, and then either stop and throw away the buffer, or
> >> write out the existing trace to the configured target, and continue.
> >>
> >
> > Yes, I beat my head against the config settings for quite a while
> > before settling on using an env var.
> >
> > I wanted to get the:
> > () full process elapsed time,
> > () the full original argv,
> > () all of the command dispatch, run-dashed, and alias expansion,
> > () and for my atexit() to run last.
> > So I hooked into main() before the config is loaded.
> >
> > In most commands, the config is processed about the same time as
> > parse_options() is called.  And we have to insert code in
> > git_default_config() to load my settings.  This happens after all
> > of the .git dir discovery, "-c" and "-C" processing, alias expansion,
> > command dispatch and etc.  And the argv received in the cmd_*()
> > function has been modified.  So we lose some information.  (I tried
> > this for a while and didn't like the results.)
> >
> > I also tried using read_early_config() various places, but there
> > were problems here too.  Too early and the "-c" settings weren't
> > parsed yet.  And there was an issue about when .git dir was discovered=
,
> > so local config settings weren't ready yet.
> >
> > I also recall having a problem when doing an early iteration with
> > side effects (or rather the early iteration caused something to be
> > set that caused the real iteration (in cmd_*()) to short-cut), but
> > I don't remember the details.
> >
> > So we have a custom installer that also sets the environment variable
> > after git is installed and haven't had any problems.
> >
> >
> > I hesitate to say we should always start allocating a bunch of data
> > and spinning up the TLS data and etc. before we know if tracing is
> > wanted.  Just seems expensive for most users.
> >
> >
> > I could see having a "~/.git_tr2_config" or something similar in
> > some place like "/etc" that only contained the Trace2 settings.
> > It would be safe to read very early inside main() and we would not
> > consider it to be part of the real config.  For example, "git config"
> > would not know about it.  Then you could enforce a system-wide
> > setting without any of the env var issues.
>
> I haven't written a patch for this, but it seems to me that we could
> just start reading /etc/gitconfig via some custom config callback code
> early as e.g. 58b284a2e91 ("worktree: add per-worktree config files",
> 2018-10-21) does for the worktree config.

Oy. Oy, oy, oy.

Maybe use `read_early_config()` instead? That would be *a lot* cleaner.
You could maybe use a9bcf6586d1a (alias: use the early config machinery to
expand aliases, 2017-06-14) as an inspiration.

> It would ignore everything except trace.* or wherever namespace we'll
> put this in, and "-c" etc. wouldn't work. We could just document that as
> a limitation for now which could be fixed later.
>
> It wouldn't make things worse, and would mean you could easily set
> logging system-wide without needing to inject environment variables in
> lots of custom (and sometimes hard-to-do) places, which I expect is the
> most common use-case, and is the one I have.

Yes, I agree, those are good goals to address.

Ciao,
Dscho

> > WRT the strftime() question, we could either add syntax to the
> > env var value (or the tr2 config setting) to have some tokens
> > for that.  I just stuck with absolute pathnames since I started
> > by copying what was done for GIT_TRACE.
> >
> > Jeff
>

--8323328-902831370-1553178617=:41--
