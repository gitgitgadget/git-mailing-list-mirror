Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7644D020
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490578; cv=none; b=OJ6qp0s9wlD806JZZJj+wvtEDqN1Q2FpRq2OhE1DYnjfZosbolBmS1ml4g4zP2pzhD1MIykJFdYVDUWC2f7kYxvFs1bX0U2Es+S9kfVqgHn48MARAShgWdxJWLgFEBWbSyZhBLmDKtEbEqexpirZTEkZZyy1o4vJnVKRr2JYYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490578; c=relaxed/simple;
	bh=BmL1aFXQZjxPkjBQbqDLjvoDPHF+5dd78HptX6L7xes=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n8lEn0FLiCBotyn3yAKxrwIr30xWFjxHc/qWEymCHIUFLE8YhTJmHEwCr2kfY1F02PG+cxksHQp0HTXHJPZ+kTidkzs4jybVbgi7BOvpJ33XNyd76xG4P6njagEEPsuj3wEPZXFa7GAo8UdDBKiadKs4buPbg0z+2b+xwEBKWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=G/2sJqg2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="G/2sJqg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780490573; x=1781095373;
	i=johannes.schindelin@gmx.de;
	bh=BmL1aFXQZjxPkjBQbqDLjvoDPHF+5dd78HptX6L7xes=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G/2sJqg2UgqTZcO9j08CbWz7cWYkOVBVr2zkZRPGkXUfUVcv/A96OmXCLX2sWqDc
	 AoR0E01zrP5unUEdbsL9XdWB+o4SesCM8qpowcqVcj8qwI2TiOztjyz2Kek8Kfs9X
	 drXi/vWN2rrbPMXmsj7TLWipKzMjCHbwgkVFK7neFjyl6dRIXnADS0yrxOgcZhyDV
	 2AFHadHGxFkxn9cqJP5d/cQWNjbON9ODpGvx6xnuKzq3QZDYQIvsDr6DjV/LShf7R
	 MW/wKQ03hQH1NgH7bj+uljqGslp2I/n2j1ozvjvUXVCqPkd5IqHCzN4pltfTkOlof
	 A472GSPHF1ABt7ELug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1xK6Rb0HmM-010v0g; Wed, 03
 Jun 2026 14:42:53 +0200
Date: Wed, 3 Jun 2026 14:42:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dylan Carlyle <dylan@reftek.com>
cc: git@vger.kernel.org
Subject: Re: Git for Windows Failing to Clone
In-Reply-To: <CAJKusd6WJUUVhbyN_-XHkGWVYeNe_=K2U3tZoezPWFG3+OG_zw@mail.gmail.com>
Message-ID: <b1239f9a-4a36-4645-a3a0-3f9bc32ba30a@gmx.de>
References: <CAJKusd6WJUUVhbyN_-XHkGWVYeNe_=K2U3tZoezPWFG3+OG_zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:BsHwCB9qOikAaQIgyAb/yNqhG43WyCL8Rh9I3nfPgPIDYamCNx+
 XOizGw4WnWmzgiNHU6h0/hEBFg8PBogUXEzZylsfYYjFp0jrtjOsn7Ki+pJKf2ukUC/dq8p
 yKouulPZU19dd7FPB50K1evAEVWV7qLl9eUflHs2Xu4DHkfZVAen/VRKS2wV1aM4UAMHyd6
 PeL0bHnpaWeYFER+Zz6Jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H8DjBXGkDkM=;mWMaUnoZ0MoubdTqfoHtOtN/4bf
 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
 uVOMBw==
Content-Transfer-Encoding: quoted-printable

Hi Dylan,

On Wed, 3 Jun 2026, Dylan Carlyle wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)=
:
>=20
> Ran git clone user@ip_addres:repo
>=20
> What did you expect to happen? (Expected behavior):
>=20
> The repo to be cloned
>=20
> What happened instead? (Actual behavior):
>=20
> remote: Enumerating objects: 57873, done.
> remote: Counting objects: 100% (57873/57873), done.
> remote: Compressing objects: 100% (32002/32002), done.
> fatal: pack has bad object at offset 460179591: inflate returned 1
> fatal: fetch-pack: invalid index-pack output
>=20
> What's different between what you expected and what actually happened?
>=20
> The clone never finishes on Windows.
>=20
> Anything else you want to add:
>=20
> Git version on the remote server is 2.47.3
> This works fine from Linux but fails on Windows.

I guess that this is virtually identical to
https://github.com/git-for-windows/git/issues/6265

Since it works from Linux, but not from Windows, I strongly suspect the
problem to be related to that vexing 2GB/4GB problem induced by Git's
continued use of `unsigned long` instead of `size_t`, which I am slowly
(_very_ slowly) trying to address.

You can find out whether that effort might help you, by running `git repo
structure` on the original repository (I'd expect a blob whose unpacked
size is larger than 4GB).

Ciao,
Johannes

>=20
> [System Info]
> git version:
> git version 2.54.0.windows.1
> cpu: x86_64
> built from commit: 2b8a3ab140826ac423c2845ef81d4c6ac4f7bf3c
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> rust: disabled
> feature: fsmonitor--daemon
>=20
> --=20
> Kind Regards,
>=20
> Dylan Carlyle
> REFTEK Systems, Inc.
> Systems Administrator
>=20
>=20
