Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251938DD6
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631795; cv=none; b=FSiPotmPB2Ln0KJYYq11+6hp49zgG28JvJhftvkpMaPBbPu2tB7DZ4gJC7EJtWiIoB39ZHFDYYLryTr+6leSgmxCbjbucB7vpgfvBXH31mdpAxOeGXgpuroRUOQnAcSBMPUHod9guU0yC0gcnr46uktGgTEB4kkIKisH/PMon58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631795; c=relaxed/simple;
	bh=F5nAjyh6pyl5G2M2CYoQy1pDckPLvqfQvgFijziNNjU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wkbg2kOj7ICg56VJ6lIo8btAPorjJWKdYiHkPL6v+xkqUV2chFnJG28eDdd5xZ0fsb2BAW4IAjfdvd8NRzUzwmeVfedHRZIgozg3DPtyway5QNYGXVrz9VWfwJZmx0xIjUnlumYQ3tSp0Uiy7+9ybC/wuKQQZmh/Z3xdnH7ChtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=T8zVNXNW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="T8zVNXNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727631788; x=1728236588;
	i=johannes.schindelin@gmx.de;
	bh=VVM96PGluE87cCrrIE5L7UTQ4eZgm3DJo1HI0VWXWG0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T8zVNXNWe9BMacqg4QGgVg36r/J7+PgjVg/eweHoymZhx8hO6wQ3V1Q79x3837Mo
	 ovBgvJvjH05IyFr+99BNm4oCKtV1cLQ9FD8hTkFi3CRv2farbmM5iJHjP7WFhqJd+
	 gMKe4W91LpHmsUgcPeg0bWpcrIkwdWaLrqka9e4aBk9yfF2o1DoH21tE0gU5J6Nxf
	 suzogUmLK2kBBmJg01s1ChMYjTF92jtaq+/EV4QE/jA4AA9wHrY6tI1PEqWWcy8Vo
	 eyISNRHo78HcTbRgg8bCNCBHraxJ2YRcM/eNjw6gSbjavT9l3m6D48eW+sis5qgJE
	 cBXKYEM7I8WRCkjLpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1ry2nx3znW-00t7YA; Sun, 29
 Sep 2024 19:43:08 +0200
Date: Sun, 29 Sep 2024 19:43:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Haffner <c.f.haffner@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Bug in git-gui
In-Reply-To: <69e3564e-3314-4a6e-b489-11a96022e08c@gmail.com>
Message-ID: <67cf0658-f0ee-f141-534c-3081b818545a@gmx.de>
References: <69e3564e-3314-4a6e-b489-11a96022e08c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-653076809-1727631788=:116"
X-Provags-ID: V03:K1:akUvSd8RQtlFOuQyRCXfjAC+zOYVlqHpl7XA3I+p5zySaVk/FUb
 NUHsk5ATcoL+nura1aFKtRl/cUwHlQd9nPOc8OT+T1rVhUH2IfEr/6j0Td9D0F7FlUZZtBs
 q3DdFphMLJTj5daJmsyUVJIwLp0nbz/ysnHZXLo3RFTK6Kv45bUbFUnG/lrEqXt/eV8kuKr
 NrRLGWfsrhJ1/cwfKCIJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z+kKvDZW7L0=;QM8+NdE6Cuwv0ryxgQe5DydDKQW
 Prr4FMpy2Nnflfwj9aM1Es/cKuiKl7UI2ZTnq/Z9a1M4YZVptQRfeesK44BbyWEWhXcdebIR1
 d2xqrHq0pxAMDCkgdx0dRloRPB0TzjNv6lYmmt4p9RkiLgVrghTaL/zkw34V4E8NWn1ATBQPW
 gjukNzSw1K9OwQQ6/8RphLNeVHkF4SobNI5GwAmzqLDVJWVq6gAtT9Ke636TKqBBuNWjbXyiE
 73oQJtLXbFRYiEiIlxiOjZzW07034cTbxdG4yjneMJJlQ0dSFx5vL2RXcVtlhD9Y3LQ7QR4sy
 dZsDZ1Niq9C62F7Ei9yorMTASq1HeQDa5l6NuFGox0gTEClMShmJUfDWYk2bx38jO//mKrvwu
 to36DaQxDeh6CBeOe7/S02SMGPCXiHLm6/EcDEdXrCD3Kc6SHHkRdsPyDhbdnqq8IFoWPKJaV
 M//cs2U/J1w0fBYVnDZQvJ6OzacD7yoIW03Jw9IDQpgXtUDlqUmez7Ss2n+E9RmMFFASP9hbQ
 kk14cQXvsM4Fnf1Z9HWnTFvj20jkti+wt+19J2AAqPEvfOE1ShhVdWLQVmjCL3A3POSAcKIg0
 dHbXPfMmTQu2O2gJtGht8KTKFp0JvRz91yv/Ha8XbrjfkcOA9Ln0W+Z3aV0VYVqdhBXDW1AiT
 IUWCJerJ+jbka7KqteET+ccZEB/w5NKqDLZ1fw26NcNr2LxOMXzDMWg52Loa6YTDRtOZVdT9c
 6KnTSny4SiFITkUya9EI1bUwSU2a+IWm33oAMC36+HW0zLFm+VcYtqHg70SrG9YQ0yA2VHO7r
 LeC2sPr/e0v0lpx4krgtrhJw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-653076809-1727631788=:116
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Clemens,

On Sun, 29 Sep 2024, Clemens Haffner wrote:

> Hi,
>
> I think I found a bug in git-gui on Windows (Windows 10 64 bit)
>
> git-gui Version 0.21.GITGUI
> git Version: 2.44.0.windows.1
>
> To reproduce: (I have not tested it with rsa keys)
>
> - Create an ed25519 key with a passphrase (--> .ssh/id_ed25519). Help->S=
how
> ssh key detects that key perfectly and shows the Public key to copy
> - Push something to a repository:
> --> it will fail.
>
> >=C2=A0 Pushing to xxx.xxx:clemens/test_repo.git
> >=C2=A0 CreateProcessW failed error:193
> >=C2=A0 ssh_askpass: posix_spawnp: Unknown error
> >=C2=A0 git@git.xxx.xxx: Permission denied (publickey).

This might be due to the `SSH_ASKPASS` environment variable pointing to a
Unix-style path, but your SSH not being Unix-path-aware.

Can you verify that your `SSH_ASKPASS` environment variable is set to
`/mingw64/bin/git-askpass.exe`? If so, can you set it to `/c/Program
Files/Git/mingw64/bin/git-askpass.exe` instead and try again?

Ciao,
Johannes

> >=C2=A0 fatal: Could not read from remote repository.
> >
> >=C2=A0 Please make sure you have the correct access rights
> >=C2=A0 and the repository exists.
>
> - When using a key without a passphrase, it works perfectly well.
> - When using ssh-agent with a key that uses a passphrase, it also works =
well.
>
> >=C2=A0 Pushing to git.xxx.xxx:clemens/test_repo.git
> >=C2=A0 To git.xxx.xxx:clemens/test_repo.git
> >=C2=A0=C2=A0 =3D [up to date]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rev1 -> rev=
1
> >=C2=A0 updating local tracking ref 'refs/remotes/origin/rev1'
> >=C2=A0 Everything up-to-date
>
> this bug must be in git gui, as it works perfectly fine via git bash.
>
> "git push" spawns a new window, which asks for the passphrase. After ent=
ering
> the phrase git works as intended.
>
> It seems to me that the git gui cant spawn that window where it asks for=
 the
> key.
>
> If that helps:
> I'm using Microsofts OpenSSH implementation:
>
> >=C2=A0 $ ssh -V
> >=C2=A0 OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2
>
> Greetings,
> Clemens Haffner
>
>
>
>
>
>

--8323328-653076809-1727631788=:116--
