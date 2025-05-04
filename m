Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3A1B960
	for <git@vger.kernel.org>; Sun,  4 May 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746346751; cv=none; b=Jp7Cm2Y5BHqEwKv8k7RW8FKwoMM8FR7I6bHrUsp4vdzH7LON42Qq9BJhOOIZmHJAF8YhWlk7rc5HtGqSrg/0BOAY97dvZbI8tDlt/gZSZu//Q/K22h/i4X5I2GQhp/bxyxT6ZXap51bZXlFNElKek7YJCkWJcmPV46VbnKllB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746346751; c=relaxed/simple;
	bh=6QpZ4t+TRN7xmcJnDXmVj6dKMPOVefvt5iooWSWU1x0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j1ailbgRI5xgOgvcFi9untthbmvoLFrchVPHPEFrzATbA1wTAUTnkq6hZ3FyHPjSGwX0VDgJnXlkNLNilIfcLF59EFBU5UmxkY5GwrbojN3ekC/USxa71gXzRUCQDuev7czucocCNe+LG2wYKZVxfTyX2+bSRXRrjCiCQWGIocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=gV4zbrRd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="gV4zbrRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746346746; x=1746951546;
	i=johannes.schindelin@gmx.de;
	bh=XG8fEZCzdYMUMCcJr+262PYVcB3kxn12bwfAySR43rg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gV4zbrRdCRFWKggQqN4KFh5KXWyeAculzPTB9GRrkMnbNe7KvsZuunbY+fYxhMnt
	 +NYY8PLyTCJ5DWZTTR0TDtECcUMymONqAm6EAkiu2h7PfSlRhECg3ofP0iQVmMWyF
	 mF3CwqZGOp1sDUCQx9C2nI30Y7Mcd66zyspmGJvC2VlfSbCkJTrbGcJH+HCHIkeih
	 bfo7j9S19xn8D9w5n5H/mztF1+pS+u0PeGcx4s89nRzMmJhWh7K18ouEJie53DalX
	 T49eApXHpqS8UOjSwG+i6ZPcKPAqjLh9GNJ5wkDPyceC9OQrrTtIK3hKWl5K3K/p3
	 ErqAASqKQrKGLjCGLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1uA7eZ2DK9-003z7x; Sun, 04
 May 2025 10:19:06 +0200
Date: Sun, 4 May 2025 10:19:06 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git svn clone failed 
In-Reply-To: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
Message-ID: <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b4n6TS4iP9X0mc9dxDDgiz2FNpeZwEHO1I2sIQwBvojdgyO+h7u
 t/V0/j/0gxiGO5wKSbtDII+nV6lFxnG9Q1zMmtn6K5UmV4KFz031Z+NabsFhYkQwXWkBCUx
 R7r1cz7l79iRFYuf1QXgU+SvnKMKWP/9tLbuoE9ifcdIyhp4nosniGAqt88AnxuM7ncStR/
 6mcyMGyCQCDa8ul8trWlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gM2M5T+3yqo=;gm0r9s95wGoSlLQ6L4Z6lsawG9t
 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
Content-Transfer-Encoding: quoted-printable

Hi Arnoud,

On Fri, 2 May 2025, BERENDSEN Arnoud wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> - I was migrating an SVN repository to Git using:
> git svn clone <my-svn-repo> --stdlayout --authors-file=3DC:\path\to\my-a=
uthors-file.txt  --preserve-empty-dirs .
>=20
>=20
> What did you expect to happen? (Expected behavior)
>=20
> - I expect the entire process to succeed without errors.
> When unavoidable errors do happen, I expect the error message to be help=
ful, give a clear description of what the underlying problem is, and how t=
o solve it.
>=20
>=20
> What happened instead? (Actual behavior)
>=20
> - The migration failed with the folowwing error:
>=20
> r2814 =3D 1ecf20e2d14b45ee517b56f5f51b406801e9869b (refs/remotes/origin/=
trunk)
> Found possible branch point: https://<my-svn-repo> =3D> https://<my-svn-=
repo>/branches/<my-branch-name>, 2814
> W: Refspec glob conflict (ref: refs/remotes/origin/trunk):
> expected path: branches/trunk
>     real path: trunk
> Continuing ahead with trunk
> W: Refspec glob conflict (ref: refs/remotes/origin/trunk):
> expected path: branches/trunk
>     real path: trunk
> Continuing ahead with trunk
> Initializing parent: refs/remotes/origin/<my-branch-name>@2814
> Use of uninitialized value $args[2] in join or string at C:/Program File=
s/Git/mingw64/share/perl5/Git.pm line 1655.
> Use of uninitialized value $_[3] in exec at C:/Program Files/Git/mingw64=
/share/perl5/Git.pm line 1681.
> fatal: Not a valid object name
> ls-tree -z --name-only  data/OVK/: command returned error: 128

In Git for Windows, `git svn` is quite a maintenance burden (with a few
known issues) and my current thinking is to drop it from Git for Windows
instead of leaving it in the current shape (I, for one, cannot justify
working on it myself, and the same seems to hold for everybody else, too).
See also https://github.com/git-for-windows/git/issues/5405.

Is there a chance that you could use the [Windows Subsystem for Linux
(WSL)](https://learn.microsoft.com/en-us/windows/wsl/) (i.e. the Linux
version of Git) for this migration, especially given that the
characterization as "migration" suggests that this is a one-off task?

Ciao,
Johannes

> What's different between what you expected and what actually happened?
>=20
> - The process failed instead of succeeding, and the error was incredibly=
 unhelpful, and seems like a bug in Git.pm.
>=20
>=20
> Anything else you want to add:
>=20
>=20
> Before this happened, another error happened first, which may or may not=
 be related:
>=20
> r1126 =3D 9d5f073cfcac00b9d8586923da4d045699244749 (refs/remotes/origin/=
trunk)
> Failed to strip path 'src/Lijsten/.gitignore' ((?^:^trunk(/|$)))
>=20
> This also is not a very helpful error, as it gives no indication of *why=
* it failed to 'strip the path' (strip it of what, anyway?), nor why it fa=
iled on this particular commit.
>=20
> Restarting the process by rerunning the same 'git svn clone' command see=
med to 'fix' the problem by just continuing the process (which begs the qu=
estion why the process aborted itself in the first place. Couldn't it just=
 have continued?)
>=20
>=20
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.49.0.windows.1
> cpu: x86_64
> built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.2.4 11 Feb 2025
> zlib: 1.3.1
> uname: Windows 10.0 22631
> compiler info: gnuc: 14.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>=20
>=20
> [Enabled Hooks]
>=20
> C2 - Restricted use
>=20
