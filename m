Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0707158533
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615055; cv=none; b=GRcTGc/Pvp8fL2h+0DkfCkcG+ToutadPq0jUI6T0aYD7d7poBAFRDQPrrbJG1fijHAxCEpS95mwc1puSshcr72EEY+zx54CTWN/6AR+NM8lRQadh572jcY08qW9kBJNvl3GIqKwK1B3t0VfOTswZklmY1WeaPAsCZZO/+lFIxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615055; c=relaxed/simple;
	bh=dxZyYQcO24Kl52KbdL05oGLSJLoeDNb+d1w5bDQCh6s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FUMx7qFAyS7J2wTwJAdRR9fajvL7iMiEBqNM9K2TEcBUbjGQeTWS6C/+YZl383MDEWagj81/iZFPsrRTzk/IOEcqaaINsNNF6qIVJlCz2fWukfPO7GLRhpl+JjwGzkofhz4WtoqRloq8xJi7dGjT+Pzl2NQOhlRi0zGs6G7Ogn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MBKErYyd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MBKErYyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725615050; x=1726219850;
	i=johannes.schindelin@gmx.de;
	bh=9P7Pckyb8OqrCX0DVXGlBe4sBk7LMfAEUkqmYWjFeTc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MBKErYydNHDdpD8agurv0Zg6dded/60dBSdvmCQJgTGtHtDNsECoKKv/1ZUdbWMt
	 Msd0wLhQ1Wf99lIrUhfp7hNAHnQwMRH+aWA9xcN3DaN4HbsmlNaIsQdV2K53r1FMz
	 DipvFJsId96Z1W9Qs2nckUeByXhFp3s0eAGamigHksVMr5ldKPFHhydio/tX9F3ON
	 05XiW4+k3AVetQCWoJSQ/5UR6wxVu0vvypdUKQHJaKCvxX8gSQ+0KpPvR07FJZ3ow
	 xCAO4uApIWli/gPcDNzUG3SsOrN7dHF5/fWds9hBswNl2Ct6a9amE+CVmwLvdmUMm
	 RkrexFGSwRETqbUwyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1rodBh0ojj-00yNU5; Fri, 06
 Sep 2024 11:30:50 +0200
Date: Fri, 6 Sep 2024 11:30:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: tao lv <thebookofunknowable@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Is it possible to resume download on single file.
In-Reply-To: <CAFePT4wau_YG-3wOs94YrJ42im+x=Tp98Fu6vBJUG7pVDviO0Q@mail.gmail.com>
Message-ID: <b6e1ae0e-871d-334f-b97c-b8351daca1b0@gmx.de>
References: <CAFePT4wau_YG-3wOs94YrJ42im+x=Tp98Fu6vBJUG7pVDviO0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/7JHn9cqAwI9FhhkWER8ST6fhoFTnHKPtwPjzMlG7l/vFl7xXk3
 mP8DffoSTcawAaL/Jxa6PQ7YUGOdfJs+O+L21oB0iMj6gNDiXCbbj+DVBcjexzb179ghW6A
 lMPAM0aUPP+H6rkABeEIO9cgO523SElkZToy/DKNpmwgHR7ttEsAl0MtLKO249KDertWdVs
 wqnkLIi3JANfKb3bx7k/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ExKWT7QawUo=;Pp3OPTKALOQPK01H8H4s/j1y9v+
 zLEoE0q9OwxH7ZifqCy1LXm3BStk+llJm3+OkSIs1mklqAG53d2vasrhrj3+kuTSt2jHfGnyV
 ObkSIu5Mnp4r042kd5GWKG6YSy8ubI9LcqBDoNqkleZiBeIQgy/17i3MnGI1z6CgC5cvf9LRU
 Bn6Qm6WdPR4d23HqJQTOqezWFsqnrCYQDuqZh8OB2Hp+JlBSf0+FHWjXq3Oi7hMTqliFe1dvT
 XYdZCQL1vjFsj9U0ebwIA3brQdPgMRWFQdIC0IWyYbqqEB9i2R/tqayITUDzOdiw9ZpsVo8nT
 OveNo2Wlt1R6yCz/FhTPK47NbOk+P/fjoOAqtC0scTpZ8m7ibmG0LB24cpziiRofTRkEu7sie
 12RSHxEpD0VhYScLwflOTN3nRdCwJwTy8+zVNF7W6qq8mqBJg0gkhkkAnNQzWbq/7+mWkkiMY
 d2h+J/trxhfPCXJ9lFUoXPdqF0Y/njCUP1AdBamhdcDnDaL9js0YhK2C/qr3NhoZMeiUwfh5L
 kSOM4nk1GmVO6mW8AQZbq0HzFEH2E0iwDVZ/ReBz72D+iQNIILffnIskUhh0D5fBlxPkSJ8aB
 FRrUO8kOP0Jflv7cn9b1guvy3+n6TlYBNSPLamV5jm7rcfEzOkeBb/+TrDvlasVZ24X6MH2ub
 KdW8/7sb85qBq4iYN73DjptUiUDkLwBmHZVmY11pzYphx7dkLmbAYYKBBPAkm1hHWjgryw9ta
 OyM1gyPp9qdfyRof/+8NJS6MWPyOg1qGXWTST/OzN6FhtdSrsKFquZBOJqM593IbHICsVUxQT
 LPoLusuZcXs3fWHcGK1Ejpmg==
Content-Transfer-Encoding: quoted-printable

Hi Tao,

On Tue, 3 Sep 2024, tao lv wrote:

> Is it possible to resume a broken transfer on a per-file basis in Git?
> I am currently using git version 2.44.0.windows.1 (Git for Windows).
> Due to poor connection between my workplace and GitHub, cloning
> projects often fails.
> Therefore, I often operate through the following process: (the
> repository is chosen as git only for example)
>
> ```
> git clone --no-checkout --depth=3D1 --filter=3Dblob:none https://github.=
com/git/git
> cd git
> git checkout HEAD -- "*"
> ```
>
> This allows me to download Git files one by one.
> However, sometimes a single file in the remote repository may be too
> large, causing even this method to fail to download all repository
> contents.
> So, I want to know if it is possible to resume transfers when
> downloading Git files? Or will this feature be added to git in the
> future?

Git's design does not allow for resumable clones at this time.

There are a few more or less hacky ways I can think of to address this
problem:

1) Prime the clone with a local "reference" repository

If one of your colleagues already has cloned the repository in question
successfully (and _not_ partially), and if both of you can access a local
network drive, then this colleague could initialize a bare repository on
said network drive that can then be used to accelerate future clones.

The reference repository would be initialized somewhat like this:

	cd /path/to/repository
	git clone --mirror --bare . /path/to/network/drive/repository

The clone operation would look somewhat like this:

	git clone --reference /path/to/network/drive/repository \
		--dissociate https://github.com/the/repository

2) Using bundle URIs

This assumes that your workplace has _some_ server that has both good
connection to GitHub as well as can be accessed reliably from your
workstation.

The idea is to maintain a set of static bundle files (for details, see
https://git-scm.com/docs/bundle-uri) that can not only be distributed via
Content Delivery Networks ("CDN") but also via servers that allow
resumable downloads. These bundles would take the role of the "reference
repository" in the previous bullet point.

One tool to make such a setup relatively easy to initialize and maintain
is this: https://github.com/git-ecosystem/git-bundle-server#readme

This does require a server that has reliable network connections to GitHub
(to update the bundles) and also to your workstation, and it requires a
bit of work to maintain.

3) HACK! Downloading the raw blob objects' contents

Since the problem seems to come from the blob objects, you could download
the raw file contents and feed them to `git hash-object -w --stdin` to
populate the local repository. That way, your partial clone would not need
to fetch them via the (non-resumable) `git fetch` protocol.

One way to download those raw contents is via the "Raw" URLs like
https://github.com/git/git/raw/v2.46.0/README.md. You can ensure that the
corresponding Git object is present in your local repository (and will
therefore not need to be fetched again) via something like this:

	curl -Lfs https://github.com/git/git/raw/v2.46.0/README.md |
	git hash-object -w --stdin

That can get a bit tedious if there are many blob objects that need to be
imported into the local repository; To counter that, you could download a
tar archive via something like https://github.com/git/git/tarball/v2.46.0
and then import it via something like `import-tars.perl` (see
https://github.com/git/git/blob/v2.46.0/contrib/fast-import/import-tars.pe=
rl).
According to this public information, the tar archives are cached and
therefore the download should be resumable:
https://docs.github.com/en/repositories/working-with-files/using-files/dow=
nloading-source-code-archives#stability-of-source-code-archives

I hope this information is useful to you. If you manage to improve your
situation, I would be curious to learn what worked for you.

Ciao,
Johannes
