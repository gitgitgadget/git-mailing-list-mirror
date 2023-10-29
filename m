Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CDBA35
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ev6nS53p"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E6B0
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1698588854; x=1699193654; i=johannes.schindelin@gmx.de;
	bh=QFSERw5FePPexSDbRhESOGkbDvNaCfulKwzHs57hXnE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=Ev6nS53pAL3f42cRaTrCF509nQ+p9x6j893kMDmREAxCA+wOSrundG/YlMCrAAFI
	 0WPi2cpJ0Tg1bD8QcUT5Fvtz+TGTFz41S28U0qNxynpdpqNpV7qpps66AC8mTTazo
	 9jeWLDpPRo+e1EkZ+a1I+D2XrkPvfTwETaEJ1oBAKZQya8dJB5voLO9D58N2RTcQq
	 XS7DaJv1+fn2bhxF+FPAG/ottoLHPFsW99eh0A0880SxJgooVpftmKMGBltsVwGI5
	 lzq55JVDRzfHTmCTwkP6qTHKlgVw6q7zrYBR8ol7A5W4dg3Rz2avP2h4mC/0+iWPy
	 uqbqSdblRlgfd/U1vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.28]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1rNbbK30ue-00iEBt; Sun, 29
 Oct 2023 15:14:14 +0100
Date: Sun, 29 Oct 2023 15:14:07 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
In-Reply-To: <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
Message-ID: <e04cfbdc-fd28-c645-8f5d-132f7ceec6be@gmx.de>
References: <20230907092521.733746-1-christian.couder@gmail.com> <20231010123847.2777056-1-christian.couder@gmail.com> <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-465570248-1698588855=:542"
X-Provags-ID: V03:K1:uL+BawcMxPlaNit+XMW7X+N8LpxMVCtaGFVqzNqjo1C8K+8FUmj
 iTdtLWHlpuT0sRaXDmDhHTidIJQzYMi649oaUAcY5qay28Bko5F7M0wNe3Gnt7BGvrWRQC5
 u2V9/QQCPA45ZpomeqNvP0Xzp+Zrivd3WRKuZHzsgNgmoyAhKm3gMHO1pO4urV1elgWrSHF
 PUx8OQFcpnBLs+CQs2wwQ==
UI-OutboundReport: notjunk:1;M01:P0:jPoRCWTtm3w=;5UFEXcpoBTXR4Xc5ToAdrasOja+
 at9Ovmdq8SXAPASEuEgmFe4upsdmZG1ICJb2VruUA4YLHJCj4SrcMvYFXHl802T3gSAkqmKbA
 BTTgZXoOvO8mnz1PsdcUfqCvZrdVJ1tA7zJVBtJV+DyYCsFjmB1Hi7msI7ZyWVXYDqpAsxnPj
 yhDJzmjIEswzIms6A7Lalm2Q0/Ri7u4upgX9NcLtNuxNaayb00/ywe8Nkg1OJAuVlpI1c81hy
 qXb9Efi/97W+Wvd6naLi8Cl3OgRRrz8ZKjWH9X59KguZYJE8s6SSV3qPJc01WdzPQDmFm4Nyj
 lYIjpxD8ibajXc/SjqQpAitQItdqfqv/lhmpSj42AWRqORwHznJ7fwgoB1ctmVfOrpAfDgfD9
 6womLsINA5SzhYaRVp+mydTyXTVZLanFVqrbTirJ9Bkr7o3JIqk1lti5UfbW1ILPDKhDY/U2Y
 reNLGAkn8txxEZKBM3Rdhs/x0QXqC5jSgxD9iP843WMqd0vLeyiJ9fPBIAGBiHQ8sVXgUwoR6
 8hbNBjDFMbOi4HNRx1UDcXmvu/1ePEGJTcuhf5oraI9KxYi657wYNdJE4p/lzvx7AiTt6CfvV
 qvLejWfR/luKlA5KrYx5WMaAO4NIu46vCimJEVBFsE9tGOW+NMfcVPHmpKxgMhMUGfYEWaMng
 KxEWh0p09MrFbISpcftD9SSVoZ82vZh1dbSRWdjyuH6MFAZ22XE6F7pyZbBxJVea6S6SBMQYi
 jv78PZcnwc2DWj9xL5kaQyTBLa0NZVZocSwuS/54C195cmWk3+rzUSAUfCathsLx52XoO5pMD
 /Z+8ANiteZ2900ANxcta1qUUvmi6HnToPPdaLVYzedRpBEPgVX/luckKDVzoZK6Siq7nj7Mw0
 mJHpeAPK+MpTsEA0zzuukIBZqq2HWlGIIjksA8J8ihMnrMQUTxPvDZm1ChERnVpD2YFwNZVCD
 /H1Vsw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-465570248-1698588855=:542
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Sat, 28 Oct 2023, Elijah Newren wrote:

> On Tue, Oct 10, 2023 at 5:39=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> > * Patch 12/15 (replay: disallow revision specific options and
> >   pathspecs) in version 4 has been removed, so there are now only 14
> >   patches instead of 15 in the series. This follows a suggestion by
> >   Dscho, and goes in the direction Elijah initially wanted before
> >   Derrick Stolee argued for disallowing revision specific options and
> >   pathspecs.
>
> [... snipping many parts that I agree with...]
>
> >   Also instead of forcing reverse order we use the reverse order by
> >   default but allow it to be changed using `--reverse`. Thanks to
> >   Dscho.
>
> I can see why this might sometimes be useful for exclusively linear
> history, but it seems to open a can of worms and possibly unfixable
> corner cases for non-linear history.  I'd rather not do this, or at
> least pull it out of this series and let us discuss it in some follow
> up series.  There are some other alternatives that might handle such
> usecases better.

I find myself wishing for an easy way to reverse commits, if only to
switch around the latest two commits while stopped during a rebase.

So it would have been nice for me if there had been an easy, worktree-less
way to make that happen.

I guess this would be going in the direction of reordering commits,
though, something we deliberately left for later?

Ciao,
Johannes

--8323328-465570248-1698588855=:542--
