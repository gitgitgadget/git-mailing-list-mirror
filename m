Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517629CA
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691483; cv=none; b=TCHtnvsVSaYFrDOA1AkWFV0+j23HizxfJxywXn7KJTbmoWRz2/uMKILEjZqRVgwrH0PbZr17SD0mYtJKtq63p3O2/BVX/a7o8PWoD0UQJrPf/yz4dBVUSlM9BVn42OnPYjF6FMuFvZVBhih1dJHA+//9TxLne2kIFpdCnVQXVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691483; c=relaxed/simple;
	bh=m2DRmu+EPr8gUfJYYpx6HuPkFCkJc7WH5ppoZlEctVc=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=IF3CCZfzITYqqxduj2YGlF1tq7GsR/QOHl3mpaw9GIewcUdKotAx3qFlIVV392qB8nODoayrhntwNUYjwYpQmPVOz+BFL8MCUfkgSYU+N6EZBPIs9XP0S3nCfqPmnokm4Ti4DagpZs1MvA5eO/cT3ydns4ObjnTDikZf8cRjM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=C/UXifmv; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="C/UXifmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=w4fFoDn7Jx2L93/1wJey59cT+f3gmS659FJU7nUU+qk=;
 b=C/UXifmvw55VuPsLkPaJvjEm0G5fhe75IL2AkFUSkA93U7qbFx1asVa4/4VPR+65ZTnmnw+G1DTY
   7lmhFKfsXcD6EYeykVWGm+QhrGJKdobY3/EOwzWRO+QFT2NOcXxciCYxJQmf6bpU+/IB02nyyyO+
   HDrIMyQAFWU2xYwgfoa/xErroQ9ZhMuS6dDeFNf72FuhkzBAVoZb124qgvxfcBck/6+PIFv1pghU
   4Sd/4v4mSBz33ykxY/C4U9CtVpPipMLEhykTG53AdjaY2zNvTmF4LxRLX7E/jUsZ+VtxinvJVGHz
   NjVLHmpMXViIvx3wtJT2KkEsFAIdBXR1uxi20Q==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPZ00C68BPUVEB0@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 12 Jan 2025 14:17:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 15:17:36 +0100
Message-id: <D705QOX6EFH7.14GKFWVVUQWH7@ferdinandy.com>
Subject: Re: fatal: Not a valid object name HEAD
Cc: "Christian Hesse" <mail@eworm.de>
To: "Christian Hesse" <list@eworm.de>, "Git Mailing List" <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20250111202628.0e5894e4@leda.eworm.net>
In-reply-to: <20250111202628.0e5894e4@leda.eworm.net>
Reporting-Meta:
 AAFKQrak6u7V/Jjfu3k7WGOz2091igkyRq8DnQFZtQgqT8wxlZLldG5f46LygjOa
 yh7YmyOwxgPyyrs+p053bJgJNwAECDvQjxqJgSGP7nu4DuXG2T9SW9Ilv3YlgGWZ
 WYCJMQqWvOl9y7IfL8jWMkLaKWfAIiVLlZK9w4GDIj0BlgSuel+7C0fWvq+5nq8W
 dp2ZJEio+9iFC96LN3buRoZIRI9YygVVnq2+/2g0/X3O0/ak6FmyD6bWgt2uoeRe
 oRYAeBSJdRY+VVH9CmTXR5wjhnCrG6/pgCaobCbKbQIb/KieHqgSBDLddMbjg4WS
 Usxi9RkhIOj2sxQ77Lore/PwNlf2GFJTSRWagSWOaF1Fj2Kdi8raP5maR9WnMaYQ
 RyqNrJVCAQ1foVm00Ch0qCOcLEAOMKvMknqyG5x+Y2HZmyo25lTC3P58vTEfBGcd
 NSdZEyZJpD8mrQ9EMs6xKn7oDnxVDo8b7eJqpkfndlvUEV3bYQ2fgEI=


On Sat Jan 11, 2025 at 20:26, Christian Hesse <list@eworm.de> wrote:
> Hello everybody,
>
> starting with Git 2.48.0 I see some trouble with some mirrored bare
> repositories. Try this:
>
> box ~ % git clone --mirror https://github.com/codership/galera.git
> Cloning into bare repository 'galera.git'...
> remote: Enumerating objects: 49768, done.
> remote: Counting objects: 100% (2251/2251), done.
> remote: Compressing objects: 100% (553/553), done.
> remote: Total 49768 (delta 1986), reused 1716 (delta 1698), pack-reused 4=
7517 (from 3)
> Receiving objects: 100% (49768/49768), 25.20 MiB | 4.92 MiB/s, done.
> Resolving deltas: 100% (37386/37386), done.
> box ~ % cd galera.git=20
> box ~/galera.git (git)-[4.x] % git describe=20
> release_26.4.5-345-gd811a577
> box ~/galera.git (git)-[4.x] % git remote add mariadb https://github.com/=
MariaDB/galera.git
> box ~/galera.git (git)-[4.x] % git fetch --all
> Fetching origin
> Fetching mariadb
> remote: Enumerating objects: 638, done.
> remote: Counting objects: 100% (517/517), done.
> remote: Compressing objects: 100% (125/125), done.
> remote: Total 638 (delta 415), reused 454 (delta 392), pack-reused 121 (f=
rom 3)
> Receiving objects: 100% (638/638), 386.30 KiB | 5.08 MiB/s, done.
> Resolving deltas: 100% (440/440), completed with 105 local objects.
> From https://github.com/MariaDB/galera
>  * [new branch]        0.6 -> mariadb/0.6
> [ snipped some more branches and tags ]
> box ~/galera.git (git)-[mariadb-4.x] % git describe                      =
                         =20
> fatal: Not a valid object name HEAD
>
> Guess that's not expected... Why does that happen?
>
> Possibly fallout caused by https://github.com/git/git/commit/5f212684abb6=
6c9604e745a2296af8c4bb99961c

More specifically: https://github.com/git/git/commit/b1b713f722894d7f66e9ec=
64bc934ca32004d3d1

So what happened before the series is that HEAD was set on cloning to=20

	ref: refs/heads/4.x=20

and the adding the new remote did not change this. After the series fetchin=
g
the new remote will overwrite HEAD to=20

	ref: refs/heads/mariadb-4.x=20

which does not exist in the repository. Note that the older version does no=
t
set up `refs/remotes/mariadb/HEAD` which is interesting?

I think the correct way to handle this would be to check if the remote has
`mirror=3Dtrue` set, and if we're running in a bare repository we should ov=
erwrite
HEAD and if it's not a mirror we should instead set up
`refs/remotes/nonmirrorremote/HEAD`. (I think a remote can be a mirror with=
out
the repository being bare, I'm not sure.)

I can probably send a patch late next week to fix this.

Best,
Bence
