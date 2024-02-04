Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9208BFA
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096902; cv=none; b=BaIEylQo3LBMEozswpqwdAwt1x5Vk+NNXQuqHcSjrLHMBHbDwJ8qIN+CYjXyg1lfJpmlP2WMUOuHdGd4CbveiMQXCW8T+6g7Ue293h9/6E3BbcA9diqoOu6QIcbIwOXpdjuVwFOnDy7CZaC1Abky4LatOnfRBhLWHZ8tS8Pn0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096902; c=relaxed/simple;
	bh=tz9SJP7rk8kCtJdkjTCsMOjc9mm7fBvHV4frXjed6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH4WtmtBmQCuG9ek+Tk7gLVojCBGrH/OzxhEtqcxeNMhbhTiz6Y6DD5FyfQtm7ongw0L4HG9MpRYjS5PG7nX5uqU4ecUXWk9KiZBAovPhxEmKz74z2iwlRjb25chBbJ0aKxPK3+fV4+yl6BrDsRwFa/36wg3vbtoc05rrHCmwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=E3Xka9rS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="E3Xka9rS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707096897; x=1707701697; i=oswald.buddenhagen@gmx.de;
	bh=tz9SJP7rk8kCtJdkjTCsMOjc9mm7fBvHV4frXjed6Lc=;
	h=X-UI-Sender-Class:Resent-From:Resent-Date:Resent-To:Date:From:To:
	 Cc:Subject:References:In-Reply-To;
	b=E3Xka9rS4iT9pUgNFK/4lsjBjYitfokYT2HN/GJ+U8ITnaZ2yGjHfySWW0df1Lwc
	 Uj5V8mnLHX/+iOyepjIWbCdwFP0a6mNxDasuW3JsLio3nsgm0uUAB6ZGyvn/xB/Xi
	 4X9MRuyKaHrL8Z4Yrz7Jpy/k/w5ufsSz3MK2LOjpVWOBQaDmmHn1lkdr9+qvDmLkX
	 PMOQwUxR2t2AP1faCfQWZbrmrRDP1EzGkaJY8PZuMNlr5Q/h03aSZPqZHhaBbfWr2
	 DDZRF0Bvr89dqIJo+SyWZoElKXpRKz/GKLsp35j1akNpt/yCdPMVwZdsw5pv/Hkk+
	 yybLg3nwMxN8Oyjzng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.159]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1rTF6w2lBT-00Vhcs for
 <git@vger.kernel.org>; Mon, 05 Feb 2024 02:34:57 +0100
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rWnsv-G5z-00
	for <git@vger.kernel.org>; Mon, 05 Feb 2024 02:34:57 +0100
Resent-From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Resent-Date: Mon, 5 Feb 2024 02:34:57 +0100
Resent-Message-ID: <ZcA7QRboDwQ55zK6@ugly>
Resent-To: git@vger.kernel.org
Date: Sun, 4 Feb 2024 14:47:22 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Martin Guy <martinwguy@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: single-char options
Message-ID: <Zb+Vake8k3Lpx3Ut@ugly>
References: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
X-Provags-ID: V03:K1:vx2iGyKtfi+3j0Jxi5aHjEIuUHSl9jTGOZhl5twJciZUalWyrTs
 NDMyu2MncC8acGg6pgt8VgF8zw8DbOghVz2FXsvHQTxfkCY/8q3NKWqNU+xjYqcQRw1PVSV
 4DunladRGe3tVu49AJOkXpWAGAdOn1OaB2+jSKOciBxkLfNcW57bX+k/VLEmXnsTC5XE0ju
 Y0HEMzfygBXTulgZi8PJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eJXkdCx5MXg=;VyyvUbTq2b8VWFs/XVe7HawNslS
 KvWG2HKoVOYo87JuWoIT/E4Jt/58GsJ/GI7HP0YOAzTxtwvEemSVZVTNup8X7hso10bjLjfNV
 ZFSLXg5qCrLvU+FXkgG8oodzaAtZCXanT0054A4v96Y3f8lj1x/AHwrDZ68GB6yD1EYKvOrRX
 wdB2JY1c3NtlxLPZvbxqjZK2wwfCf1zQaRote9H877+dG/L/EIWGwVobcUJI2NIO5sujNNy0+
 hZAAQF3soq1K0eUdiUhTSlxvRl2FLsGsSqmpBeW4d0RLq1BtdBNcvbLFP9Y6FD/g6wZrUDGVO
 1yR+SMicTfMC0wuXbVxxB3a6p3iYuBbdpPZW+Xi/4n8Gfv+TaVkAtjlSR8Il5oXTElhRcyM91
 3RYWcL12y97y6ndctsouwcR4lVb9ZwRUXfjxgX0sFfLwY+Qx9p7qdw465md2inziradBx6CyP
 lpAkR4mSa8QbyFeBXwLenK2Px+34UKAgvGhVF0DL93KtTf8+yjlfHJisoLMy6rM+nhF8iNj/t
 dGjzYVgWAcwxC4g7Fdse7mGQLCpr4Rl/YCeeHo0u+wRMNfU8z58ypJoR0Zd7B8wy+jbrtB+ds
 mnq5AsSS6LmkX9iPefJJBiobZK/RjX/CTrmDzdnyg5WJqzYFaAH0Ym22C4lWzM5ESvF5u+FI0
 U/TdK42XRT2nIE019Gc6BOShqPISCGHPMCDCaqxFnwxIzJAZAcLprEOcVv2MY6VvOJPWYSbz9
 wD7eVB8REv0r22tKFFPGfOhBBcASSTmx6ClZqBjiKTzm5/Za/ZdirQuOQtevyVfv0ZECja7k+
 zRBsBJ5MlLZ+9iKFbG3DKxs0sl9fgfeWkSKWbDJdj9pkk=
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:45:55PM +0000, Martin Guy wrote:
>I'm sure this must have been thought of before and rejected, but us RSI
>sufferers would like to be able to say "git rebase -c" for "--continue"
>not only for speed and ease, but for all the other RSI sufferers out
>there.
>
you don't need to re-type the commands.
in bash (or any other readline-using shell) just type ctrl-r 'onti' (or
anything else sufficiently unique) and maybe ctrl-r a few times more.
it's very rare that i type repeat commands from scratch. in fact, to the
point that i often spend more time hopping through the history than it
would have taken to re-type the command, heh.

