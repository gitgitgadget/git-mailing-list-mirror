Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D01BAEDE
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093130; cv=none; b=nDsHOTWaXIPiqkggBGopAMkpoRVEAZavhlMgDB6L8jzlL5H3f7ONOVvxS8LthV9XEGKjQk6yH037OLQ+eur7NuhuCYes3gj8z0GohH6jhVgqwMJfEOOV0rXt3nzPHv2r4Av4hdBn7SNYwm5lOXuR8wIhSwBhZ9CA8RIxpGVrlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093130; c=relaxed/simple;
	bh=Xx7itID3P6MSXpXcmcPb60RpOh7N7l5oLPg5vwk8LKs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YQWhE/uT0JJw5Fl8l1pXzUfKtF8SiIiqwOlA5zAEA5GZEyWkYHsu50CoorYlh/pqYw9W/s8DblLZ18sCwToQg91xe4lv8EIyj7xwv9VL9GISH/yRC4+fVxiSXCvJrVO8f8+CUKqG/VoWImb1kKO1usq3M5RDS9jCiXV3yGVHvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PnRpGGab; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PnRpGGab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726093123; x=1726697923;
	i=johannes.schindelin@gmx.de;
	bh=Xx7itID3P6MSXpXcmcPb60RpOh7N7l5oLPg5vwk8LKs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnRpGGabUcy8DOd+wfQcxdyuhvwlMo5LK3E2J2sHyLGJe9gTPgskRunNbOqxVImU
	 4/Cb1QKE4nCWEss4EWXakWTvvKrjhy39mIfWhN+Z/ADnZoR2AiKIQgb6rXl+HCZmf
	 C1vY4/PpZRJvUVCfFpzdHB23L7YTwG+ouASMYgpSifd/m6XuS26juePrKlZg2obCk
	 zWmHULR83CK2XiVq6kxYk+EqgQepkY/PP1eE0k9yYKrs8eA2LZhHVPj97LOKC8SBE
	 DgwkiThPlSoBZdTXVKGl+5bcNGscrgpne6fWJV+UMcd4D+TVCWCjWjm8DZfRD1wGh
	 1D75TL4GocKQG/tp6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1sUFmD14h8-00JJGH; Thu, 12
 Sep 2024 00:18:43 +0200
Date: Thu, 12 Sep 2024 00:18:42 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, git@vger.kernel.org
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <807be06c-e70c-4ee4-8851-bb8d82b68ac2@gmail.com>
Message-ID: <c36ce70c-59ad-c53e-8ef6-cce779e428eb@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <807be06c-e70c-4ee4-8851-bb8d82b68ac2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zf2ryyGHJEk6LdSA5XW2BdD1fGY/RqSp+WI1Vg6W/VYhlRdpvFJ
 2gNL/nUHUSRR8rdjOyojg3e1M8oqkXGmN3/6sRyl5BrNm6KS3qnisOy9kR4W85ROQbsBRlQ
 eg944Ji8vuaNDtpIwTGHy8jiTv44hExYfXoig8B+6J2oFs9YFZQtxsvZse2D6AF5EYnEmDL
 1YSQ/1MFr/asVuqvBQbpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FndBd7C0LfU=;isFxQ4xRPBMmTcy9ilLL51pbTDb
 FiCb2JhU737PbAiymJuRhuHwr8A3oG9LOV++/LFTMuH2+LPUtr4WDt7+fxWrmC8JH6DfLvM+S
 ZB4zlbQeRWRUthsR+WlzKXlr9zVCNE38KGHF1/+IqcZqZV6T3GaGXOGI+1DB5lZP0KPdCCZOC
 RLGM6Nh9Z9f02RFe8VqCRZVcxTREks8IrPKIKmAdJHgZ6B7+pyJNdJufQzJIx/C5cqAbO+YdO
 IXEWADclg7JprAsqtbE3bzngXMqGo/gQgyDOjFbBnhubIUnsfO2PUSqPINqyl1m/tda2tG4Ak
 3Za4zWbfX1ywJSNhPvsXUlOmQgCrshlN3pXYBPkuuplDofqvLZeXBLStIOzhEGYGFxKJU1IWM
 mfYpRSug1uc7UUxrQXeEhL/uBcSeTXCQl/MSsPkHpk2as1b8Ug59xrdJtwUdLnbraf1ixAHNr
 7iqVrzrYwi4iXwHrMSLa1m+Fppejo4U5jcMUElNsMyRY+lFTdu95ahQca6D7ksT6knfG1SnT8
 UJT+cENqOcWs1xHDPH9ecsYS0FXQX+A7AogovJsuM0QlRBJ81AnoqXRe6aiJn27r8ghJoDASl
 w0TgEzSKqzpgVqn6qKMma15IGPjmbA5GfQucuFZ+cKMKCSqHWrlScHbyeozU1OF46WgJGduWg
 TrmCXt9z+Ejh2rh/6R4saqKq/6HEvPVoxmYPMamW4n+QsdVKaK1GT8dyjM8dSc7c3eOylZkxg
 +1erh9dTNXfwu8feCsLBFgnvw1/+lvcT4CIbWfXY+gsjKqcOD5+fbslYMY+HOsSU/QQxs3ktk
 VKjxWtxumb/xMrCaf7bmgrVaNCrvQJkvpPonPH1LNClYo=
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Fri, 24 Nov 2023, Kaartic Sivaraam wrote:

> On 17/11/23 18:55, Johannes Schindelin wrote:
> >
> > To that end, I deployed this branch to GitHub Pages so that anyone
> > interested (hopefully many!) can have a look at
> > https://git.github.io/git-scm.com/ and compare to the existing
> > https://git-scm.com/.
> >
>
> Thanks for hosting it to easily check things!
>
> I gave a quick try at the search and it seems to be behaving a bit stran=
gely.
>
> For instance, I searched for 'commit' and 'log'. I was hoping to see the
> corresponding reference page show up in the results but they don't seem =
to
> show up. At least they don't show up in the first few results. They show=
 up in
> the first few results in the existing site.
>
> Here are some screenshots:
>
> Existing site: https://ibb.co/pZHx9TM
>
> New site:
> https://ibb.co/dMpNth3
> https://ibb.co/h26J5Rx
>
> This not always the case, though. Some terms like 'checkout' seem to bri=
ng the
> relevant results properly in the top results.

This was quite the adventure to figure out. I worked with the maintainer
of Pagefind in the meantime, to add better controls regarding how much
impact various dimensions should have on the search results. And I am
happy to report that the fruit of these labors is now available to all, in
the form of Pagefind v1.1.1.

I have integrated this into https://github.com/git/git-scm.com/pull/1804.

Ciao,
Johannes
