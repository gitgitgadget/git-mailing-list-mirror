Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27A27A12B
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775083; cv=none; b=T7PMDfW8fBUPu9ZPFig528dwrx475GqV69G97j/e407Vri3R/dY8qZDHq7pUZtDocAD24mI5i7q/szJ+ESaiSVk5SfHsNzKW6E4Ak+0eFvzpYRxln8md/4unBHiXLEA9gNvBg03qCc7vTcGFDgGh439ZwONtNdpjsNiVCLjJdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775083; c=relaxed/simple;
	bh=BD3C1+8mVXa3NGDZSB9YItpr1MkYkm3Xk29LY0tX04s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSr8D3CoQWMXP2D+T8D2sQQa0bPBG7QUCB4QOf/jQWG+L49l67hFgmV+ZYNWkhLjvlDTsgfkk6hDLWYHXe634n3mQDh056QhufiAPqVqtTKWdUz5AJWo0o1wcfo1a1KVxr24qjkmhvU1qEgGoSjGGnb8q23hoqwd0PWE6wBoL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GUnEkcUn; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GUnEkcUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ro4ktxoz2zchbc4koz727pmeuy.protonmail; t=1759775073; x=1760034273;
	bh=vfjwJ/t91psG8SmRsqT+ATkaaVoxcRT5V0W0wMpradg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GUnEkcUnp32e5aE9LWFGMoflHDS6rPrB057n+r9Imea8Q2/qTawb4LAQxzF6hWBSd
	 ilE6wBmbAPCLyM3K/ZDTPHKv5kpJI4Ts6RkVQXtAVCmwT9d2hM4jIWBn0Hhwumwmbw
	 UmuQTRNfnUOkQkfSnRwFHPizQK5qaOPhvuV9axOeAhwu2sk6hJBTkV8gg3NcHiO7xe
	 pQ91H2Nq5VSwGDT4zUF5Rjke+48vDVHVXNVyDrshE0Ub8g/Q3HSSiwlKgR7iVO0/Py
	 EZd0wwtjUU5VqDdDyMP95VTH4s5BiuS5SiIDBILqyiZRD/lLXB2+T3lDsDg0Uajgpm
	 IjX+KMnRGKmhA==
Date: Mon, 06 Oct 2025 18:24:27 +0000
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
From: Miroma <its.miroma@proton.me>
Cc: Miroma via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: don't show irrelevant entry count in status
Message-ID: <yrvfy1J5dHVBqevuewPCrDR2ukgdZpMmXCwmKlk0jWBdLwzHpUrgNSh7e03ZMeIxnnN4aAFmpfvac_iDoR8lCTPFF-vk85Esir1zTp0eElk=@proton.me>
In-Reply-To: <xmqqtt0cosiu.fsf@gitster.g>
References: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com> <CAOLa=ZQVZMNXjZzSDCc9SXxRuAhRbo7hc-F9RmhYap=ABWVxzw@mail.gmail.com> <xmqqtt0cosiu.fsf@gitster.g>
Feedback-ID: 106560626:user:proton
X-Pm-Message-ID: a5f9510a2091dbc958b7baf04fca2b74cf8aa0c0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------11b7b9de8d8404fe34cfb7b491a4323c091070d5afd36ec8354b3dad6552a408"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------11b7b9de8d8404fe34cfb7b491a4323c091070d5afd36ec8354b3dad6552a408
Content-Type: multipart/mixed;boundary=---------------------55afddcd073363e833dd72b1af7a25a5

-----------------------55afddcd073363e833dd72b1af7a25a5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

"Karthik Nayak" <karthik.188@gmail.com> writes:

> "Miroma via GitGitGadget" gitgitgadget@gmail.com writes:
> =


> > From: Miroma its.miroma@proton.me
> > =


> > Currently, when status.showStash is set, 'stash pop' shows the
> > following, confusing, output:
> > =


> > ...
> > Your stash currently has 1 entry
> > Dropped refs/stash@{0} (abc123...)
> =


> =


> Right, so your proposal is to not print stash related status information
> when already running a stash command. It would be nice to note that
> here, along why you think so.

I'll update the commit message.  Briefly: I think the stash count shown by
'status' when called by 'stash' internally is confusing, especially in the
cited example of 'stash pop', because the count is immediately rendered
obsolete as the pop drops it by one:

```sh
$ git stash pop
...
Your stash currently has 1 entry
Dropped refs/stash@{0} (abc123...)
$
$ git status --show-stash
...
<no stashes>
```

> Personally, I think it is important to keep this as is, because it tells
> the user the entries left in the stash post the stash operation.

The issue is that the number shown is *not* post the stash operation, rath=
er
before; I called the output in the original message "confusing" because it
claimed 1 entry, then immediately dropped it.  The real count after the st=
ash
drop is 0.


"Junio C Hamano" gitster@pobox.com writes:

> When pop sees a conflict, it keeps the stash entry, and whe it does
> not, it discards the stash entry it used just now. So I agree with
> you that the number of remaining entries may be something the user
> would want to see, but in do_apply_stash(), I think we are getting
> the number before popping, as dropping the entry seems to be the
> responsibility of the caller of do_apply_stash(), if I am reading
> pop_stash() correctly. So, I suspect the current output may need
> adjustment if we want to keep the message and want it to be useful.

Yes, currently 'status' shows the stash count, then 'stash pop' calls it
before the stash is dropped.

A possible solution would be calling wt_longstatus_print_stash_summary()
from 'wt-status.c' here, once 'stash' is ready to show the count.

> > So this block is run to print the status, unless the '--quiet' option =
is
> > used. So it makes sense to do this here.
> =


> =


> Does it? What happens in existing GIT_CONFIG_{COUNT,KEY,VALUE}*
> environment variables passed by the script that invoked us?

Good point, I missed that...  But find a solution below

> If we are spawning "git status" here, can't we do a much simpler and
> more obvious thing, i.e. "git -c status.showstash=3Dfalse status"?

I found that 'status' knows of the '--no-show-stash' option; I'll use that=
.

> > Small nit: Shouldn't we add a test to validate this change in behavior=
?
> =


> =


> Yes. I am not yet sure what the right output should be, though.

I suggest the last line of the output of 'stash' commands be the count:

```sh
# assuming there are two stashes
$ git stash pop
...
Dropped refs/stash@{0} (abc123...)
Your stash currently has 1 entry
```

-----------------------55afddcd073363e833dd72b1af7a25a5
Content-Type: application/pgp-keys; filename="publickey - its.miroma@proton.me - 0x433A3299.asc"; name="publickey - its.miroma@proton.me - 0x433A3299.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - its.miroma@proton.me - 0x433A3299.asc"; name="publickey - its.miroma@proton.me - 0x433A3299.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWmhVNnFSWUpLd1lCQkFI
YVJ3OEJBUWRBUk1JZ3BkbVJjL1gvZGFYemhsM1RhZjNXQmdSNTVMeWkKT2hlaEFXYUhoKy9OSzJs
MGN5NXRhWEp2YldGQWNISnZkRzl1TG0xbElEeHBkSE11YldseWIyMWhRSEJ5CmIzUnZiaTV0WlQ3
Q2pBUVFGZ29BUGdXQ1poVTZxUVFMQ1FjSUNaQmVLdkQ1VksrWWZnTVZDQW9FRmdBQwpBUUlaQVFL
YkF3SWVBUlloQkVNNk1wbFpsQVptTDhKT2dWNHE4UGxVcjVoK0FBQlhsd0QvY3c0bEQwUXAKbjd1
Q29ldkRmSWM1ZUprUWk4UkV5MW5VaUpRS01zRTRxMnNCQUlFcDVvZnRLSjJPQ1VUSDlvMVRlaEJR
Cm5VRktNcy95NHpaaHU2R3h4RDRBempnRVpoVTZxUklLS3dZQkJBR1hWUUVGQVFFSFFLSW5ya1pI
ZHNraAoyVm5BK3VvQmc4aVlhSzdXUGhOdGJoQlAySVpVNjZrNUF3RUlCOEo0QkJnV0NnQXFCWUpt
RlRxcENaQmUKS3ZENVZLK1lmZ0tiREJZaEJFTTZNcGxabEFabUw4Sk9nVjRxOFBsVXI1aCtBQUFr
OUFFQWxPcVB2WUloCmNRdE1pRnFpNzh0RXNsRk51UjRSYVhhTkJUcUhPeHFnNlNZQkFNOTdzRWpI
TUlCNEZoejdCY05XZFFKeQpJVG5JbGxVSUZIS2dVNHRuc0k4TQo9VzRjcAotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------55afddcd073363e833dd72b1af7a25a5--

--------11b7b9de8d8404fe34cfb7b491a4323c091070d5afd36ec8354b3dad6552a408
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmjkCUwJEF4q8PlUr5h+RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeDuOhDwIWDW/W2nZYl/DDyAaKn8T4WTzz15hov
yJhzrRYhBEM6MplZlAZmL8JOgV4q8PlUr5h+AACNOQD9GMR7DzMIJSx7Cqdi
C6unSAHsNjnzVFT3/dX/q2y+K0UA/RGREj5XLpaJxQriueLXIRKwgnnn9Q4Q
yo/3MnjZs+UJ
=/yzm
-----END PGP SIGNATURE-----


--------11b7b9de8d8404fe34cfb7b491a4323c091070d5afd36ec8354b3dad6552a408--

