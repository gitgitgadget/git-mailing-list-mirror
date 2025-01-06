Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C3522A
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736146293; cv=none; b=ASlLh2J32fPOBkj4aKg20tlpu0oXJS9pI1bpJVZOcAoAYdAIdhxrJR7nck9yTOP2xvLg8rnltJGyvnV1rSIJovcBWgQDYqQv0ipKWSzmBdFZ5JupUfe7fbT9p9vPT1WuEaKnoUyXlWBcqa6t6OLoBA2CEZf2SNwYF2T6LJaN61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736146293; c=relaxed/simple;
	bh=c1RCFBJ2UH2FM5x0TtKNJ/fUelwj2W0JqQY/x6mdGOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANNJ4w9T4kQLuzU4sZTxMoRtlisqkHuP1utcbLLdb3Cc+jzMpDkkBdUOh4hCmSwfvFzYeDdTKU+5ZjnAUoxl2McE+7djumQGCuzBjgH5geJ/BpCZ8poilIcSL5J9LZEBPkyleC1dmWhYzef+K9cDzE5IjHMuauhQoLmpd/KCcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gcJ7z1kw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gcJ7z1kw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736146282; x=1736751082; i=tboegi@web.de;
	bh=zhyYUD8QTMX5gazgt+//vWuYHWgDf74j4p5N2QkvnTs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gcJ7z1kwfA+8V70RFZDWgxizDa77Uk7IuTPOnrjLKQCDmXt2PuWuSbFGBwiLs3vb
	 qAmxmnuhvzMtKOfATOipctepm8EQT1JKQrXGP2GwIg/btSyfGbZ1FskrF2jUEZqxb
	 n0X9n7VwWgkpfHEwrkx2AB0qS0r+ntdxkd7kW3Qhv8viS5HPxbsgD0dv2sctAotw+
	 5ysx5dXBx+YrwAOiWAbqz378IvWGNAPTxZMYAw9N6SMGgVJDnQEwDKPTn6wQx3GNs
	 fmNXLXY4fdcIti/obDZsoEDgeB5KkfWadi3BCeoLwP/ZaC+2vmtQp+0Z9RciSzMcl
	 PA8W7KTuQ6uv8cgu3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1tGtRY1kEU-00Dmea; Mon, 06
 Jan 2025 07:51:22 +0100
Date: Mon, 6 Jan 2025 07:51:21 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: Testing for existence of a remote branch from a script
Message-ID: <20250106065121.GA8844@tb-raspi4>
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:uubVuPtkNHKLxD0RguAgaVw5m1Nv2VhYtjySKz0RrSCf/PUnd5Q
 rHVUgrp96jRcCeY9nkDXcwPm7lVFcyKXumvx/VmuMbkwJEIp3FRIdGkCnopdGNhjOggGcOh
 ys7zIBeX6gFQiBtRS+wwlEOEujK5GEFijswWZH6ori3mJ4/ViK5hEBnL2+PMJ/onHCJ5Gmf
 SPsQDmPoKe4bMYVgLul7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mZempPOAKhs=;SjqM4EUBLo221RM3y1bpC35iStT
 RC7GeXpE0QtXnMTH5ermqws0qBiUjGBcBckblAp32owUU0/Dqt9Bh9KjDmmJ8gCENRdQKeWgm
 Jy3FfOoCsBlw/tZW8+vPqBekvAn95DZCJgdYMUV4/lLMLb8Iefa1nNAzpA29+jykmGdpiiNVG
 1e0rakNGiBcVrzPCviK94qanDa0VRvKKogTQ6ZdktSKJzPUt8AXzwUtOh48uj8TGeF4sQSOJj
 MiJ6o5YxQ2Dd69TfieUdklUXyAHdBPuOdNTKeh8imcjtwfvt4TA/fwQ9baEvtbXZfVqh5tUSS
 y+Wk12p26RLtizdwUqvFD7mP6y5e8gKtOTK69BjxZCLrAq+ibhsCiW0VuPnmHqOGfVqOaDHb6
 3ZygQqVesnsp9ss2+uQATi/O2OSHijX5laeyFO4OsB7jivwyJpTBHhNNGaQGGjVNzSmb3PVuD
 V/8pV6PVSVLRZdKx/2DdmpM0EGx+ayO6IbL84VC08OCR26QwgUfvZT0/Z1WWkYTePp91AXau3
 nuhvfWiuDZJJam2KFVgojxaaWnZVPTW2ZDKuaHQ2LvBX33tOaZjZYNFsrkuwkY24MdGF8p7pR
 x2N8vJ82wc9rVp33fmbifiImk6ZYtMLjpCOvLzv6HUGoOS0ftEe+LYXI8Jcr1kcBERxWQHVHD
 wo9/7kJxgRyLJ3dr+bFQkoT/zaZBslmlpcYcKslzRvYZPwtYmepEhV+zLgrCl3/ahvHsrYvQf
 NpNBkP68RUN8owWDUtTjgorR1hzwBb7UFXiQQOBq6ppak/BQIZFN6D5yegfziRPPlVfh9V585
 8Mvu+W1Ym2KZ/vwvGu/Tmafin4GZjbjNj+l88tIqjxv3kUPo0KT8mR+Mz9IASyDTCZx4OyNNj
 jqlc2tS/5AAXnAz/YUHI2OGkS3UKRsmni0JoOBsl4Iz2aVLUJGj2abND1mSohRp4fveBqsmFd
 zwCLvJznOVRvkyU3oa+YGf3BC6FuIE50bzeJBV4YOp3qucbfy3H6Ke1E8S2Esce55x4XLXsMt
 t160K4L6s+7u7XlUtNr4CHezL+pdcIxPwUI9hvzFcaVzGdfnMceXXS42VUXvMIsaoYzvw3M20
 ZpxRUyvk0=
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 05:40:36PM +1300, Chris Packham wrote:
> Hi,
>
> I look after some scripts we use at $dayjob for pushing changes though
> our review system.
>
> For some of our repositories we operate a triangular workflow where
> changes are fetched from one branch (e.g. 'foo') but are pushed to a
> different one ('foo_incoming'). Our CI system runs to test the changes
> and when they pass 'foo_incoming' is merged (fast-forward most of the
> time) into 'foo'.
>
> The problem I have is not all our projects use this workflow so I've
> tried to automate the detection of this. My script does something like
>
>   br=3D$(git rev-parse --symbolic-full-name
> refs/remotes/origin/foo_incoming -- 2>/dev/null || echo
> refs/remotes/origin/foo)
>
> The '--' is necessary because if foo_incoming doesn't exist then there
> is extra output on stdout that puts off users. But when foo_incoming
> does exist then br gets set to `refs/remotes/origin/foo_incoming\n--`.
>
> Is there a better way of checking for the existence of a remote branch?

I may have missed something, would that work:
git fetch -p
git branch -r
