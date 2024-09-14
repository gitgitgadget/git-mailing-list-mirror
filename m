Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB578C89
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726339328; cv=none; b=lBgfNFPnxDbABXAsCl7zIeBBZGZZg7l4GDT9iqxI+mT72YhLy8oRx3y2oau+E0t8Ve3shI2o0M7b/yDkobUgcO3VjMkt/p0Vt2NWG0IrHt1+7LnOb/PrGHxL1wwWcv7Ivl5bGrLQHNhWFwy3yTTzBTaBvVVmMlFnMF5mSfmuXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726339328; c=relaxed/simple;
	bh=/f9Oj44GnzJWSyFgGzMi+sQCzNSxZFySf6f+qWyOcbo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gKo/ohnbfpsSkSFwyA4nagibksdrHI03msAXpZwa2H1EFila/AIbEC9tTyz5mqgWJfWayb9lFvM3Mw7Iu6a6obzPDG/GR0cTjEz/3RZGgI7fr3eUCawHT6DtCKf4iC4tcy9ZFR4H3wGIOcfIXuFlgv2aPIpr+LpHMVrsHmbOlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dpFIfLHX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dpFIfLHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726339318; x=1726944118;
	i=johannes.schindelin@gmx.de;
	bh=/f9Oj44GnzJWSyFgGzMi+sQCzNSxZFySf6f+qWyOcbo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dpFIfLHXMrkcuHIhTKfvcBhGn29gDvCL3nzJeN2Otxmp7dUR1NGqE81KPjKlCCNX
	 G5IvKMnUKVzJtI0TV5LB3dCPR1HU0k8OTHRIQSf6ueGjpBFTT7r7pCQT0VtKYBvRP
	 lbvCJzhM4Jfld7+gONuOu6Kv+4Ige13DR3GMtmSjeVHCZFptq47IgOkiaZagK2H1w
	 EwK1xkTUG0FZnoE59E9jFfdzwhkKBROdosMfruGqJ/bkkhWvAJgVpilG3p9k06JLS
	 HGk5uyVXXM0iHyUF2lE0/Lh9dRVH+4pyF9S+aFzrvvbzkELzlkppd0tQeJcPnLn/B
	 QBWoExDueqlBGnVidw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1sw7I60Oa0-009wH3; Sat, 14
 Sep 2024 20:41:58 +0200
Date: Sat, 14 Sep 2024 20:41:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, 
    Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
    Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <87h6al9ujv.fsf@iotcl.com>
Message-ID: <702cec20-a1a2-40b4-de8e-305b63a92b26@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <155bc141-a16a-9fd2-920b-7a8c398d5e36@gmx.de> <87h6al9ujv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BifYlms5vMAOFRPSftv/0Ql5uZqW16ax1aY7te4VBAo0fEVTZGX
 6MIcY5csdWQRgSjgSvkQpScyipAq0gp6gKqLz6wskigjUtjtIHSnfKmOzszFy9HC0WLrgBK
 dEouFI0cpVrXtFWAZikWckmQpIH6hBMAT8tie4GjssmNJ1rtNpga4t2m2Eb+i9mBK4eDFcb
 CkR0MWH7IRG0DNSU1ByKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0OoHzj+6Kzw=;JiGFBe0DI9sF+qef9Spv16gCxBg
 0uc4FTFWdF8BpvCIQCaEKxa5niyQRM4TIrjEy2dqUn4Q86PCsB2yhacf8PD4IoyDuxM8Y0bSd
 0nRlpTwV9OwDVst8EiHBG5EdWud9A4ERnf9imVYgvyBc+Ry/6KfI1Qq6VCUiax0eGjHW9GSRQ
 n4NCcsRkskA6RYAXeq/HqjAYQzSSJi603LeVhC4crXFyUSMHxjYNNTwzyfh4NPM+O9zt/SfoW
 UUVuWHzslMdpcRWZrCPELaZJ4rSbVaCA3gqD770iMXedSi1/zWTH2C6fWl0YsrB9AYf2nOsB3
 /Ox7CG8Hf1CRlkmf7fLUeeFBgO5EYCTy/vmZnMvRdTG7vVUmC/L7FPtNQ4DrLdGlOtzw96KBp
 8WJSaZQNljykDHPbpoK7SYHd5tyNnQ4vWPLrb1r6/d7N2Poy27OEwGUnl4OKWt8YrqKi1/Ulx
 jO7TWeNjh4HIi+9xT34E+0C0Bj7lSTe4jJYLy9a8pYbCmNVHiIcwH2cKAKHYo1d+xkw3l1+bV
 efGNVOGTE56m2bgFrNgh3CWJZKLyNhc0Au9H3TKqIVbuMYynfARcW6MjSnVXS7pNSktywWWn9
 HsFQLHJMHErvmTrVxzvhjAEiDHGgQVYrVfQCl9xDx/L65mrT7SDjAapYnf4MAUo2G0LmXZL2B
 gW/WkAKL8dM2oz20As73vs+fLd5+xJoc0joqJd0e8xM9yiYBA0Cg+gOEjTJq0nFHtpyRjVCLl
 gbmIJQJG8rUwD4lpFnpUG4I4Im9V3wRamsnjGEYHq3hKkCpnlkY4S3o7ITGYDsV6ItPY3qNZS
 v9ZmYeRhH2G/NLTvAaqwwm5A==
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Thu, 12 Sep 2024, Toon Claes wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Me again,
> >
> > It's time for the next update, after working with Pagefind, lychee and
> > Playwright project members to improve on this effort. Here is a focuse=
d
> > list of changes since November 17th 2023 (when I sent the first RFC), =
in
> > descending, quite subjective order of importance
> >
> > [snip]
>
> Hi Johannes,
>
> I just discovered this effort. I didn't realize this was happening, but
> I'm super excited to see this going (and being picked up again).
>
> I've been doing some testing locally, and I've been posting some
> comments on the GitHub PR, with small patches.

Thank you, I integrated them!

> The biggest thing I've noticed is there is still some work to be done on
> the search results page, for example:
> https://git.github.io/git-scm.com/search/results?search=3Dbundle&languag=
e=3Den
>
> I assume we'd need to inject some of our CSS into the pagefind results.
> I'm happy to contribute to this if you like? It would give me the
> opportunity to play with some CSS again.

I would love it if you would make those changes, and would be happy to
integrate them into that PR!

Thank you,
Johannes
