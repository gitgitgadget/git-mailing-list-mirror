Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348C398FA5
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791678; cv=none; b=rq070DYubKxYIzh8d3DXLlIqu+IeDDp/6UugVBup75WsBlKRzBf4uL50f2edlmPxCUEFhAIfIEjvgIgqL/SMWPUgqejOkMIfPDtyqsk43LrbMGOtS4artD7rpquqCUfbxytMssSRz1XGBKbMLwRxHOKk6JA5XYcbd7R0i9wGzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791678; c=relaxed/simple;
	bh=KjUYqMzmng5Fs73Sx/vjM4zYT3FtBsr9pjIcv9GGrsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1VBEJ9aC4TtmQOdr/ZKFwgw4jmx2Xz4+SEq1s5nF+8UkOJuBhJgU+NbHpueVJHf5vc9WeAuBXSfW7h6BRoJQGtJrKrejHW4alajxsN/iFtrljr9rYCsWyRoBQX5dPPPfQdRY3GY39nh0ibt/Dp33Ih06g6fTD1Cd1e8YLj+yHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=ZGrGPygZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="ZGrGPygZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764791665; x=1765396465; i=tboegi@web.de;
	bh=eLNaF54dqB1dCwFXrf9G/DVrYrrM6qH05map2NINCys=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZGrGPygZxNEmjqW3f53SBYp7c4LT4WWIHglsEsc3Hsf8IrIqs15XXIqiOuLdU8yo
	 cZsdWgHZMCexGoGUcMaF9OOauhCaBlaiihOcj7uxqF4nmQxKU5V2D6TdFqYsDW7a8
	 nJLjYwM3xiPXbJhrip2fXKBmmTZRDbidm7cDQwxacHOzI4kLfb6A8Q+/04/QKz5KR
	 w0paRNRTUQ7J8xMV+/WIsvsXV1rXPmlZCEn8oOYE2xcM0RHhdi/JNK8ilncBgaX1G
	 hiFvrh6lpic1BP3Bzd0wD5elWVcwW7L0NmyU8GWf0ZKiXrZjSSrum1ZnShWTGq9v5
	 18cC5Vg2cLsg0HkDMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1voPZ83lXK-00ljc7; Wed, 03
 Dec 2025 20:54:24 +0100
Date: Wed, 3 Dec 2025 20:54:24 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: diff: should warn about EOL when --no-index ?
Message-ID: <20251203195424.GB13919@tb-raspi4>
References: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:oOh83kufHM+0oYYUYeDwehQI00spqgm0NlcJBuQB7IlmtX/+tEJ
 QKKigVGNWUmW7kB9OjHFAozObxx6JE/HAcSAujt8O8SvufJMqva4cRRNo30b7lQYS6pUt93
 kQuKbZOBmDhO2uGN4ZmSqelpTNWe3vKHg2/X3mCTSkhGIUUtIgIF4008X7zyvZs3JqUOhcP
 BfSXhPJIRWkc2vSMWgclw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZLD8uxX3ENA=;h1ReTHbMdM/sbt52Lnxow8nqurI
 mjfey3k3Ma8Awwwv4WsOdzFIHBW2YcoP81L/uveBOcBD8KRjC7P7ROCKOiHtJ7tU+gVPJxXta
 54MshoZ5e0aM31jP9TiNfTKV67mk7H80kNnRNkU1vxtYxJCdPPyAcSwMlYB/f+JYxlezanyg8
 6yh6rEfUDkPgwBtN4ZPpkBc+ifekuwexaHcHWD7nPDSGDAa24jFpRbPPClLzFWUnhEKmIij2w
 0RCmjdTB9NUconPkcn87mRY/apisZvjbXJc+BqvT5U/f7z9KKqWGL4eCQHucPsXomvKE2i6H8
 wSLbckdslYonRkRSjG7T93IOhduAv10dzqy4A3QdObXtAyVtJhySbvAI9pQZeEK2SbKcAJmkO
 vMlpPX2etKwL0XsrKhOJW9xx/QQfhdq/G6YCrJ6u8/c+lAwiD9EiqDlVfEKjLTSw9J+ftEp+N
 nw9+dDdeS3i625Uw3kQMA4UTApldoX2FE9BgX2L7FbTGFmPA/NNIola1UcVoGHCS3ohs6aXHA
 OC+GKww15pWB1iA3aLejC2NX/qwf2WlNwGhHahMrGaKj3bCSov1md/ii5/zCsrsc8bdlxm7xz
 n49BAbl0PGmBWPNH6ikbJWEJy7AdHQT/M0z6LVa/oy0sUxYvhmSX8WEb1D0RBXptNVpRlPrsO
 sKNFQKFhDizZEheu+olYt9FhllKrKicQcvNHnhK8BbBFQaa/KWhbGgd0i67H74nnlfTS7cI4Q
 Kvr+3ZRFSiaDDt9yiU8gfCn9VR736o308bres1wNDbzVLqEngf+hIg0UH2L6pPyiUlzRt6VhS
 toSI0NmuHPBql9gb4tIzaVdYyJ1Z2SkvyYgKJy6yY86tVkf09/jQcrKmeGk8D6Iac3F6kaRPm
 ++GKfC95O4SSIEJPlRLugc/yreDQ7slSEEeSALMqmx+6ApSIV00Vxl4UoZTHfPcPcl8Q0VZi5
 y1nvBBCZELAT2BuZ4blXo9ahpKLT9nt+tNf6PiZG2fsBn84Z/pxjuXfUFpJnrLEn5eFmk195W
 th8EDlWgg0mVaWbb4x1ewOoJEctN0wqMDgus3XjOPKQHhfyyFQDVMW+v8GP75Z0Ogahw38h9U
 EOZ+WYfrqlDkPDLRqB+7IwFEF79ei2T+Hcvmt975/3TWGNym31PmdSNcqMAiNtCgb6LVeawhV
 eTpygLE23BjcIaan6rm3w6upZltlMehp96E8g1JlN99Rqhax1PtQSbH9ZgWfnrzVvemP1Ukbu
 LAOXIoreuK3EBsaxu7nzoPropWIucFmIANNBNMCZfUzxXyZZAx0CeAZmAV/LKLimGoYhiWUB5
 BQVHsHf/Rpw/hAM1js0r5Tn3zRCYAWeGiO4op+Uy4/K4rcmhiK2U7rQiXRbLn8FStcNwjVpZm
 IkZpxDgW0K6U4gCAiGFQyrnovQIB11c8TExexNw7R16Je/B2dzgWZ+jXylkOLYYJFEgYlDakH
 v5WRZSvRquJl91kzhUsCnI6IdGKcUh2xqcFuoo+2VYfZ17zXDqujQzLhdd4OWenfNmXW8+wH0
 DSNXmCZurq9s6pVauAnEkeNRUwXmLoP2YgZg1SQu4ujJ284BHmwCMsgI9XhbCRwQAIsT5iT23
 ZyKnJfjYY6wnHfcuB01S0tnrQny86QBpqX6kOy/aOwVpFX81dDaXDjFibVk8xfpcDLgMFgBzd
 aK5FhRAYuJFhdzLbGG8865wW3BH4zb21Od4aHkLRVIRFkOM+pHNSwiek5YxJU07kXk2LlOgVh
 EmG3hG0h5AIQ1N+lxxN3rhCzQwcKHygClQjEFTY+vnR2QNSG2jR7t8HuHcWQTy1QrEA8rWtGF
 fQxbny8OQIId2gWCParrWnRkOSx4LUgw6wSUE9W9th8PGVXz/eOGN40EmJhJVW9KcXHV+fQpp
 AzmmF7JWzbxYSFzWdO/u3br1YAxuBsUSsWX/KykLHAomDTj2S/ohTJJPZ8tdyy24PAxMoaIB7
 pTXdpBzoGu5U+xVEkB1iLMVW48cT7mEXP2vCs6hynchIjYk+SNZL/dqSRz1IC8E4p839m7Hms
 43jAsbZmnWAqen19LgFnKq/TwvG46BYbt73NNHpjNC7OtcMEDlXfAcQGh6AfKkOELkSgRV2o3
 froKyX2zlUaTzXMbYAGkDLkcMn2NRBmK2V4yjEfdU8v+SiMVzEn8BIGNEWL6TF+r/mouHhJNl
 gBrpsXdBWF37JQJYctthbPG4jqsnS4cOfLkIyQs+SV7erPXY5Jl7d5ZHIQOCtbf28w0EF5mVP
 SuAjgluxupfliO08polxypF/oO52SQDqqz8nuGZ+qX7v9diacuSyyfXNq6ZfD+CfCuOUyAzN8
 H5TUptAwguHIy0QjQkatquSWYPuM8GiOf25v6DCDO64TrdEyuLvA9+QDr1jC31fHLU5VXCPcD
 J0DTrRfpVKADE4CiToy/mxPt+kzfgXppT7OWLjb/HZrGIOUcfCM1V6XIXD8XIjPke5TkZLkYA
 pTQkjox2Ynu9O7ntcSEedMVXZI1d37zzexFZkRSebszT6hjCEkdleuNWpy+d4sm2AeTcNP8+y
 Cq8ek62zgCTsTEVuo/H1LE9S2wrxXQ0oWJcc5iPkuGAOpju/YnbkwcWMltmhxT2cQ/7lXnQyN
 3b24bquYkQE7GCZZkr7vU1kRQi+SIFn+46VVJckCQ35nVJdfFnSWJSxF+bqKm7B6b04ZzjK4G
 gJri2w/ibRH8Y/juFrbf3jMsBHbXQFBBBpreibX6YfJIl0szjHQXIaZ9npNKMdPkbViK6b9LK
 qjSppPAMZ4VJ1obtgAQ+ebXJArACTsAooA5+ATZ4Cn4O4BwRbWtQIDfyRm2ibfVaMKGXtDuAx
 St/7jxMp8mdO/QBSteicHVXtdqcFy0pScbS8cbZEyZSFg0o9UdXDfAUGt7IEm03vmVTlbwoVQ
 p0Biq33dY8Uqu52U+P9KmD9YxhZLAsAa3+phlSCy7nUHfugLtf8Qos22pnPlY4p6yNp0i2miR
 rmhlFonYMATRVCeXmWcb+omaq9hLGoOrh0fu1xIXVRRSZevBRWclDJ8OxYsApJZwrIxT0mVEF
 WWZZTYdpY/gBIdu62MxDZcr0UIBc6M1KcBaI71cc6aboHq6uYqXfLrKaUjKWfJ/HwqP4uptJR
 u4ljUwwUhX+ExO0jh7L+A2Ou7QCuraELsa5glvhOtpWH/iIFeADPtDH4+tgPBehZ4zVSPZ3Bk
 wPnxHywAJceipcJ1/IRFtqT3UVYMyPd1be89cLu/N2dAeP9qf9HL1rNTAdlrHfOBd/DvCfcKW
 HijAYEnu9NF7RWVrib0nspbnyr0Kmkv518Skevr5Oz6z+1aMPvH6gZkCs9Cxan3t6GbqSpIM+
 M9muMeUVBTmKq2XRHJZtzB4yX0mZnwQVd/Ht4jEmlTqONZSUv3ugxXIAcARfu9fwrPaz7XId1
 jx+reWeVs7Yrjx8Jpi9a5i696SAURuCyJILoDjKVYAxpw+wgS+cN8ZaW+oFJqH/sM2wmHh4oQ
 3yw6UfTD5o6M/ww12LFT/aQlM4JTryD7MMBr+XFbu6XIPhurR8FW/7qWEF5ywVKczYIrdT7UL
 x3TH+R253j+x/YWxBJbKy6PJ3pB7K1lTx1zqsleZcIdz+7Or2b9ZhHE0LUFkOTrtZACdYRjeV
 LqgC/ytWdRfvh+/dQyaqQZP8R0jEPPtiw6r2wv2w1/YjNI+7h4RJWrJcRJlVFJjJcULdSLC/i
 NNaUD/uLRFt+ZPvkdPYpl6rqFhGL7Ky/WNLsIxAS4t82pBLH+a0bcfNlgF9s4cOfTawB78xQh
 Vw0vSwI2NOt4QbfxAuaxRPJjII7cjQm3mw91xIY/p9v8HEfHAoc2Y7295IE1curWw1pU2pEFe
 e3Bj31IaN9wcAIgg+NnRHblaMAKlP/fBlikcotOhbILJqHEA6YNiuRNYepmAwHPgIm25mwOJw
 89F3bc9qgNKic3lFVtgeNOUxnH2XHhHbAm05YJiGf59I6ZpJCJqQGkuFWx0tq6KcSvmj09CBV
 4ajprnnXqRtU7gtnOF78wV7OTR26QVwukafARWvQ+Vz/OOzk1NSEr120Js+/dHah+a69R5mGD
 tTNaLeSJaDyCxsew2wk7Dry++Ep2Av5145RncyI68D4KSm7TlLuSzwWpF5g+tO/yfhPqX3iEs
 EJSPYBzwR84DVW+w6mn/CABU9n1qePxWlml5HuxI6GMB+kEYWv4WQ5EKwxNrgeGUEcs8i5V2V
 onExOogw7MT3WA/c/cTSAoJqdMjEwlCRndoOeDVnrlgpS3Lh9HVI10+njbzaV/mwUQ2H8FRwU
 xASI+tdRp6M9nv+RGO3NiEAm0ZxuVCKpxTEkLCeLDMyWkGcKdRxV62sYogMxAVyXg75OylEv9
 fGVqeMIaWCxltz+SzTwxPz49YHWMoO1/ee64IUFWlLGtH8PP3hKbhyWdA89ky6Q/1qoVCfHu+
 +zKVCvTbKOjjjPhr6E3N2tiWnpvt5CUn7ud7Pcs9pDC5yI+U33Xv3Mb/yeonx/cojsyleVRXS
 riHrb6SywBoWdkoDu5Tg3skDb5VDcBd2ce5kexa7iv8b6JVfZOmmU9eNBwksJMcpZduYaWKva
 jk1rtMstFaogSMBF1oAuot06kIIaCYcl7ARlCPs+PqHz47LZGLF7EahB/Y4YrMAVX7hP+ZEtp
 mwXeG27gs1XWjyZcQyDJ7QhHuzJM6/wSYKV3dI2dpbZciaI2RrrY+g6DbHMOGiBYLPOVND7DH
 SRzI9MNfDyIKgAykRdybvwv5ONk8HzkEiOw2D6hkYGsBfFjmtY00kQjC/b47wz1jrOd8IxZz2
 0/+0DhKQZRoijVYBd/xdglVH84wDD3tGDEVAIL51enSz2Hc5kJtupmm12jPbNGUk5JL2ww4Kz
 DmLyZrMCYBO5A4YYSsX3dWzvzWZMGvvFzM0zBfwPEpchaDuVU2Jcntftme4dB/8M9tN4ZkbNB
 UARXoZ/vSgZoZW+gcmuUOlaFunKvutpMjLJqJIT58b9TWapTleEMluHdSGW9jHTUQRXuPycYI
 oWP0VT7fXB7eMVC68tYbebijWbGdvIWFQN3iPzacQ0IHh4LNghumDuc7c4KfDIzDPMbpjtT/2
 Cq9iukkr5X9f3F8VYxDkUrHTCodxbgTdtWo1u4Pc8t6kxBh4OFGv/bDs1UsL+0mEwaRVnOco3
 JVw2qXd+hbpvdnNibks+Vb59bbMXY9lEo072QH

On Wed, Dec 03, 2025 at 05:26:49PM +0100, Kristoffer Haugsbakk wrote:
> When using `git diff --no-index` on some CRLF files with my setup=20
> and config:
>=20
>     warning: in the working copy of '<something>.csv', CRLF will be repl=
aced by LF the next time Git touches it
>=20
> To my mind, I=E2=80=99m saying that I don=E2=80=99t care about the worki=
ng tree per
> se. In particular, in this case, I=E2=80=99m just using git-diff(1) as a
> difference utility on some non-Git files (this happens to be outside a
> Git repository).
>=20
> --=20
> Kristoffer Haugsbakk
>=20

Not being an expert in `git diff --no-index`:
It seems as if Git reads the .gitconfig and possible .gitattributes here ?
Or what exact setup do yoe use, what is the value for
core.autocrlf
and do you have a .gitattributes file ?
Thinking about it: The warning may be not needed.
On the other hand: It seems as if something in your repo is
not as it should be ?
Because the repo should be normalized ?
And if it was, there would be no warning ?

What does
git ls-files --eol
give you ?

More information is welcome

