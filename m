Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C95B5BB
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666247; cv=none; b=CDuF5DFN4FtJyIZazU7xzJcMv4CdO5lJmOs1pLBZ35fAGZdCkJL6r709poP4UzrpKM40Td/gSAEhYhw6bBjpac9HP6BeZRm2+ioa5Za4AkU6hqnf1hvv9ZNieAO5bGwawBuOtV9pENLYMX34a6Wdoi/eFCfWFWYRj73Ff4vwA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666247; c=relaxed/simple;
	bh=p3p0F0QGrLuZzvK4SeQW1dKFbfQYSPSJG4TmU/Dolu8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVJLj1dZXWGqPL5xq45xs73q/TPUB55S6PxHVpWS1irl00ZsjpVQimvpAClQWDovgjulnENI9tGQcsWBcetFWIg8iOZS2boIj1D7/v1wGhSUMnDdAxMJ/9CCQRWbUlium6PTcqsNzEEmXvHQcNdPnv3lAe5S3PjLtvhifGGCKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=CT11izTq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="CT11izTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707666226; x=1708271026; i=tboegi@web.de;
	bh=p3p0F0QGrLuZzvK4SeQW1dKFbfQYSPSJG4TmU/Dolu8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
	b=CT11izTqgvcP2rq6iT8/3/MMBQphmXRYUXozO/26QqFn4+PIYX0xL6XrScZnHDam
	 Gj5aniMdxBM8DTAaGwOw9A5nmTRPepvIgNWAXL6dNHui/tBsgUMEdEbVIvODHFUjz
	 HUYeYYw18qXKEsLRb2fvaUzahSJ8dfkBsd5TKfb9pT2t9bF90EnllMBOtvMxECUq1
	 TiwdVEJ59lhymA506vNihEQZjJ/ZnqdfzRFCZa6FyOEIdotw4rDb7bTrygRlcDao+
	 PxqAR8dwiBgdExj6K0ERMGphjCpXozi6FKRcNvz4bKrIxJwqCdrs5bGx58aH1x0km
	 7lnItWZ/giF7U0y6Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1qh5PK2f9A-00uEP7; Sun, 11
 Feb 2024 16:43:46 +0100
Date: Sun, 11 Feb 2024 16:43:45 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	K_V <zinen2@gmail.com>, git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
Message-ID: <20240211154345.GA28699@tb-raspi4>
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
 <20240211151455.GA27103@tb-raspi4>
 <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:SVZi8ZzySMBlTS5k1gBmQuFaijwCn2cMxXROZadVtb/Uqw8MmzT
 SBQIBamjXpnj6MLfLvbFaDv8OoaafM8kxQzEBs3bcau3/c8RQ6O6lJHAW1pkuCp277QV9O4
 Mo0XsJgQQ/Ed6DweXZNd6eagFYeZGu5OOayyPnlJhyQJFIz7miyERMqub09z9E3LOyJmm43
 draJXsaFVSdhDeR2KhApQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lyXUpOtejP4=;AvWXGKWRTTwJXD7EzX2oodTuFMh
 iI4MLMtdRfY4V9yzHmq8z7wELOs4lL+kUiWToRWqEfxYe9lRnvOMaQ6bKbfF5NTsESwg30YK3
 GMPSmfkuDzTPjCRV97VGSEFNW3qCFoYXHUOXKn7gQBZXL6nCWLcDS34qx7/4f43kTUHlkDUSO
 aDoeDL3lki5/AhpRbHIY9tAkP9g0xGbECQOtYrYXO5uq2wDdMKciAcx3Wrrw0thso8Sm9Rdab
 z5CxChb825qHKnFs+BuM8iFH5VcfBXSt0tTcQHRHUl/daGOIQzHkfn9a+bOn2Cmj+olL6ciwL
 HkGIpYsVdqEtX2g6u0HrsTjGH0ui6leu+S+J0UbAUHJp3WScHIt5OOpSFGcQr1ONkBEE3BSy5
 0ls6LMnpRHIoIigtDgCqbnJyJD5hsj3Gwt/R9LAfXR/p9Nh849SO6s52Aflvna08MdOGK2dlo
 86XyOvcWzFUneNd0Bj8Qm3inu4nTf8NBb0i9JrYh8Q//vXv0q4V/kFsjvdCb4T1U5iDsU+RjM
 Ok9oHIJfM9os5KsI5pvjIEXzQ+WTgQ05AeC6dzmsAyX5LeeSxzZy3L64xFWIN4jkGbbnUhyaX
 hwdh3ZSDa/TNMNEat1Ea7j9q0jTTmxbk02LIcTCfYzmJhluvWtZfr30i0yp+riQCxuQPLttMB
 8AokLfvBmty2BxFJUW4ljuQ75XQouuBzemtEcUKkdu7cWx8mGWuEgzWMv7SXkI9N5AxLh5Bj3
 Cim64KdxQ+KSt6BbXw82xh5dr/B0I33m+ibIT7JkminHexpM5yhqD1yAm8SAgRie1CDstUmtM
 nkW1kKPFUTs/OVOh4vr5K6gZ3jchAXwhqzYf/QEsNXtWU=

On Sun, Feb 11, 2024 at 03:28:57PM +0000, brian m. carlson wrote:
> On 2024-02-11 at 15:14:55, Torsten B=F6gershausen wrote:
> > Thanks for reporting this -
> > I think that you have a working workaround ?
> >
> > However, Git has a feature called "shared repository".
> > You need to define a (unix) group that is shared between
> > your user(s) and the ansible user.
> >
> > The basic trick is to do
> > git config core.sharedRepository true
> >
> > (And then change the ownership of all files/directories to the new gro=
up)
>
> On Linux, you also should set each directory to be setgid.  That's
> because by default, Linux uses the user's current group ID as the group
> to create new directories.  However, you'll want the group to be
> inherited from the parent directory, which is the behaviour when the
> parent directory is setgid.
>
> This behaviour is the default on the BSDs, and no such configuration is
> required there.
Briam, Hm, I wonder what this function (in path.c) does:

int adjust_shared_perm(const char *path)

According to my understanding, it was included into the Git codebase
to work around the missing "setgid" feature in Linux (and probably cygwin)=
.
And then we have t/t1301-shared-repo.sh,
so I think we are in a good shape: for all systems that have posix permiss=
ions.
and do not overwrite them with facl or other features.


