Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E328E3A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="IO3D0VBE"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD1191
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699287686; x=1699892486; i=tboegi@web.de;
	bh=pRkTujypdonXL13n1UQiX+uKfBZigKR9wovqz1hqISU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=IO3D0VBEANd4NFL5jM6L+CzhlvW+Aa0tSn8IokanSkALsmuSxhjd5As8NnA6wkkp
	 KRpoUiVK6YUDMwUcdNM9SdCX589b5grAsC0YGxJ7jKO1Y1NneHOVIAvTR201gVZ1u
	 qYO78enFWywRDexA2nR7lDaiG4CvrpYq5Ow+qJRystc4iloM3e1Cz+6yD//TAgZoW
	 jq2b/LkzkjKR8bUiKNPbpxZeWvZ8Ow983D1EYyIGz/1H21/q/4V2LadvyTbsMK1K6
	 dz4llm7u8b4v4dv3XsJksgDYjaJOF8WE3aojDups8cP1Dt2dEAxARgt7trnIEnpn3
	 E5+B8kJIM2gbc/E+xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1qwYPA402P-00Vwuj; Mon, 06
 Nov 2023 17:21:26 +0100
Date: Mon, 6 Nov 2023 17:21:25 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Hans Meiser <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Message-ID: <20231106162125.GA31375@tb-raspi4>
References: <AS4P195MB15272FE283D0CF606A8B074EE2AAA@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AS4P195MB15272FE283D0CF606A8B074EE2AAA@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:xzmdEJy2VPPmn9ta6walroXK5H3AkXAI6FmSJ9qluyLUXD5fFe5
 I08br+JyKx91UMlOLNHz4XVqPoIIMX2JBMH6bM+N1st02h86lDD7f5dNdsldpFHrY5qEW/3
 TzgRiEn5+pHIIGaoI+OJ1jwh4bqwqrxY+qx6+GnPYa7JmETdonfmwH9vav3HupGTIdSajn/
 vxorpuczuh/73QsdUpj1A==
UI-OutboundReport: notjunk:1;M01:P0:e8ZXaUBUvdk=;o0pXG3Kf4n2fpNgMLVhIA1bk9NO
 XnOm+kJ8JFaEM1gq7m3Dmmgx3SIyR/g/lnpfJZDH82AkrKa2S/dEix2Cg75VBwmQLZ8hNTQUe
 BS9m/psZ4crBPGlnNEIuINYKWBXzpe+LRJeAMmi+jepjK8f1Nnkebn9WKw9JZbirCfCUKuEzO
 J9tRx9tH1vb9+IjzD6XYVbXWbiOld9D3JkDLyhjB0xAUc7MvSKl4AkhFaOBOEMoOAliAE/23N
 u3/x7diLGWz6b48i74SAMzjSgjvp8hzscTCGIGkVRZhABEML4Kyw8lWJMZXopHBdf985OSM3w
 JUP7tYh7Cf1qKsXmBV8sZH9XeSH0fjNLon6ur0xC+u8aDDe68dCFx2WjDy2XRx4qfcJOfbfKO
 G2ad7JGmqe7hiO1jaOcY8ZdhZ2VJZPBPWxRvz61a+UKUO55+V1qOeAy11D/wrbk1zJbtiOPzx
 28T2oWom3bK92CqYDFHHKGQOcBMXVH2yh0iJntPKbKJHixc4dZM3C9WMm0yzPuYx6l/r3q2E8
 womq5oyhYnAloRmxPVLI8B2kKAsChddp7NWSZxUQIWLxzYu2JsuKpLZnkKyB7pODpAKB5UPtJ
 dUXFy7/a8QfEwzl4bbgMwlW/bfvPYB+LxDWZv1SUiVJtns8kaf/uVMYwPLyQJMDlI/OZSEUOq
 SuVlv6J2pcGz/KJvRNlLmI3jJy1DraToNQGSqQQBT33tgyCkXhCK32Y+bvhc8VglulGO7fQcD
 9qZmGqk9j5Kmmjvss9yFJ5DCUK+cQG0JZp+M4Dgfhy7HoRfqpRvQRjNfacKYRonNouJ/JDqSM
 fEo5eTYSOv0unV5nWRe363eW5gMMMIysfJPQoZU6ECH9w6zH71bIea9x4o4uPxtDCFjQdVUn1
 X1MOjVpGifcVwuJE2KAkgCDlP75svm6/DRvR0bGDIlFdszt0NtAPsxvDx3ujyxP7tqqh/5zZ+
 dGte5AS7Hmw13M3OSNS02gCChh0=

On Mon, Nov 06, 2023 at 03:11:54PM +0000, Hans Meiser wrote:
> https://git-scm.com/docs/gitattributes#_eol
>
> claims that:
>
> ---
> Set to string value "crlf"
>
>     This setting converts the file=E2=80=99s line endings in the working=
 directory to CRLF when the file is checked out.
> Set to string value "lf"
>
>     This setting uses the same line endings in the working directory as =
in the index when the file is checked out.
> ---
>
> I don't think this explanation is sufficient for files stored on Windows=
 machines.
> A file might be stored with CRLF in the index.
> What happens then?

  >This setting uses the same line endings in the working directory
  >as in the index when the file is checked out.
  If you have a file commited with CRLF into the index, it will have CRLF =
in the working tree.
  If the file had been commited with LF into the index, it will have LF in=
 the working tree.
  That is what the documentation tries to say, I think.

However, the above discussion is only valid, when the "text" attribute is =
defined.
Otherwise the eol attribute has no effect.
So you need something like
* text=3Dauto
and/or
*.txt text
in your .gitattributes file


> And what happens when a file is added to the index with `core.autocrlf=
=3Dinput` on Windows machines?
Do you have a .gitattributes file ? Or not ?
Is the file a new one, or does it exist ?

In any way,
git ls-files --eol
may help to find out, what is in the index and what is in the workingtree.
