Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F02C433E2
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBC620717
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kzrJwcpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQKz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:55:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:39017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgGQKz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594983353;
        bh=BaGC7ETf8GeRQYGVnEzQtqIaO8HLQu6YPcOmzbSSICM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kzrJwcpRa7f/pgnV75De9d+rdFQVURM8h5OWgQMuY8G7QpYcF/dFy3adO8SBejtHo
         8+7h5+MHS+BVOOdwkNCZD0+MwjmU/v2+c6Vnu52XNmZbfOIThB+Xt/9EI00tI6Vz8D
         YbtkeOE1HYuAhVrZgaKjdBmNTGcjhDwdCOw+Cv+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.213.77]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1kaAY73vON-00nUNx; Fri, 17
 Jul 2020 12:55:53 +0200
Date:   Fri, 17 Jul 2020 11:29:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.28.0-rc0
In-Reply-To: <CAGyf7-EAQ0D_fqaRNa5YdQGoTO535=45g+Hyn9Fo5JAxPMkE6A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007171102170.54@tvgsbejvaqbjf.bet>
References: <20200710135935.6416-1-johannes.schindelin@gmx.de> <CAGyf7-EAQ0D_fqaRNa5YdQGoTO535=45g+Hyn9Fo5JAxPMkE6A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uefZzMyuC5KvjYMBt3JoKgq/vL3lhtb6IsRsV/bbeCf2hejML4C
 Ow+LiYDw54lazsPeCySTXTM0Q2WMwfIFL06OTPD6zGoCDAhGhwVbrjP9JgeWJxh6u26vM3D
 IBXPcMlLVQLY4a1N1BLSgarO1pdfKOFPuHdZ8K/m9PwztVETb1gcK6QhwcxFLl+ziD4TzGt
 TXgEkp0+SG+TfWNAiwpLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E6+tFNtL6o8=:L26BDzjSmiiwLm8vrP+dKt
 wnDRi+bUifBF2e8A7Eq/u7U3H0djRcO77TCpruIzyAiU92+VAvCiaqQRVuOdB4tbsDmUcN+96
 EHWwHLsF98W1A2TUMCOsJdPCGb/gfYDif9Ns5KOhUL2UEFpkM4tDVDszUAl0W9rlAC3M9CpQS
 r24oOkXa9SscCdNPBJ27ow5fNFuKpXB5PiZX5s3HIXtfxomc8yHG32Wyf4anbhZsEZxOhJboY
 sQoOWMVepmWGQhJGX5tKSFBreQneWQiG+ZYbJqojCeLBAMWDK+/7t/hxSVT0FBpS9ukv6p63v
 yJLD2OeiWRmOZ4QqjNAog1H6i0FnX6Qgbq//pkL46a7lczBybmHsr4TR8tFi3X0RiLFjqPuJn
 d4+x2BpwXrb8ZmZOkHCmg+AhbYqL5DiW22JYYY/TQl/abEXjBVH2BlZSkfki0AGQYCAjd5Gbg
 RMVZ+4irJmF6jn0K6QM8ALxWcWLQnv8NPgituds3u3DR5Z11DL9FHSOSAL3HSM4US561n3juw
 3bs9gFF4OMNG9xX3AOFxZ77gXb1hH56FklODszygcmEE3rXDFAfllVqCLKXjR01xbxG2SKUaC
 r6jtHqxBcGmaaBWi9/yrS4HoivXYg3CA7sZDOK6rNzTv9ycMDkPctRemKaojQdXC3tDFKo1Xi
 NqMPPpzjD34mrZ/S+tlXd1qTMli34eF0csLnwTr37fiIQ2JRbYJI8N9SeBzHxIWhG56ocCQMt
 /JbIX3jyHkr07RAsc8W+pq1veX3evEPtuLk60xPPsnJKTHerGyuQdxVEW+36Kv5nrTM296KhG
 d2xF4smAT+tkHHeCPFyNP47szFgpyDLTMpzLoMyU2zifTxitojbwghNiirobUf7EanpxqoAWe
 NteXudxcL/qw9lowe3xXVo0qAfYwkjs65YTm28cvXPt/7X4qZ08JCFUDANrkhTV4OK0ZG0twv
 iFEsf0OPveDRYtCwGqphtlLH/hEBAMzkbNVHoft2mBExLFp1sGlZPQeiggFCH4wgPwbLUwndQ
 b7kQyw5qm/nBmU4CWBXS7uKC3vprCtJLgj4Sx9yvR9aSmVdQyDrDD2WMhDqWXW/SalOK+UCCI
 aRvdw1esFxEO2R0O7ThiTRrjHc2vQL8cnle0BYHNWoXUw61l0LCTWnbw2rQyC5mW4H+fspwEi
 gzKNkN47LTNxam50iETyScGJ9TvZanfV+2uPArkErhNhwJ4gPFzNtWwSDRT2nE7UUOosWicBb
 aMpTe4i/5+KJ4d1xcQ1rZUKEMHqombkm0l0w9ZA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Thu, 16 Jul 2020, Bryan Turner wrote:

> On Fri, Jul 10, 2020 at 6:59 AM Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >
> > Dear Git users,
> >
> > I hereby announce that Git for Windows 2.28.0-rc0 is available from:
> >
> >     https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc0.wi=
ndows.1
>
> We've added 2.28.0-rc0 to Bitbucket Server's test matrix for both
> Linux and Windows, with all tests green. We've also done a manual test
> pass on macOS, also without issues.

Thank you for testing!

> Thanks again for these early RCs!

Of course!

I hope that v2.28.0 will be a bit less bumpy than v2.27.0: Git for Windows
v2.27.0 shipped with mismatching Perl/Subversion, so that `git svn` was
completely unusable. Yet, the most reported bug (and to me it looks like
it is the best-reported Git for Windows so far, since the project's
inception) was the typo `fast-forard` in the installer. It has been
independently reported well over a dozen times, via at least four
different channels.

Just a quick note: I will be offline for most of the next three weeks, but
my colleague Dr Derrick Stolee kindly agreed to prepare the -rc1, -rc2 and
final versions. For technical reasons, the announcement mails will still
be going out under my name, though.

Ciao,
Dscho
