Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE21E0E11
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424558; cv=none; b=iIYE1lN/QPW9uCwuflk5mWlZPQI1IWi6rBgKEAuMisuaCdfWcVyyAN5FIHWmvhAjSAMla0khzqXR8mP3j4ZWZdWq5UpEJr7PA2rMScKBu6n7QdfCYWyS/q4JHMVn06kwTh/ZCsqJhhgbf+S9/dDAnUos1uxrC/UT0EijpX4JaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424558; c=relaxed/simple;
	bh=Bzbsk49xrWLH+AumyruGZyqAoPmlrub4PoJ0dM4Cp9E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTcEZQQ+0YbNviOoWtdvrEAFN5A1+ce1qBu8h8079d1zL9MVAhANRY9cHS/jQ+u8fZdI7S+CE/fLc7ZHPgn77bep3l8FujxefhcmJZ5jbmlYFz854WXVPg4fSblgoRC6XtmS22S25Cb0u5E1cGbXlfEkqJ93SD1V8lB/L0holNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JRuaYltX; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JRuaYltX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728424548; x=1728683748;
	bh=Bzbsk49xrWLH+AumyruGZyqAoPmlrub4PoJ0dM4Cp9E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JRuaYltXtynDFeD0ZI+/YueNWAK5xRgz6rMJOtChBkmtJOwsxjrnn7zM8ZiYzxnrr
	 XShITSMWHJAuTg+zBsis+64ljHz3C2MpHH6SIqrgvFb2FRQ1TbhCtAhutcTaeszn03
	 1EE3ZyQa1nz7ELIQxQottee1HYnHNfnYsJk5osU7Tba/Y7cXRlAqEuGujQ70yYZggs
	 06oBij94Kg5EDFtvgrsxpgISLUbOEtWLJ/Qu2GDewKJhyz9ECajmBKTYrLqzEN4XP+
	 Qwv5NVaXWHV3OvPFidjE5QJB0ZfV7NOZl3Bx0R8aWhEhFqePgYp2YIjSftod/umRxE
	 7nLK8NwurX+Fw==
Date: Tue, 08 Oct 2024 21:55:45 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] Link worktrees with relative paths
Message-ID: <qBPeXsmRWeJG-VRJyU_75S-f6dZWTlXQx0PjXmc9FMOrciammmLNivZ6kRt3mWuWC9x9W65FeU2Qdc99VvXGccLtdxnMctxeJqN92g41l40=@pm.me>
In-Reply-To: <xmqq5xq21kub.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <xmqq5xq21kub.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 2351562814abfd7312f7ff7c8c4f3781ef605c26
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------9434b4e8982e1b379ba67a9e552c5cb5b288a501651a4048d7a6996e872efa09"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9434b4e8982e1b379ba67a9e552c5cb5b288a501651a4048d7a6996e872efa09
Content-Type: multipart/mixed;boundary=---------------------8a9fb28e7ab498d1eba2c468e2867956

-----------------------8a9fb28e7ab498d1eba2c468e2867956
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Tuesday, October 8th, 2024 at 14:00, Junio C Hamano <gitster@pobox.com>=
 wrote:

> Caleb White via B4 Relay devnull+cdwhite3.pm.me@kernel.org writes:
> =


> > - Rebased onto 20240923075416.54289-1-ericsunshine@charter.net
> > ...
> > base-commit: 4ec4435df758668055cc904ef64c275bc8d1089b
> > change-id: 20241007-wt_relative_paths-88f9cf5a070c
> > prerequisite-message-id: 20240923075416.54289-1-ericsunshine@charter.n=
et
> > prerequisite-patch-id: 78371f4dbb635e6edab8c51ee7857b903e60df8f
> =


> =


> It is more common on this list to explain how the base was prepared
> in the cover letter, something like:
> =


> The patch was built on the result of merging the
> es/worktree-repair-copied topic, i.e. 992f7a4f (worktree: repair
> copied repository and linked worktrees, 2024-09-23), to v2.47.0.
> =


> To help those who are reading from sidelines, the above may need
> some deciphering, as the patches as posted do not cleanly apply to
> the base-commit 4ec4435df, which is 777489f9 (Git 2.47, 2024-10-06).
> =


> $ git grep '<2024092307...charter.net>' notes/amlog
> =


> =


> finds that the message resulted in 992f7a4f (worktree: repair copied
> repository and linked worktrees, 2024-09-23). So the right base to
> apply them is obtained by checking out the v2.47.0 and then merging
> the es/worktree-repair-copied topic (which is a single commit topic
> with the 992f7a4f on it).
> =


> $ git checkout --detach 4ec4435df758^0
> $ git merge --into cw/worktree-relative es/worktree-repair-copied
> $ git am -s ./+cw-worktree-relative-3-patch-series

Ah, thank you, I'll make preparing the base more clear in the next revisio=
n.
This is just how b4 tracks things so it knows how to apply the deps.

> And of course the series applied cleanly ;-) I haven't read them
> yet, though.

That's good to hear :)


-----------------------8a9fb28e7ab498d1eba2c468e2867956--

--------9434b4e8982e1b379ba67a9e552c5cb5b288a501651a4048d7a6996e872efa09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBapSCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACx/wf+IU7KwNGFPbCUIHFY+7+H8a4WWLba4yxrJsUzPwXly/+nF6BO
11iCnbKd2ZVj1FIAfZJ0QQ6wn8x2omRP3yY9nsU/Bg/rMljGl0fuwUeyaPE8
AQLCJ2mFV6PR7k8OTF93O3uXw187+OPQtDB3lgltmFDLpiTWc6D+JnBQ+FE3
yYfVgtb/ipZtksVlA/pALNHxSjKHq1Mdnc8pYNzMisvabIw3JmAaM4bwGxHZ
5LeAZDd9hdMabkEKvM7fCecCRQzi+88AqQ4iYNRrNm2FXGRapBR4U1MSFdq+
HnJKmPBT2aSh2E2L+in/m9iwb3OpQXUsp15XsMhmjwuzXp9KTgjF/g==
=S1EV
-----END PGP SIGNATURE-----


--------9434b4e8982e1b379ba67a9e552c5cb5b288a501651a4048d7a6996e872efa09--

