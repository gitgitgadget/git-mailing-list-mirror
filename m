Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C083D3490
	for <git@vger.kernel.org>; Thu, 14 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766202; cv=none; b=iWj3a9nHOq6NhQmJCG40MMUx8TccTYdk+Smmt25GgNW3/2tYrpcV/fwSPsr3riUnHagIgwBswV1A2opildazzDp62iIDQXRs81LEQDCpNMf7WquBlzBjBNmDctDU/gzs8u63hPHnwuCLGbvbBFmmbB6qD+g0sNcQO9xANMwhj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766202; c=relaxed/simple;
	bh=AvPiuqkgjo5CWkd9kErip4/EqJaSanl07H7r4iL8V/U=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opy23HZJrCsBFyfFamF0veY5UL9nLgPvZAa74lEQsGnfY9sB5TyRkscu32IaFukjYn5hhJM6/O0w8DaLCZwTGNQljChUOwWLOTtt7z15ZAz5f6AT6LmADA1LiwWrsb0sSFijI6PY8fThBzIp/iYdhG8AjKMSzKtc16++yvM9usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WjW3MpnR; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WjW3MpnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1778766181; x=1779025381;
	bh=AvPiuqkgjo5CWkd9kErip4/EqJaSanl07H7r4iL8V/U=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WjW3MpnRrmjaeiF2qvMBe7HC+wm1Nx/I7pm83OTXngGd5TIVnB0Dlglgd78g66yby
	 F5HUES2EX7+XhkZ75IW5yWcYY3hCnSebIvaFSEGgGvCQiKyByfo9wdYIigga4Kwwjs
	 vxsoXqZnV5puRpNoyYq5dsOzYd7Pey4BvsF/64q+EmClSqAhfbUoCZ4x4KGomINn6M
	 mD54bCneWea8MUBlOZmTtWIZAyZPQhkdMZD9fCmXZQG9JfjyzP5O+xpcZRv2d4HoO1
	 EJKjEoUO7Aocqr9xMSk5W0XmFui9q8kqpSRzse0/twfsmaSvZb3l9RbyLdPMaQrg+E
	 9Yp1j4mMwEy8Q==
Date: Thu, 14 May 2026 13:42:59 +0000
To: A D <diop.alpha@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Chandra <Chandrakr@pm.me>
Subject: Re: I object the social engineering from Master to Main
Message-ID: <9vgoWrgWYPUN9Hyss7Tg81TfUYy2h9mjMDx7cgI9LyjRz6tA5IDJpVwfzm1xz9CuPTz1DONlAIOPkdrR7FtkODcsRVCi4PAt53hRGClCp5U=@pm.me>
In-Reply-To: <CANULcizX5J5zE+QgY9TOvqpjrcJM3uFOOAWRJzOW2rBweg2WNA@mail.gmail.com>
References: <CANULcizX5J5zE+QgY9TOvqpjrcJM3uFOOAWRJzOW2rBweg2WNA@mail.gmail.com>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 5d826b93bf568886e94ee79625ce3abf96e57cef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I am strongly in favor of changing master to main. As a person currently in=
 a country where 14 million of my people are enslaved, who also had experie=
nces living in a factory as a child, with many friends who are descendents =
or have their own experiences being trafficked, this is one of those things=
 that causes unnecessary cognitive ergonomic friction. It's a bandwidth tax=
 for anyone not privileged enough to know only freedom.

As an engineering tool, creating pointless cognitive bandwidth sapping is c=
ounterproductive.

This is not just about history, this is about the present, where even in Fl=
orida there are 700k people who were trafficked in the last year. This is n=
ot just about the sensitivities of the privileged, but also about preservin=
g the cognitive bandwidth of those without it.

An engineering tool should not cause emotional recoil just to use. Accessib=
le and ergonomic design standards ought to be upheld to support seamless us=
age for all who use a tool.

Thank you,


Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 05/14/26 at 19:00 A D <diop.alpha@gmail.com> wrote:
It is not your role, as a tool, to try to engineer society through
warnings or changes of names. Your role is to deliver solid, reliable
versioning, that's it! Leave the rest to spheres where it can actually
be done without weaponizing your position or your audience.

I happen to be black African myself, and I never had any problem with
the term "Master", and its history for literal decades. The term has
been used in Computer Engineering longer than some of you have been
alive, and I see no reason to change, or to nudge people toward
changing it, just because it offends the sensibilities of some of you,
who I very much doubt are even black in the first place.

"Master" is a term with a history, and it's cool, if some of you are
offended by it, change your repos, but leave ours alone and keep your
warnings to yourself.

Cordially,
Saliou Alpha Diop


