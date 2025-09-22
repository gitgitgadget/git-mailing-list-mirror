Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9C21CC62
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558130; cv=none; b=BGUHXb8gpwpo6tcNx3NK1ap7m+sTayrvy6vPYeM+okpkpc69AEI0KG+ArdmIQGnw0jp1FXE+lPejckv6hKf/siW4uwdKhhw+HzO/VT+E2rNa95qhfDiPuckPFw6btWCxF317t56NOJCzXiqXHDY61UyE0Rl6GSFIHm7qEiSPv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558130; c=relaxed/simple;
	bh=pS8QH8JjNE1TWWdb7yi5IQDuwZx26n/ptwsEuEwCovw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OF04LSg2voZYw0edK4RENysToOrWW+tsrlu4D7Vpib+KCiDB7DAB+xf8uL4ZSgSS3EEnZG+H6EeT0TA0+7eVASlleHdW9LdeElf+nyJTcTHmkzEIb/0WNAVLiB7ESRtXYcZbHtg+5STUUv4UHmxKv7TmFL1XIlALXQb/DuMpF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58MGLdYk1993809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 16:21:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren'" <ezekielnewren@gmail.com>
Cc: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>,
        <Johannes.Schindelin@gmx.de>, <ben.knoble@gmail.com>, <cb@256bit.org>,
        <collin.funk1@gmail.com>, <contact@hacktivis.me>,
        <eschwartz@gentoo.org>, <git@vger.kernel.org>, <gitster@pobox.com>,
        <me@ttaylorr.com>, <newren@gmail.com>, <phillip.wood123@gmail.com>,
        <pierre-emmanuel.patry@embecosm.com>, <ps@pks.im>, <sam@gentoo.org>,
        <sandals@crustytoothpaste.net>
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com> <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com> <002c01dc2a95$400315f0$c00941d0$@nexbridge.com> <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com> <003401dc2aa6$623d1420$26b73c60$@nexbridge.com> <CAH=ZcbA0jpntXjPnrVi13Sz1PipnyBLNWKW4Q5taGEHqBrqj-A@mail.gmail.com> <008501dc2b4c$7f5ea450$7e1becf0$@nexbridge.com> <CAH=ZcbAop=z8-zA_aEE+sTHErg0gjzYRnqCd3XQF9=_TakBK8A@mail.gmail.com>
In-Reply-To: <CAH=ZcbAop=z8-zA_aEE+sTHErg0gjzYRnqCd3XQF9=_TakBK8A@mail.gmail.com>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Mon, 22 Sep 2025 12:21:34 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dc2bdc$fa856d40$ef9047c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsAJqIl+QATT20pYCDwZOegJLM5dLApmyRbMCd1X2zwKjRYU7AV7GJwsBg9WBUQFBfVlNsff4O7A=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250922-0, 9/21/2025), Outbound message
X-Antivirus-Status: Clean

On September 21, 2025 7:42 PM, Ezekiel Newren wrote:
>On Sun, Sep 21, 2025 at 5:07=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> Not really no. There is momentum for Rust on NonStop. It just takes
>> time to get budget for the effort. After getting budget, it takes =
time
>> for the port. I am likely to have some involvement in that, one way =
or
>> another. NonStop does support git, mostly through my ongoing efforts
>> and they do use it extensively. This really is a crucial application
>> and the NonStop team does understand the implications. The problem is
>> that everything takes time, more than git is allowing in this case. I =
cannot disclose
>more than that.
>
>Ah, thank you for correcting me.
>
>> Yes, people are screaming at me to fix it, which is not easy. The
>> policy is not the Problem, but the technical limitations are. It is
>> not a surprise, because I was involved In the POSIX effort when it =
was first
>introduced on NonStop, not that many "in the know"
>> Listened to my concerns, which are now having significant =
consequences.
>
>I think you've mentioned threading as a major technical hurdle for Rust =
and GCC
>somewhere else on the mailing list (correct me if I'm wrong). That's =
why I've worked
>very hard on single threaded only translations. Also, I've been =
targeting Rust version
>1.63.0 because that's what debian requires and so my local Rust =
development is
>locked to that version. I've managed to translate a huge amount of =
xdiff to Rust
>using no Cargo dependencies. I figure if I keep my Rust adoption effort =
as bare
>bones as possible that'll make it easier for NonStop to catch up to =
Git's Rust bare
>minimum requirement. I have been talking about adding cbindgen which =
pulls in like
>40+ dependencies, but that's a different case because its only purpose =
is to generate
>C header files from parsed Rust files. I can write my Rust in a way =
that cbindgen can
>be disabled and the generated header files can be checked into Git or =
acquired
>somewhere else.
>
>I have 2 questions for you.
>What parts of Rust do you think will be easy to port?
>What parts of Rust do you think will be difficult to port?

I will ask the team member who are doing this port for their opinion.

Easy: NonStop is POSIX and has C17, so anything compatible with that =
should
not be difficult.
Hard: Anything that depends on assumptions that gcc works 100% on the
platform are hard and have to be worked around, so porting mrustc is =
considered
hard on that basis. Our first attempt at porting that did not go well as =
we have to
reconstruct the build options, at the very least, from scratch, while =
not strictly
difficult, it is always time consuming to figure out the intention.

