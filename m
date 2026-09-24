Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DB368291
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253069; cv=none; b=UpqxpWtc3f0pS72RkiFkjTh5WFhv1apovTjUBtwKh+JXrzz+BqxndjQxabdDaq8Mn2hZecqn8aIDCjP9ddRvHDyjgllJ7GTOkClb6KmWEScyHlRO6FnONd9kZ4/9ttK/Sv+kxYwrQ9TkfVZ2h1tSYdLPVASGb5dhBAEMbaPLi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253069; c=relaxed/simple;
	bh=G7/dwdbJ5WPMfmUMJMQ72VGvFLo/12E89rpoTtMSsGI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qn7OiAUVuNUZ0F0n+oHHwaC45M3cao+O8/2sde6JkLFtktMAxXL/24WbY0EAlEjhWlVES/G8eoaqgjtMjlumwpqPkD0Lo6O2yo+qe4GAcH40pRlacES0tKNyDb2Sk7+B+cIz4OnNyYff6yExfBGROi6/HUfC1jO4hl2vpSQEyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=V+agNxfN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="V+agNxfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790253064; x=1790857864;
	i=johannes.schindelin@gmx.de;
	bh=G7/dwdbJ5WPMfmUMJMQ72VGvFLo/12E89rpoTtMSsGI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V+agNxfNs3sZZkEWw4SlyrAo9cGQbA76ZVnsLueuM84HfFQea+J2jdx8H0ICcM7a
	 nY2EgNJl1mUJ8kK7W9YSHjEuq3qFMQf8sQpJKeueavFq1IklMRQ+XpReD9Fe0hvLQ
	 HW1KX9gn6XtdDGfdTm4JQvGvS0vHNdkxqwOWApYoDZTPO9tESmtPPuRx9DmEEHPvl
	 CBrpOqOW/Atfj8V+dJllaBqK0vRab1eZ8lb42nkp8WiOf6eTVdjhSdZs4ZNn7Uhqi
	 DK4By00ZcaJvXdDI+h1xuUQQVMIDxeWwLhMLvgqrrGAtvO4AXhbA77Vvp2u2/YYvr
	 IqY/rD7tw6bAzTVn+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1x5a0Z024J-003VKb; Thu, 24
 Sep 2026 14:31:04 +0200
Date: Thu, 24 Sep 2026 14:31:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniele Sassoli <danielesassoli@gmail.com>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git
 v3.0 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <c12b9da1-b679-43e5-9485-2cedeb1dc613@gmail.com>
Message-ID: <682ca568-ba3e-1102-ec21-03dd4aee2e14@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g> <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de> <c12b9da1-b679-43e5-9485-2cedeb1dc613@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:VBlqExqb+NOkZjIoT7HlvkpggKGxupxVX9Rkuk8YoSmgacNVi15
 E/Y/OV21NzkOxWg3shT7txhgkAWkHSb04XeCVwRXghOVoBAEk7ZGWJ09Q4Go782u3aNqA1P
 YvFXk1aM1OoDaYDuDMVDoEQ6WTJXHOOx5YMAAvfoReWwtVzCCmUNO4ujdYT62ZfF5UEcAYq
 wm0oPhGERaOnaSo5skfmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OwP9fIf4uPE=;k/28epiOS9KSKqkejEeWuXNnzpJ
 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
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

On Wed, 23 Sep 2026, Daniele Sassoli wrote:

> Thanks so much for this summary, I didn't participate at the contributor
> summit as I was leading one of the breakout sessions in the morning and
> had a plane to catch in the afternoon, so I'm very grateful of your
> summary.

I'm glad it was helpful!

> On 22/09/2026 19:44, Johannes Schindelin wrote:
>
> [... snip ...]
> > Pluggable object database
> >
> > Patrick's pluggable object database is working, but it is not
> > complete: commit-graph and multi-pack-index integration are still
> > outstanding, and a repository extension is planned. (Personal note: It
> > might be interesting to see whether implementing a storage backend is
> > easier in core Git or in another Git-compatible implementation. JGit
> > should be a natural target, having originated within BigTable-sized
> > constraints, i.e. a different storage system, but funding seems to
> > have dried up, there's not even SHA-256 support, so JGit might not be
> > as hackable as it once was.)
>
> Pluggable backend implementations for JGit have been possible for quite
> some time, although, admittedly, I don't think any made it to
> production. Maybe at the time when this was introduced(16 years ago!!)
> by Shawn[1] in JGit it wasn't fashionable yet and so the project was
> never carried forward. I know Luca submitted a talk for the Gerrit User
> Summit to present a Cassandra back-end, for which I can see conversation
> started 10 years ago[2].
>=20
> Regarding JGit support's for SHA256, I know some corporations have had
> interest in sponsoring this work and have discussed potentially
> implementing together it with GerritForge, but, as far as I know, work
> isn't ongoing yet. JGit is still very much developed and kept up to date
> with great effort from the community, so I believe it to still be as
> hackable as it was, there just hasn't been enough interest for SHA-256
> yet, which I agree is a shame, hopefully in the near future this gets
> remediated.
>=20
> [1] https://github.com/spearce/jgit_cassandra
> [2] https://groups.google.com/g/repo-discuss/c/IekVPmow0yE

I'm glad to hear that JGit isn't stalled, even though I doubt that the
SHA-256 support could be done without any corporate support.

Ciao,
Johannes
