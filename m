Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365AD528
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500202; cv=none; b=Mhsm4iOdJeUzMSKmCS/DJzRD4yhRx4HAftdQ30HYgGP/5nYLSnD8+zyy+ijFOUb6oZrr3swcVurSUcgPx+aMcM/vrPoaXJ7j38TUGuQIYkOFL+9+naFLcGZeDrdXhoJjMixw4pVaLKMtWQUgT/8AxwjUp2xuW/errWofhdmZK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500202; c=relaxed/simple;
	bh=F4BlpRbMWNsu4kIjfmiAAh5N4lJ9ySOZTZTZL4zvcGU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ncvn8YHJSnbKEzIyA+JihAO0mqs/ZBURzgQd57AZvVHgsj1EMEsPqco5wBGN4iHPO7G05dEp8ujDI8vzE4AM3HqPjr8b5LVMyQ1BU0HuutKYFfzWSQbZsJyPnRhq7BgzpfD3eYgjC03Uqk9WwC63bkWCvjVQdkcM6L+nRIcPGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iD6gVZ9K; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iD6gVZ9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745500198; x=1746104998;
	i=johannes.schindelin@gmx.de;
	bh=o4DBXXOR7RLf+cwKJ7PjlLj0brevAU7U5KxgsW7dueI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iD6gVZ9KgxhLsxo7f8fKQZU5ouPp2HsgpsU8BhEzBSuJelJ1KHdn+B1SVaQVFpg3
	 qNu85q+2YSiX4zFfZ/RXOGuGPvolDGdcieTAeRbW483yuqIxcXx0dcWHVlBOVSXDn
	 HT8kT4LavWJRzGQDBaSm0qHUg27qA47QcX19dtHzRhKT1t5z11WHS+YEhnz34HWhq
	 iUa6UboVsl4gvwEU0TMPta1G9O91C5rySnrksANaJ4Nbb7yA/rSDbCpVg0iTZJbyk
	 xtW1tCZCG7GLS+BJuuvNKSM7soSt8p8pfVnGVXQTOK8qpUiO0D/lqHLaZ0yOnxqRX
	 mNvPb+n3xlVFyQRarg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.61]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1uXXpI3Z89-00X8Bj; Thu, 24
 Apr 2025 15:09:57 +0200
Date: Thu, 24 Apr 2025 15:09:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Hohwiller=2C_J=C3=B6rg?= <joerg.hohwiller@capgemini.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
In-Reply-To: <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com>
Message-ID: <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
References: <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com> <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de> <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-842748778-1745500197=:96"
X-Provags-ID: V03:K1:ru/jvoxZu+VLaaPvx9VCEC8Vw1Naps/zKtahim4iAXOPt5uUj3e
 mLRSw3FzbDTTDkvxPYevBlHt+M20kPKo7kD/7MQ1fR5vk7uG+h3m1Xh9L67oGtzos/jAnAD
 kb7yXW78tRZUziV2XixnOUTmLo4R+TxiK46H3v2daP4HTA4IWKjnnokTIrknkEc11HlFkkM
 hkK/HBHS2ZBBp6M2ssZCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DaVpvSI/vN0=;Uz2ZQ6SFJRwlvGISGxw01VvTFKi
 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
 FlSw=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-842748778-1745500197=:96
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

On Fri, 4 Apr 2025, Hohwiller, J=C3=B6rg wrote:

> Thanks for your response and suggestions.
> I downloaded and installed the latest SNAPSHOT:
>=20
> $ git -v
> git version 2.49.0.windows.1.7.g4ca71ba531.20250326122305
>=20
> However, the error still remains. I cannot pull my repo without the erro=
r I was referring to.

I should have clarified that you will need to remove the `.lock` file
manually, unfortunately, before trying again (if it exists, that is).

Ciao,
Johannes

> This blocks my workflows.
> There are workarounds like using `git pull origin main` manually in git-=
bash but it is quite inconvenient not being able to use git via IntelliJ o=
r git-fork without errors.
>=20
> Kind regards
>   J=C3=B6rg
>=20
> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
> Sent: Tuesday, April 1, 2025 17:45
> To: Hohwiller, J=C3=B6rg <joerg.hohwiller@capgemini.com>
> Cc: git@vger.kernel.org
> Subject: Re: [Windows] Severe problems after upgrading to 2.48.1.windows=
.1
>=20
> ******This mail has been sent from an external source. Do not reply to i=
t, or open any links/attachments unless you are sure of the sender's ident=
ity.******
>=20
> Hi J=C3=B6rg,
>=20
> On Mon, 3 Mar 2025, Hohwiller, J=C3=B6rg wrote:
>=20
> > I just upgraded to 2.48.1.windows.1 (reinstall via Git-2.48.1-64-bit.e=
xe).
> > Also I kept the checkbox to cache files (new feature?) =E2=80=93 maybe=
 a mistake, let see.
>=20
> If you are referring to FSCache, no that's not a new feature.
>=20
> > After the upgrade, I pulled some repo with git-fork and got this error=
:
> > error: could not delete references: cannot lock ref 'refs/remotes/orig=
in/bugfix/XY-74488': Unable to create 'D:/projects/projectname/workspaces/=
main/projectname/.git/refs/remotes/origin/bugfix/XY-74488.lock': File exis=
ts.
>=20
> While this looks different than
> https://github.com/git-for-windows/git/pull/5515 (where writing to a ReF=
S drive on Windows 2022 was broken by a regression), the root cause as wel=
l as its fix could be the same. Can you test the latest snapshot at https:=
//gitforwindows.org/git-snapshots/ to confirm or refute this hypothesis?
>=20
> Ciao,
> Johannes
>=20
> >
> > I looked locally (even in CMD with copy & paste of the exact file refe=
rence) but the lock file is NOT there.
> > I repeat the pull and get the same error, but no such lock file exists=
.
> >
> > To avoid external side-effects from git-fork, I opened a new git-bash =
and called =E2=80=9Cgit pull=E2=80=9D manually in the terminal.
> > This did not give me any error but gave me this:
> > $ git pull
> > From ssh://git.company.com/repos/projectname
> >    72477d57f026..de79f4dbbf68  =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> > * [new branch] =E2=80=A6
> >    ce3979d639d7..b80b70a56da7 =E2=80=A6
> > $ echo $?
> > 1
> >
> > So what could be the error leading to exit code 1?
> >
> > Almost the same happens for git-fetch.
> >
> > I downgraded to git version 2.47.1.windows.2 and after that tried the =
same again.
> > A difference is that now I additionally I get logs like this at the=20
> > top $ git pull
> > remote: Enumerating objects: 269, done.
> > remote: Counting objects: 100% (143/143), done.
> > remote: Compressing objects: 100% (41/41), done.
> > remote: Total 269 (delta 89), reused 87 (delta 87), pack-reused 126=20
> > Receiving objects: 100% (269/269), 59.37 KiB | 2.58 MiB/s, done.
> > Resolving deltas: 100% (94/94), completed with 51 local objects.
> > From ssh://git.company.com/repos/projectname
> > =E2=80=A6
> > $ echo $?
> > 1
> >
> > Looks familiar. Is it a bug or a feature that the latest git stops log=
ging these status information?
> >
> > I have various other git repos that continue to work fine so I now rat=
her think that this is not a general bug in git pull/fetch but related to =
the specific repo.
> > However, that used to work for years before I upgraded today.
> >
> > Status on that repo says:
> > $ git status
> > On branch main
> > Your branch is behind 'origin/main' by 387 commits, and can be fast-fo=
rwarded.
> >   (use "git pull" to update your local branch)
> >
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >         find-tests.sh
> >
> > nothing added to commit but untracked files present (use "git add" to=
=20
> > track)
> >
> > Sorry to bother but do you have any further hints or ideas, what I cou=
ld try to fix my problem?
> >
> > Kind regards
> >   J=C3=B6rg
> >
> >
> > ________________________________
> >
> > Firma: Capgemini Deutschland GmbH
> > Aufsichtsratsvorsitzender: Dr. Volkmar Varnhagen
> > Gesch=C3=A4ftsf=C3=BChrer: Henrik Ljungstr=C3=B6m (Sprecher) =E2=80=A2=
 Jost F=C3=B6rster =E2=80=A2=20
> > Felizitas Graeber =E2=80=A2 Vera Schierholt
> >
> > Sitz: Berlin, Amtsgericht Berlin-Charlottenburg, HRB 98814 This=20
> > message contains information that may be privileged or confidential an=
d is the property of the Capgemini Group. It is intended only for the pers=
on to whom it is addressed. If you are not the intended recipient, you are=
 not authorized to read, print, retain, copy, disseminate, distribute, or =
use this message or any part thereof. If you receive this message in error=
, please notify the sender immediately and delete all copies of this messa=
ge.
> >
> This message contains information that may be privileged or confidential=
 and is the property of the Capgemini Group. It is intended only for the p=
erson to whom it is addressed. If you are not the intended recipient, you =
are not authorized to read, print, retain, copy, disseminate, distribute, =
or use this message or any part thereof. If you receive this message in er=
ror, please notify the sender immediately and delete all copies of this me=
ssage.
>=20

--8323328-842748778-1745500197=:96--
