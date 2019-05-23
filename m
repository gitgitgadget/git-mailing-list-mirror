Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E461F462
	for <e@80x24.org>; Thu, 23 May 2019 20:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfEWUzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:55:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:37421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbfEWUze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558644918;
        bh=UVs/2rBU/MOWblEquVOF6glZ7QgZImUVM2PTuSA1s54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WiBe3SU7SjwNYCh6wJ3gFFLSpyNaQ72AIH82PP73jevz34UqQRkH2NA0IFkLtcCAb
         3XOHmjU0ujK3O6oU9dCwj5+sWrIZvmVRsT9emyy/AJTxyl4F3mA+Wu7VFDphlT6fjJ
         H3sKuLRjkN8AAP56uOKuDC8GO7UhDAfZOxi7c+Ok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH4Os-1hP1BE0XqM-00DrSh; Thu, 23
 May 2019 22:55:18 +0200
Date:   Thu, 23 May 2019 22:55:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: RE: Issues with t7519.19, was RE: [Breakage] 2.22.0-rc1
 t5401-update-hooks.sh
In-Reply-To: <006401d511a4$bdffbbe0$39ff33a0$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1905232254200.46@tvgsbejvaqbjf.bet>
References: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com> <20190522004825.GC8616@genre.crustytoothpaste.net> <004301d510a4$bbe362e0$33aa28a0$@nexbridge.com> <nycvar.QRO.7.76.6.1905232203130.46@tvgsbejvaqbjf.bet>
 <006401d511a4$bdffbbe0$39ff33a0$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1079695625-1558644919=:46"
X-Provags-ID: V03:K1:eG2lty5SDmmvDIS2LKxWcO8DRAk7N5D1mjT0VrJHjkaNaDVfLtC
 yJVo/lBa9GqjamsI4ryWp3UNescyeC9/jsTm5QVYstjDWN+653LWAqDcKs40JuWGTk91x9M
 pcKrt64cpz+9w6nl+YYq9+NJSkR046CTID9agVtVTGhleiz4BWbyCgYni5DrJsFajU/pvsQ
 q5aXLTFBXvXvkQqJVezug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTdJu+UjM8w=:r8WHRdB23jH2LztAoAWNzZ
 luWRKP+uXcnGxNyyLQ61MV09tdP2ysx61mtIT8Ilo69oSq7jfc/gfP28bTNJ26h9ZzSk7TmhB
 XdSCeEcZ+wb1w3N07BruRm/qVdwyDohy0bueHiVN8DLZTVMuPI0Pi9RJ34O2Kg8ArHmR5e+MI
 l5/ffoxFo+01q5eqYggMufFAUo8D2pl8FGWp1ABqzoyvF3Iv5edi6BA9e/z/O/Lh8BuSVQjXP
 Hp1hMSmT1MouTX/cLcXzJ5CzJRu/ggHHPa8ded4pyILSJQgRd4RiMpYw2webrwCwJ3DYHONr0
 LUJAwyYGMf77udVqgEX8SLX9snxHwheNm9ZPMBrroOIZcqSw5SEegNWkoj3dBIqRh7JD0BP08
 i2nGq75pYScrQl9QZaR9ZRi2Pa+WZfbGOEo87h74XdHsyFBRVIqTxrnLQns3N1ivHhf0oLaF6
 g3F1ctvE6N7Hu587VAnmUSE+jreo/QaApIz+rtgKNKsauZG9I412twodMs73EWogB0i8TA0dW
 dIYJzoUnQJPsK22ijWnIWprkS7hwzsSJTZ/jTYEQ7jHHJBz9S0RZaSjUk4ckziynucSZywq9E
 RMPnhDBS6i2mZwPBd2Joo6wvAbHIj50l3Th4AVsPjiHT2Q1vRY4xY/UafS1M1eeRR2sMqlJ0M
 nmYWLmYGgfFGTSDbed8sJ4MDwT6BjGNvRXOB8qoYXIDapXNuCLBKXaLejLzcQQr+pegCb2MzQ
 bggKWIwEp+faDlLt2zCKh91uO1CbeLaYEThrmzroRvX7w3zxelbGmK3TucYQMtWj8ciZJrnsa
 kkuOfSKh3Iy20XE9kKUNDFpwJnNs7Sd6Gb5WOwSbtT39tKu2x5aYw5YU8YB9iIxbpt+8rCIhu
 /vDBFpBBwtny5sSrfTKDstW/Sz6zJl80GGouN+Ah6GyjUm2DD/faOmCe39Ao0auOBW0R8up4T
 IAgepMuUDjgiOPEqnC1WoDu0tr4aN6QRaepxpZH5xkNXjRTmk6Bpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1079695625-1558644919=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Thu, 23 May 2019, Randall S. Becker wrote:

> On May 23, 2019 16:06, Johannes Schindelin wrote:
> > On Wed, 22 May 2019, Randall S. Becker wrote:
> >
> > > On May 21, 2019 20:48, brian m. carlson wrote:
> > > > To: Randall S. Becker <rsbecker@nexbridge.com>
> > > > Cc: 'Git Mailing List' <git@vger.kernel.org>
> > > > Subject: Re: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
> > > >
> > > > On 2019-05-21 at 21:47:54, Randall S. Becker wrote:
> > > > > When running the test in isolation, it passes without incident
> > > > > whether or not --verbose is used. So far, this only occurs on th=
e
> > > > > first run through. I wanted to report it, based on the
> > > > > inconsistency of results. This is not the first time tests have
> > > > > acted in this fashion, and I realize it is difficult to do
> > > > > anything about it without being able to recreate
> > > > the situation.
> > > >
> > > > Does running git clean -dxf cause it to be reproducible?
> > >
> > > I will give it a go. Having exactly the same behaviour in t7519
> > > subtest 19. I wonder whether there are breadcrumbs not being cleaned
> > > up. Will report back when I am able - may take a day or so.
> >
> > I fear that t7519's problems are *completely* unrelated to the t5401 i=
ssue
> > you reported earlier. I hunted the t7519 problems down today, and I co=
uld
> > imagine that these patches fix your t7519, too:
> >
> > 	https://github.com/gitgitgadget/git/pull/223
>
> From the description, I believe it. Timestamp resolution on NonStop is i=
n microseconds and those are not even slightly simulated. Coupled with thi=
s being an MPP not SMP, things can occur within the same microsecond, or i=
n weird situations slightly before or after when comparing the clock on di=
fferent CPUs. Yes, time-travel is possible at the single microsecond level=
 =F0=9F=98=89. Cores are synchronized, but our machine has 4 CPUs and sync=
hronizing the file system across all of them does lead to slightly strange=
 situations.

I tested my patches with

	sh t7519-status-fsmonitor.sh --stress-jobs=3D8 --stress-limit=3D10

Why don't you check out my branch, build and test, and then we know
whether it fixes your t7519 bug?

Ciao,
Johannes

--8323328-1079695625-1558644919=:46--
