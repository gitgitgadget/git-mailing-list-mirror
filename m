Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1ED3BBDE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402835; cv=none; b=HlJMcaOynksEwv2zZM/05/kYYr4qpKUlqqq3kTvKXU36U0I3tgXgVD9azFQK5Y7ujsFN1nk/5pSXL5Jis1WRXxyTCxYycSi1EkYY+8NMs60OucGqeFvSzatpwVL7TME1UkZnsrrJQus6qj11ETbU7w8NAxfWTTcpitksoh7pX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402835; c=relaxed/simple;
	bh=YRjWQ8soWFBtNfRGj9KycQEcT7rwvNGW30viipOLOyo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhFYJ7NYAxszI24ja2rO/jbaU5AYuL8Fb8sDVp/931oaobZ0INd3nWtqmrEl9LJvKY5v8ROtIKJzRxgRNtOU78+L+cdBajcCkeYSeZmSA8srGjBo+8NkL63u15A/TJJc0W4jC8FaGgrysH1HiILa20n9am0fZS8MZL5zjW8ir/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Dj/GeFjm; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Dj/GeFjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728402831; x=1728662031;
	bh=+1YEFRCLMqTdOFJZUFGccYifDBOpKyASX2mex7vMlq4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dj/GeFjm3eM+zLr7CxoKHZrgS/Dq9JLcHzCJ+weA8Tm/hEZbanWajNg2EKTuqgmLc
	 AYRZ63UesJ03dBq4Z/F6sQ9nDmw6d7vS9rXazoK6TEEoZNtqNj2fSHRzmQFjRrpnxe
	 9Cc1+BmHa8EJzPfyxF5C4DKHO416AXRZV5NDn+o4btibAb72VZyZrrLoq4vGc107MB
	 sIu8/8jN/vjer0eviOFBd6uvMtNEexpgYybF1kO+jNxknrRurThMHLOAOf3hLHp1og
	 tpJ+8FaUBKlw5AagTsqlNJDyocBAK924O9wo/DEPJBRBDfxzBZswq2ObjHCfuACyaj
	 w/0BX0vz11hBQ==
Date: Tue, 08 Oct 2024 15:53:46 +0000
To: ericsunshine@charter.net
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, russell+git.vger.kernel.org@stuart.id.au, sunshine@sunshineco.com, cdwhite3@pm.me
Subject: Re: [PATCH] worktree: repair copied repository and linked worktrees
Message-ID: <r4zmcET41Skr_FMop47AKd7cms9E8bKPSvHuAUpnYavzKEY6JybJta0_7GfuYB0q-gD-XNcvh5VDTfiT3qthGKjqhS1sbT4M2lUABynOz2Q=@pm.me>
In-Reply-To: <20241008153035.71178-1-cdwhite3@pm.me>
References: <20241008153035.71178-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 70de43fbca257c7c63ff0170ac14982d8e99659e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------a949510fc7052e26ecb55329e7bf51dfc613d2d7e198fd757c7fb7deacbf5c59"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a949510fc7052e26ecb55329e7bf51dfc613d2d7e198fd757c7fb7deacbf5c59
Content-Type: multipart/mixed;boundary=---------------------2ae4bc2d3523c169eeffefe56b393287

-----------------------2ae4bc2d3523c169eeffefe56b393287
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Tuesday, October 8th, 2024 at 10:30, Caleb White <cdwhite3@pm.me> wrote=
:

> test_expect_success 'does not repair worktrees from another repo' '
> test_when_finished "rm -rf repo1 repo2" &&
> mkdir -p repo1 &&
> git -C repo1 init main &&
> test_commit -C repo1/main nothing &&
> git -C repo1/main worktree add ../linked &&
> cp repo1/main/.git/worktrees/linked/gitdir repo1/main.expect &&
> cp repo1/linked/.git repo1/linked.expect &&
> mkdir -p repo2 &&
> git -C repo2 init main &&
> test_commit -C repo2/main nothing &&
> git -C repo2/main worktree add ../linked &&
> cp repo2/main/.git/worktrees/linked/gitdir repo2/main.expect &&
> cp repo2/linked/.git repo2/linked.expect &&
> git -C repo1/main worktree repair ../.. &&
> test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
> test_cmp repo1/linked.expect repo1/linked/.git &&
> test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
> test_cmp repo2/linked.expect repo2/linked/.git &&
> git -C repo2/main worktree repair ../../repo1/linked &&
> test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
> test_cmp repo1/linked.expect repo1/linked/.git &&
> test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
> test_cmp repo2/linked.expect repo2/linked/.git
> '

Apologies on this test case, it should be:

    test_expect_success 'does not repair worktrees from another repo' '
	test_when_finished "rm -rf repo1 repo2" &&
	mkdir -p repo1 &&
	git -C repo1 init main &&
	test_commit -C repo1/main nothing &&
	git -C repo1/main worktree add ../linked &&
	cp repo1/main/.git/worktrees/linked/gitdir repo1/main.expect &&
	cp repo1/linked/.git repo1/linked.expect &&
	mkdir -p repo2 &&
	git -C repo2 init main &&
	test_commit -C repo2/main nothing &&
	git -C repo2/main worktree add ../linked &&
	cp repo2/main/.git/worktrees/linked/gitdir repo2/main.expect &&
	cp repo2/linked/.git repo2/linked.expect &&
	git -C repo1/main worktree repair ../../repo2/linked &&
	test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
	test_cmp repo1/linked.expect repo1/linked/.git &&
	test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
	test_cmp repo2/linked.expect repo2/linked/.git &&
	git -C repo2/main worktree repair ../../repo1/linked &&
	test_cmp repo1/main.expect repo1/main/.git/worktrees/linked/gitdir &&
	test_cmp repo1/linked.expect repo1/linked/.git &&
	test_cmp repo2/main.expect repo2/main/.git/worktrees/linked/gitdir &&
	test_cmp repo2/linked.expect repo2/linked/.git
    '

- Caleb
-----------------------2ae4bc2d3523c169eeffefe56b393287--

--------a949510fc7052e26ecb55329e7bf51dfc613d2d7e198fd757c7fb7deacbf5c59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBVV7CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADgYgf+OtydBq1B4/oPy9S6s0mF4sEqkiFEu9XfaMPHKz6V0ZPzny7W
yiGFgzHpNMB/YEH+MK/BJJBgFZFF8drLvfDk0I9234heW3D0Ctip3pzpgrI6
k1Se9BZQqcBFpIy6xvsPZCrjyjkVf7fQrICABVxwI4QcjFaunenaSoljFFuR
8Yi/WZgZBYmpR30WOW8DUiIH/fJPy2ORowMuX7ZBlE41R6mOHd2dj6JmfzBY
TwhCr8pG3vx6kVi4uc3bnqM9yFxB+LXs5jMK+c6c6fd9DzwKXTAddCupQog+
foknLWA6hlpLJYt3kxpQki3Ak2wfV5W6htVRM1sIwNArBGnUCLPmPg==
=Gw1Z
-----END PGP SIGNATURE-----


--------a949510fc7052e26ecb55329e7bf51dfc613d2d7e198fd757c7fb7deacbf5c59--

