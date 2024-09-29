Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043222611
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727633699; cv=none; b=SCo5Uw3Ati1/8IcIay8s8gEh12auI/4Lt95Y6/bB9geSLcuHAT0cx0kZarLultmETXs6bXzNziRisg5K52r1H6QallYAW9JVXTYTVurKztuM7k8mriBwDJ64SC0SvSzhAGEGNtmQhvAkUCio5JdpiENRvC9qkve0WxkvwTLXsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727633699; c=relaxed/simple;
	bh=9yVaiPfUAaPmFA0TP+lyCaIekshLTEX+WofQbxzzz3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i2xnCFy0t8izZtw5T1NcElTQx/sQEE9bR0OqJWp4TNav0w6lOTLVTcCqB/mQw14zGi5fcUK0dmVOjn1SFPFSZBb8tAojHiKIhz/GF6vGyiuMlW9x9d53q6QPkcwpXbkNQWKhuy5v1w44FKwUB4N3cO5qK+K+KMkcPjS3xkwnfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NiWUNHN+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NiWUNHN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727633692; x=1728238492;
	i=johannes.schindelin@gmx.de;
	bh=bsHyV2K09suVj8qTZU+8uKOUpa+uWww+yqBKECQ5Mjc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NiWUNHN+/0vwhRRvfbr8S4h8k+CC9kILjihRPMqxxbdVJ2huzgABGtUtk0xztcot
	 kUBgGsCRNw9uX21vB4mn5o1/Yf5gXoCa87Tv6sYm7Hk/UVgTckhKvRwz2oNH1i6uV
	 EOu7qUkgr1ERQ1VH/fQ60TfrJiW6LRWbHtbF0Fz8s1XglBZ+p5t7vm8sTVSztPBTn
	 DN7goOWFyx/09xiB9nn9Af/DC0zGev45EPdg/Aq8aMO5QDQsptVziarbWeYnA7RCR
	 14s1peENwj6YxEzAdSnUTbfaY4K686qr4DxA1xfsN8ez5lxk+fQP7IwbzbA8zrwm7
	 ve8Q6WW8z7H81hDu9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1swd8U0qLW-004kKO; Sun, 29
 Sep 2024 20:14:52 +0200
Date: Sun, 29 Sep 2024 20:14:51 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Mr. Manuel" <mr-manuel@outlook.it>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Push to GitHub HTTP repo fails (>v2.45.2)
In-Reply-To: <PA4PR02MB7040A36E17B197AB8DD7BBFC8C612@PA4PR02MB7040.eurprd02.prod.outlook.com>
Message-ID: <a6dd718c-807a-c19b-b915-e6cc455256af@gmx.de>
References: <PA4PR02MB7040A36E17B197AB8DD7BBFC8C612@PA4PR02MB7040.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1824243515-1727633692=:116"
X-Provags-ID: V03:K1:BEy7yKIyir4BQpNPDfLLCGrRAWhciNGv2SjfzVBQ1ewQGOsaEzI
 x4r2/BgnSv3gkEOwWvc/X6VfcFCG+q3EB3Tp5MewhLgKSsdFpR10vlbvYaSRQQhUoF4jcca
 I5otERh1IQ1/V+vcMwGqWIN+aiJPa+sEFySfnYZtVnwCAn4/yazMPZaxyTxc7K/Sj21iM0f
 VUYaq2eX5bN+o6IxyBzSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6t/Ka5IOLrA=;4UzhQYfEQDRcinO5FVTJRVL8zmq
 wFbYivZN+DfZV7JLbg8/qNdgkFMt4nf6wo7QbsRksPhRFXjUBePXDMw74Slh15OVZGGXhpXVM
 mBlZJKqWryo1boYZbCCfJInR+ACCPu4iV0M1BnWGKzWqLtkbES8/Wee0J8dXjvUeCaSb7Ks2+
 7cXsC5I/O+XXBXlgKnhWZEY3mc4zqp97kCftATb1BXHpy/SUOKhtaaTJF2s4SB2qh3t/Uqqh/
 uhzCOCxSO9KwAcyyK0mOtWFQh7oKR4YggTc9lYgY6Il0+aLQyUtppgnr61B+iJGAyjL3AWASN
 4ivByZ8nKRhncxJm1m0+djKYfNbi8iGxIiJgZYslh3SJMkl9ncyVkHe4kIfa7a78/sdLM8wOg
 ei7EaxIZAHsv19EzR6yRtFYv5DzkIIyc303KRP0bupmyb3xF9iXhNJSdacOGBmu+/I1aWWBNa
 maaxcrY/eTw1LCkyJOeS8VgHj+30QQrZMkpvjCq/CltGuUE0cJ8gfaU0D9ozo9EpPxmkAs9jj
 QCZCFFOx7F7sKSuze9SieIZQpAP2pk03PHmd+ri7/IJ9hcnxGLKqNPnTGWjPgJMMqEtNQmXLg
 YlNeFeft+m7s5I57LEL0xed0E7GORXNR89YNCwZt9vnlMeicVumjH887HuiraU66TlZBUOV2w
 9JMN4HaLBggoOGFBD/N37hxtKWO3fG50KvK7KizDrNFcwmAkAFnWRelR0QHuI8Nj5EWuTX5uu
 LSquq+TkX+ym2FSnwL8uGPCyg5nB6CeZmGFM+IhL/AeN1Hvheb6IeeLzoFkzL+zkOpN5ss36K
 81VAgrSlrn+7DPNXeUmcn6LA==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1824243515-1727633692=:116
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mr. Manuel,

On Tue, 17 Sep 2024, Mr. Manuel wrote:

> after Git version 2.45.2 I=E2=80=99m no more able to push to a GitHub HT=
TP
> repository. Tried 2.45.3, 2.46.0 and 2.46.1. I can reproduce this on
> many different systems. Found also a entry on reddit:
> https://www.reddit.com/r/github/comments/1f3xmnl/error_remotecurl_error_=
reading_command_stream/
>
> Here some more details:
>
> PS C:\Users\User\my-project_1> git --version
> git version 2.46.0.windows.1
> PS C:\Users\User\my-project_1> git push --force
> error: remote-curl: error reading command stream from git
> error: failed to push some refs to 'https://github.com/my-github-user/my=
-project_1.git'

This looks like it might be due to an update in the libcurl library;
Git for Windows v2.46.0 came with libcurl v8.9.0 while Git for Windows
v2.45.2 came with libcurl v8.8.0.

Could you first go ahead and try with
https://github.com/git-for-windows/git/releases/tag/v2.47.0-rc0.windows.1?
Otherwise I would need to direct you to bisect through the more
fine-grained snapshot versions at
https://wingit.blob.core.windows.net/files/index.html (where v2.45.2 was
added on Mon, 3 Jun 2024 09:24:47 +0200 and v2.46.0 on Mon, 29 Jul 2024
10:56:11 -0700).

Also, since there haven't been any reports about this issue at
https://github.com/git-for-windows/git/issues, I suspect that you have
somewhat of a special setup, maybe a proxy or something similar?

Ciao,
Johannes

> PS C:\Users\User\my-project_1> git --version
> git version 2.45.2.windows.1
> PS C:\Users\User\my-project_1> git push --force
> Enumerating objects: 27, done.
> Counting objects: 100% (27/27), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (16/16), done.
> Writing objects: 100% (18/18), 14.52 MiB | 2.08 MiB/s, done.
> Total 18 (delta 7), reused 1 (delta 0), pack-reused 0 (from 0)
> remote: Resolving deltas: 100% (7/7), completed with 5 local objects.
> To https://github.com/my-github-user/my-project_1.git
> =C2=A0 =C2=A0c7a0249..379246f =C2=A0main -> main
>
>

--8323328-1824243515-1727633692=:116--
