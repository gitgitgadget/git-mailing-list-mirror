Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBE155316
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972549; cv=none; b=ZGilo4sUOFPu9We8zmyyrUDnWFLsOPcAVZV+F/1GtWJJhJEJuicgXBiEb5xWlKhxmmz2NT5sUus4Cd6cefC5jyUHr5kAYpH8z1JdWTDO/7tYy8pWgnv7ISTPf3x6grBduhRSvQFX7UQavgsuDkOPM/KycVY9GnadhPvREhO8OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972549; c=relaxed/simple;
	bh=KPFyrO0dBtyO1E7MnrwnVbwnu1H1z4x6zwGMw4FlY9U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SHcjDWvx3EITUH+vsmQzGOpukzOnce1/D4usIqtMMcNDaKarfL+TdNgi0cnS0zXzE+ft6ZmERhov2mN3BsMVYxwhN8dViCPgk67FVvpJqHkOFYhy+CQNsC8TSwO8Cf79O17j1ubi+Nlul9YtBIMDaUoxWpJ6QZDNGFbacIjlU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pbY5Ir8f; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pbY5Ir8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742972542; x=1743577342;
	i=johannes.schindelin@gmx.de;
	bh=37g5TkdoTAhH4LRB9Nsfiq9tV2swsIAAHNBRGnvAB30=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pbY5Ir8flwFW9QXG3QFlAf/Klq1WetYJLy238zaAyS0XeskMcN1tphPnOkqBmXSC
	 wyH3frIevPJG3Cci+j2dlJY479OmJ44YeYFSzmW1HNZxUiBMfQXq3xKMspevwKnrK
	 dSw/QyT/k5of3qS8ZrLm7yk+Z6MPs/mK08Sezqvjevb/5/ZkyXV8xE2q/Uc4Oe616
	 LagkqjIxidl9aTt932ZeMIF64AH9RVABOrrKrshvkbYrWFeK5IcKYRBBYBffdYepT
	 EVGSZhcg7sWyWiiLAxDsacZPRlQEkbpQ0ZmUkWtnH6TdmF5L4Qv7ebNlEmWO7nLFd
	 7A3VaWikPt/ltXll3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1t39D83B7k-00teCK; Wed, 26
 Mar 2025 08:02:22 +0100
Date: Wed, 26 Mar 2025 08:02:22 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: Releasing versions on Fridays, was Re: Git Bug Report: git add
 --patch > "e" makes keyboard unresponsive
In-Reply-To: <xmqqsen1mj1y.fsf@gitster.g>
Message-ID: <c4753c0d-d957-c4d0-a452-1e592cade34f@gmx.de>
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com> <84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de> <xmqqsenb70u0.fsf@gitster.g> <2dd6e0fa-b997-f69c-874b-f424325123a8@gmx.de> <xmqqsen1mj1y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cU/PZoA2uCQmDhXeK3WoOlKlETQnQoxEczfYA0NNvFQlLkCiikI
 4a5Aq6RJeXjpR6z7EDxmQENu+tw1WUVEegmLbNa+swIZmcdJr0D/Quptpdhv9C1h7D+RJOq
 44U8He+zlZjFyFMWOZ8Qh2KQMGl1Gqd2vcX1ySYj1mzP90DxyvGqH2EJ/xNxCpYLdsc8P4n
 o3cWgObLQSGNWM0RY2Rog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wBfMnjkTWgE=;difnQQrUk+DYx6Z0LB3FQg+UcFS
 7pIGAcUfU6KbiTUpCyxKPkJ+nj6DL4YvbIQgeQiWCvWmUdQ93rWvsfxiNTkAT4xcYWHwpaXpS
 QA5aoB1cmQcVY0I8Gv0WzsTfdvzF4jdvJi/UIVBY2/Ikic2UtmAcZpIT1EJ234waaXcQlL+SV
 5KVwtata8WYNmxhhflNf7qSRm89zT9aB9l9rm3TYhr50W73WC/znTFj0ZA9Tm8z/8gXHh46YR
 qmBaWF5dDmuyS4c3RDaIEQ0s00MbRPMU1mgydA0wkdKXb2P7J6dbazfT93zg+hJkpnhVfRrZ4
 EgqFlGtWywG19Xjxgw3Wqk83IY4AY/81aJDw2mKjHn1/GdqZsitOiv9xCCZdpcQR6DvLckxZu
 wFyfcxXywpMKhujnplCCZX4uQCy6A78e5m/NcoYEZdT0q0Z8GIJtQ6yfP70IHNgPkbIuzs4uQ
 f7NCcBLLcJQTccTlJnf/zfQ4k2K83iY7/xuqAJ6ar02otGERUW3OJhT3SA9vkr7g978EI+HgH
 KshMhLL2AsjcBptMo5wtRAGi7CHwl3cTRJi6fkZULKxVPABs+20PilUqu2Wjm2fS/cbvcrdVB
 3IwepXAeKzut9HpamXINRCX9VG5y9yjtKnMkK8p4t4+X31gZniH0CvPyy5Sgyjm1lynCioTJO
 aQ5NUfRdjTIb6P8lF7awvXxRZeJQZQiTHSaItTV/QWqgoGzZRBhLPm50NocEMefJ9d+gAK9vf
 Ir9sOCJmN6CgTcljL72JVSzathc+ywWTp/zBoLtHYue8c123ijK+1iQm0yI3sk6d7x+3cwr86
 MH8AJVTWJlz7TqT67yf8jzKz8lyoF8LBcXFkC9QzYLeDiiuYT/T+Usai46nlR+2p5I7oeR1hN
 8gRtnoJRUcmRY4cj14q2vDMV4DbddQDNapowBWssKwbBtclqvxCRKb/TJLADzqfb9BMHhueRS
 keRpFXPgCQ75/lSUiltvZpQ7R+UvRaKnJ8uk/0/npq94+hV5iEBm+mhW4Ibil+tGcXChvlF9l
 SDFbXolBngN8wAOdHJ9/5sFkptYdruKxIXAy0b5I2iZ9vLqum7G7sXWbQCsVeen086bfp6I+J
 xrFOLVdM4m59bpXKgNagxdIFXf7pAu0DUCxlr0n7lf5tiki4hFpLuZZkJiWSBS9GYeKRln1e/
 dyNGjaekeHHf/3jQ6Y290XxLaXBuqcHt3t+w2J8vmIWr8H/JClq3s8EuZASz7kgw5Q9n4x+Fy
 56GUHvykLjKu3wqISEZavta9Le5qK1hX4avlmn4KDQE8ionDlU2Z5oLSjqmZYH1aYxWs+sVIu
 /lqWSewuDc6wH5qXfE3kxrygbDTLOvmQCdFI60T6BlaOoe9XUtBanttiK4TNRWFYFpaZPBYqn
 v57JwWVBKohak5giY/SiCSqst6xBSgJyzzBiWVBzyQBtHO8qBBCF9hUgWq987bMv7PP2dJlrt
 RD7CyRANa9mQy4+EiJuCki/253ui/0ULzoKuurLo5jSChuJ+L
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 25 Mar 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I have stated my preferences previously, even attempted to coordinate
> > between Git and Git for Windows, and I observe that the way I present
> > arguments is ineffective. Therefore I will try something new: Refer yo=
u to
> > a couple of resources that could elicit some introspection and
> > (re-)thinking of existing practices:
>
> It is even less effective.  Friday may be bad and many people may
> agree to avoid Friday releases.

Thank you for your honesty. I want to share that I have spent considerable
time reflecting on the release process because I genuinely care about
improving it both for the sake of Git's users as well as its contributors.
I've thoughtfully weighed the challenges -- like having clear and
dependable timelines, like timing releases around holidays, weekends, and
accommodating embargoed releases -- and observe significant room for
improvement.

I approached writing the email to which you replied with the intention of
fostering a collaborative discussion. I put a lot of effort into crafting
my thoughts constructively, writing and rewriting the email, even deleting
several well-laid out arguments in the interest of a less confrontational
and dismissive tone in favor of inspiring reflection, and I had hoped for
a response that mirrored that level of consideration.

That said, I am eager to hear your thoughts on how we can shift this
dialogue into a more productive and collaborative direction, one where we
focus on enhancing the project together.

> So what is your preference?

Apart from seeing the need to improve on the status quo, I have no fixed
preference. How do _you_ envision a release process that could better
serve the needs of everyone involved?

Looking forward to hearing your insights,
Johannes

> In any case, I'll go back to my vacation ;-)

I hope it was a good, relaxing one, that helped you un- and rewind.
