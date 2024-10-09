Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A65EDE
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499798; cv=none; b=gdR/c9fQRSkGImyuRiJoUg3bIDHa0g9q1pHcIYmpTdPz5/R3jBDQEBrK1lD5bSib2nv/JQ0jbKR7qesF6frnWcKXarYYjsziUsGk4JQDrDW1ZQ6rKYWgCAp5t65lpaudibMOdVyW5oZ6x9xpfCrat8VkvB86WtyXVzujjncqrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499798; c=relaxed/simple;
	bh=cdSPOb4ly8ZGKNsQDNykI85I3ahenXj6ogq8p8gV+qM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfyY5iH3JKhsO0ngqkzW6sEXFsPFbfqCQkrJDhQhKgQ7Yt8WfDkY+d2QO1ydpDAP5QHzQiCDWl2aKj3YoIHF3zBScHtVatA1OkizBmT8Gofr8+kKMb9+Jvnohl0+qaZNb0hsOQ/YS1hILtv8oTikweBLM+FTP3ROHeuPV+l7Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VaKkTzij; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VaKkTzij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728499794; x=1728758994;
	bh=cdSPOb4ly8ZGKNsQDNykI85I3ahenXj6ogq8p8gV+qM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VaKkTzijF2ag66lb3615BgECpnMG+g/rnvdOVkL21254SAFtKaBim0JX8NXSOlscS
	 Cp9H+sCgJo5fB3WKy5WAWAAxeT3mFrPdnYmGi/8vEY9t5/Mta0gb0Km9Aj9/xL1utZ
	 yOFZN6ec6ZfTZ0XgWvyOvbCLXO5OPHUyRYVLzOiubSrAIq+woYcUv+r60vQOs4EZyq
	 rV6c1JSAo28ZdsY9xkvjL1zpgGUvbVLDZJdDXQTvshz/P7XgZaXgYLsDhP2jSY6gSm
	 ox2Ag99GNUEzQPNSjpEuI3phyRx0YRKNUK5b9LLsqeTpmf7/Y13wBSWOIMfOgTBe4x
	 pUSV2Af63G0SQ==
Date: Wed, 09 Oct 2024 18:49:49 +0000
To: phillip.wood@dunelm.org.uk
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <18nudmdBF3K-9cMiTynl4-amBudFtwKaaZtIkF4E86BwxmjYNV_ISMihIddKiwYZBTEXSbJ2XFliyXDwaGs94pn3Xj8-V8QtggsTgFXl4to=@pm.me>
In-Reply-To: <de748e18-d3c1-4c34-a2c8-086271c208dd@gmail.com>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <de748e18-d3c1-4c34-a2c8-086271c208dd@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 78219fe60178bbff559d86918c0b91f954369c61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------b859b5c2791458920ce280097e86c3e56cf77bb8f5e5cee3b8b0e8cb25070552"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b859b5c2791458920ce280097e86c3e56cf77bb8f5e5cee3b8b0e8cb25070552
Content-Type: multipart/mixed;boundary=---------------------135bb4f93925a86f3eff8630073975f9

-----------------------135bb4f93925a86f3eff8630073975f9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Wednesday, October 9th, 2024 at 05:11, Phillip Wood <phillip.wood123@gm=
ail.com> wrote:

> This is quite a sweeping claim, it would be helpful to describe the
> trade off that this patch is making.

Thank you for your feedback, I'll adjust the language and add some
additional examples.

> but as I understand it while there are cases such as
> sharing a drive between Windows and linux or moving all the worktrees
> including the main one together where using relative paths prevents prob=
lems

This is true, there are several cases where relative paths prevent breakag=
es.

> there are other cases such as moving a single worktree that are
> fixable by running "git worktree repair" when using absolute paths but
> not with relative paths.

This is not exactly true, if only the **repository** is moved then yes it
will no longer be able to find it's worktrees without the absolute path,
however, `git worktree repair` can still repair the worktree when provided
the path to the worktree (or the directory containing the worktrees I beli=
eve).

> It was suggested in another thread I saw recently that storing both
> would be more resiliant.

I'm not too sure what you mean here, but storing both the absolute
and relative paths in both files seems like an over-complication
(not sure if that's what you were talking about or not). However,
this patch series does support the linking files containing either
absolute or relative paths.

> Another possibility would be to store the an absolute path in the
> worktree's .git file and relative paths in worktrees/*/gitdir. That
> would enable "git worktree repair" run in a moved worktree to find the
> main worktree if the main worktree has not been moved as it does now. It
> would also allow "git worktree repair" run in the main worktree that has
> been moved to find the linked worktrees that were moved in tandam with i=
t.

Storing the absolute path in the `.git` and relative paths in the `gitdir`
will not work---it will still suffer from the same limitations that we are
trying to avoid. And all the test cases related to `worktree repair` are
passing with relative paths.

Best,
-----------------------135bb4f93925a86f3eff8630073975f9--

--------b859b5c2791458920ce280097e86c3e56cf77bb8f5e5cee3b8b0e8cb25070552
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBtA9CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAB4aQgAoYw1WfssX4kIWVLuAXdtA1z9A9APaxBXp33kTpeX9lNvwx+K
Wtqphh8P1qN25sKq9ZPXo7QMcJoBV1KIAN6M4/V/dmM8M0UbqnewNckO/byz
eMAd3e5+J+eQU9SC6bRh6RBle1XgJTMGZmXaz4vhFMZqRrFsE92MVby+GESK
hLWkpmqgh2f1sX/jLXz6EgqOtSKLbpVjbgZQ9/+WBztvUlqUK6D4aY4tmuST
6QW8o2KRTl1wBGJ51Re94mK375Hq5MvhLowktyGdv1z75s5dfRdIswLD9vI4
gOOWOOTuv69KjVNeuwihbM7seZ7nnbtrP2Ui0gv3/scZ2APGhp8AsA==
=S4G2
-----END PGP SIGNATURE-----


--------b859b5c2791458920ce280097e86c3e56cf77bb8f5e5cee3b8b0e8cb25070552--

