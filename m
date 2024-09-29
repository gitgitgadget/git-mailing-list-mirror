Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48833F9FB
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631860; cv=none; b=qs3N/7rhqmn9guVoK0f1Fii73/TXZBfdrnfBcIu05Cf8lamEn7PW+pLRihRW1pAIdCnqXDiI16+c/4FyjwHX0QfNv/1nqCOQUp5weY+829ekjEnRQomPL1gNSFBQ7KUhAFZGpU3dNtNuvQZrOS0aM5x2xmaFtvCQVZk0E8Cwl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631860; c=relaxed/simple;
	bh=OwMVfpFvFcvvvR4BS66eKXnFCpw+HWYNThatlQmWEMc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rCJnineioLQ0raIWiE9UG5xQ58H7iUblNhFGBQydPmumGlZazcgsXNKSSibHMwbc3zmXMRGXbWzbZwqzwCeBNVRaqxbOOcxmygUbrR8TytSPYKT94eYh4RMBcXDo9RM33E7L+5nZ/1P/9fP5xwVd9hx1zO4neg+IuB24q/iNbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=A+8yos88; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="A+8yos88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727631854; x=1728236654;
	i=johannes.schindelin@gmx.de;
	bh=mpz8Zlw4XZw3xlUGR7WovEk7OVBNbNGwCMbUKduUFiQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A+8yos888Pmhh811+WvtAHNoO3EN6idGpB/tmVYIul963lELmFwWEyKcyKy/Maif
	 1ue3KUCLZPQOiIk2kOvksOqejTYvwjDCd+jXwJLeKuNLaiHOOjTgeSIjTMC45KzDU
	 wNCCmF9bcec+B9AQruUAGIAkNNIKXhh7EoqS3/0bqE0sdnzb4Spyr0OIqWM/7pisp
	 hm+hud8aSC0jn5V6umL6aeoISxQ1nYV32zwzTA3tOTb6H1hzdhzQ7Dhv2PupjrNV+
	 QPpdMlJNY/ml1M0udVo7VSwpoTZi8rkuNB1avkuaKJuh4YUsSbxJks2zdM6kLB/tQ
	 FGndCccQ/6l6348j9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1s5kxE3Cdy-00tSVL; Sun, 29
 Sep 2024 19:44:14 +0200
Date: Sun, 29 Sep 2024 19:44:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Haffner <c.f.haffner@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Bug in git-gui
In-Reply-To: <67cf0658-f0ee-f141-534c-3081b818545a@gmx.de>
Message-ID: <d0c95c24-232f-196c-bf19-5f8ee89e246c@gmx.de>
References: <69e3564e-3314-4a6e-b489-11a96022e08c@gmail.com> <67cf0658-f0ee-f141-534c-3081b818545a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1462381439-1727631854=:116"
X-Provags-ID: V03:K1:b/AAz2Pscs3YhAUi+mHRK2VLTqYMQfrpMDD7mF02KRZ+Q5L/No8
 wJu4gW0Rb/6PdiaRUsVsmkhCGXaFdIkB1ysWFnoTeBHW0cf0mcqIcjXKRKUylr8Rr2ZgOn9
 qfSA71QFX+bQ0S8uWT5ncgBEvoTT/N33IA2KBHofowHaY1DRBULvA69mygN3IZkraK2ln7x
 C6QYQxz1rP8y3CRuHrgYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qmbVoLURP/4=;N/4DjrSdvp1zk/VHtETPa+26DUx
 ucYvs3SUhth1TXD6gLuai0aG2EPu8hwvrOARQF0BPImEjB36y7Is2RWqJgZ4d9RbqFPynU7eU
 3fqcPmTpXyETMPliMX/9pO30HRXS4W2KUpaIxDEabnjgx2aSEAKBCjP8AQwcexBwPQSxs1QD3
 K6VQHUWIgBDVXbm/hyJ1EbXBx1+P69M0cMTbTHm0kKerwonKm5KBRJOnzHOep+A/N5M/eHZ7S
 RLDpVlDO6SczWsHhsc4eL5FW99mvapt7nAKklTOB/9wwElXmoyoCAlPDhyQsrcUGewBDXr5O3
 ORmhrr8Kf2EYyaGiaUkYdn33MkZYtBAomX3mP3Dq8+O3dvnUFvTDuwSDck+efVnFtaeMUzg9D
 kffUY99GVVrCjcshAwOQwxr977Wyqc8w2grnFZ38jKOnY1i7R6GhfC4p4yiIMjlEXoUHVLwrg
 Q1MDtxIf5i5GrJSk9kJcZWZRdgMO1rGBCf2nLs3sEOnCdXh5vMajesrpuRDlezhIV+GsWsyZG
 94KG7nB9yi6LZEVtZrU94Vq7NiuQ9GUFuqkvrIncT4E7e2uoAh1RA/qp6go6mdr4hG9t4pKfz
 m6bFnOfMP8d1yHW0KLgDL5vVEm5T4sRDXZ6J+I09i7Sqe5MbqZseI5BDzbMOtuLvuagJxGwBR
 kDcf3iLUXO+ynEM6IfXW7cCiLQYRwGDP9lR9wij3EmMuGorJf8omLkWfgF5X9Mgo1H/vGpjGK
 RuB+GyyfXwRMH9Da+mxVkVAKEELZQjFIFr1jzp3GoMDC8TnYsUN9XYfLpIq5KcQZsjTlk7fvk
 4rdRkkIb+8dw8ZFvTMndrdNw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1462381439-1727631854=:116
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Clements,

On Sun, 29 Sep 2024, Johannes Schindelin wrote:

> On Sun, 29 Sep 2024, Clemens Haffner wrote:
>
> > I think I found a bug in git-gui on Windows (Windows 10 64 bit)
> >
> > git-gui Version 0.21.GITGUI
> > git Version: 2.44.0.windows.1
> >
> > To reproduce: (I have not tested it with rsa keys)
> >
> > - Create an ed25519 key with a passphrase (--> .ssh/id_ed25519). Help-=
>Show
> > ssh key detects that key perfectly and shows the Public key to copy
> > - Push something to a repository:
> > --> it will fail.
> >
> > >=C2=A0 Pushing to xxx.xxx:clemens/test_repo.git
> > >=C2=A0 CreateProcessW failed error:193
> > >=C2=A0 ssh_askpass: posix_spawnp: Unknown error
> > >=C2=A0 git@git.xxx.xxx: Permission denied (publickey).
>
> This might be due to the `SSH_ASKPASS` environment variable pointing to =
a
> Unix-style path, but your SSH not being Unix-path-aware.
>
> Can you verify that your `SSH_ASKPASS` environment variable is set to
> `/mingw64/bin/git-askpass.exe`? If so, can you set it to `/c/Program
> Files/Git/mingw64/bin/git-askpass.exe` instead and try again?

Oh, make that `c:/Program Files/Git/mingw64/bin/git-askpass.exe`, i.e. a
Windows-style path but with forward slashes as directory separators.

Ciao,
Johannes

> > >=C2=A0 fatal: Could not read from remote repository.
> > >
> > >=C2=A0 Please make sure you have the correct access rights
> > >=C2=A0 and the repository exists.
> >
> > - When using a key without a passphrase, it works perfectly well.
> > - When using ssh-agent with a key that uses a passphrase, it also work=
s well.
> >
> > >=C2=A0 Pushing to git.xxx.xxx:clemens/test_repo.git
> > >=C2=A0 To git.xxx.xxx:clemens/test_repo.git
> > >=C2=A0=C2=A0 =3D [up to date]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rev1 -> r=
ev1
> > >=C2=A0 updating local tracking ref 'refs/remotes/origin/rev1'
> > >=C2=A0 Everything up-to-date
> >
> > this bug must be in git gui, as it works perfectly fine via git bash.
> >
> > "git push" spawns a new window, which asks for the passphrase. After e=
ntering
> > the phrase git works as intended.
> >
> > It seems to me that the git gui cant spawn that window where it asks f=
or the
> > key.
> >
> > If that helps:
> > I'm using Microsofts OpenSSH implementation:
> >
> > >=C2=A0 $ ssh -V
> > >=C2=A0 OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2
> >
> > Greetings,
> > Clemens Haffner
> >
> >
> >
> >
> >
> >

--8323328-1462381439-1727631854=:116--
