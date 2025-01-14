Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A019146E;
	Tue, 14 Jan 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880263; cv=none; b=tY/M+73gKuT+aOI1l1lDQf+stkoV+9x8hlpOBTmG/Qi+YEGtls0/grTFnbCCAskIweJNgfay7xPq4qAa/mx/RiNN/UbHCnbw8s3mxdlRQDKBozzHzYyUO7TcLXFtX4vGHmTsIURHQF5S4NoYoHMMq4UARhkKPAf3PyrgcnDbqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880263; c=relaxed/simple;
	bh=uXxh5d+s6rktIEEN+PVD4/+HkoIS4mmanUHKhZ22qD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g5pUf7u2gyQUywxCZwJyrZKWOWKXSHea03ouGFy5VQjfsDZ2Dl8/1vSue9z0KvoeNEpnjKGCqwO/2ycALYcVbAnqKAfdbtsprD50AXqgkQCfkP/rSnETX5BaR5VJByQeETMDuVTbwz2M+466AH443St0sfU3KFEHwyLq7OhLmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oz0PLTpG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oz0PLTpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736880255; x=1737485055;
	i=johannes.schindelin@gmx.de;
	bh=fvKEHN8Mo4eD6e1fXUQb6xM4L9je2jvbdufntS3nk5M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oz0PLTpG2utaoDDdBMRap4x2gxJpTwcOXHfZ74siJ1ZWTkpZy2ruye2Cc2ssw+6q
	 ygZYn/u2xQbQTkRr6IBDnkGXvYZH+GeG6BrWvYrzVjf9VAF+E/ucx77GuAlbvDNMd
	 TH7MjRq0wAXgKak2cKfh+jpw1aNFq+Ai1526szwq81u6MhlsPOhsx4XweP6JdWcfW
	 VIJQ43yTLQvmMsKU6rLZNuTpI0YROZaqKU2AXVB5l5VvYRoHHlQ6gsjnrusXngJaf
	 TV2L4qmjSMIM7qcLSCaSrHBN85PVSK3FvQeWcVJFB4n38KqF2eqRoNRydfdMH/Y2Y
	 6lMmzQ6I97cAqDKAvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1u39RB1ab0-00XtwO; Tue, 14
 Jan 2025 19:44:15 +0100
Date: Tue, 14 Jan 2025 19:44:14 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, 
    git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.48.1 and friends
In-Reply-To: <xmqq5xmh46oc.fsf@gitster.g>
Message-ID: <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>
References: <xmqq5xmh46oc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sooMVFdOaGDkXeRQ28ZRYvW7yKX+uQb5G2UqNRP/spGsW9QY5FB
 tAqn5t6daCSgwodlerBpwMMHohDO3pNGnpZyZJbRfG6ECEOF9OnYTn904WU22VsZ0H+/ify
 u/ikJA+rmeEBCD0BrgvrwG8CYj/ttUNtJqRWEkKhEsW3TPr5YGlu2/oOz1TyOdaOR98gHmj
 XaF2uITnXohW0A5CFz4pQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AH1im/EimC8=;qsn/XUNOHu6gu6y8ftQM+FfsttD
 MACRpLaOIgfnxgD7LcKJZ7PdiLFg4mOsZSSZAOXUTA7ZJuRZ0wNKaE7GMog/4BhEMksLwXH/m
 jn4UBH9tu7CcqUE50rvI9BcpxhMg2F1+XyWHFvdr4tMxKqwxG3EWtDi5dKXLR+9klvQxuN6q7
 kxCbWpJ67G8yALrnYcB42cDU+Vz9M40Auv72MFG84YGCdaU5DynvlElF1EAcy5OWpLnjCIHUT
 QfYMyCGvrvlfERuTnQhRu1KtBZtQ/HcTucPom00GlizdhSXiJvJs4oGXy97t3rabwBNiKPyWz
 jirX5I9ohccGBbf1Y0SpdGdNOqtQm0ZsD5p5O/CwDJnHRDq5UCTD/gGizR35y1X+qXmtNv393
 7DtXz48hLBuG1juMs8kV9BgHtIACeE5pzmJlshsyUGme3jPaEtAGWv5WK5JLNEaQthIl0jEE5
 dKdCYyRNOfrkjORGE4TsFYQyGMuIs9fyAbcDenX6wOBW94K+P3yn2zR9FBhYlORZk4boGSwvc
 UYiZx4jJD00G/ClnzK/0roFAqydcHEs0wRm0g8iSlgVW/UwMQFjO1LBNst4EklCCbG8JBfiwT
 ZtQsjNNhgV/W7xguY+t/BVuwWMqPAymEOi7vw0Ygth5Rcc1zu6ubecvFvZRYmt1Qfq/dMoFmf
 QHH6sH/FJe8ydSmtLfn6L+tjhIl6SocuAT3BU7Th9HgDKrSHHsQ5iAFmha5V7CRxsgb9m94zw
 EDlVLmg6t5Xg+2dlOuiqy/Gs+lP31Doo29K6wdYpVphWez2aZgSll+vy4hf+4JmXORBsUnfO9
 Q3X5JOAFM9lLApboV6ZfXZ9NB810kKVfm4YWCqquHBzqtx0WCbYOKZJQi03/4+2sXtT16dzpU
 sh5PwnIo1QpNc5CdUPrn7Xn5j8X0kw0i7zfVkKzJnPXfZCoyGulW9ySn23/mpwFDsjR9sTVjZ
 k3cngeDeZ2AgJzl9iX5k+EqSdoeyrNYy5rvIQ9ZHE6192ZU+68oKcHcKAYZLldE5Xj8kY7idn
 cwP47p2PQD+G58D06bWhWlXnlEzYIuGJtaCZqq5qel+UMNQkzw44Uiik9bnNgkONzsh5qXCs/
 udd5n/wZzhmIQI7So7tjdQ29BtKIWs+842iBf7GRWdqJO6BRQjKH3j936L718tCZO16rQk3pv
 BwAop/etYFlH8jpo6KZMrzhVq2hwfe1HeUyNDneQDp+3+Twi4ea3U8+Ezaez0eDEr2rvQ6QQR
 Z4nqBxeZ7GOhdytqqNn3KccedTlnjWqc+Q==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

my apologies, I only realized _now_ that I had forgotten to update
`GIT-VERSION-GEN` in v2.47.2, it still has `DEF_VER=3Dv2.47.1` (but all
other mentioned tagged versions have a correct `GIT-VERSION-GEN`). I am
very sorry about that.

Ciao,
Johannes

On Tue, 14 Jan 2025, Junio C Hamano wrote:

> A maintenance release Git v2.48.1, together with releases for older
> maintenance tracks (v2.40.4, v2.41.3, v2.42.4, v2.43.6, v2.44.3,
> v2.45.3, v2.46.3, and v2.47.2) are now available at the usual
> places.  These are to address a couple of security issues.
>
> The tarballs are found at:
>
>     https://www.kernel.org/pub/software/scm/git/
>
> The following public repositories all have a copy of the 'v2.48.1'
> tag, as well as the tags for older maintenance tracks listed above.
>
>   url =3D https://git.kernel.org/pub/scm/git/git
>   url =3D https://kernel.googlesource.com/pub/scm/git/git
>   url =3D git://repo.or.cz/alt-git.git
>   url =3D https://github.com/gitster/git
>
>
> These releases make Git refuse to accept URLs that contain control
> sequences to address CVE-2024-50349 and CVE-2024-52006.
>
>  - CVE-2024-50349:
>
>    Printing unsanitized URLs when asking for credentials made the
>    user susceptible to crafted URLs (e.g. in recursive clones) that
>    mislead the user into typing in passwords for trusted sites that
>    would then be sent to untrusted sites instead.
>
>  - CVE-2024-52006
>
>    Git may pass on Carriage Returns via the credential protocol to
>    credential helpers which use line-reading functions that
>    interpret said Carriage Returns as line endings, even though Git
>    did not intend that.
>
>
> Huge credit goes to Dscho who led and coordinated the fixes for this
> set of releases.
>
>
