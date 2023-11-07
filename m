Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C372E65B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="SK1WCBB4"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798069B
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699377135; x=1699981935; i=tboegi@web.de;
	bh=CETNY6MlLuUXqcOUujyB0c9OtbwFQzKv8rDCSOZcvqs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=SK1WCBB4pH0O954zgNasNWfSOG+GZoNa9xPwzacWbd+6kGZkpOvEHgpSpHPVkgC2
	 wS8g2i6UPvacNaTAhPaV1oSDrJ/muezZ+Y7d2DZxwaaCb67YLWz4IYZA1w/N3+u/w
	 5933rKC2x1F2AE24EhyFcBDwxufcsQPpkQ7L5xCNKdzlfZkvQ4Q71HkPxP+8DtgKj
	 U13+DxmtqQcSfwwknqKs0Oi/2fRTXRphsUvIhwk3ycsfyfBLLG+9dxmSMKR1bntWI
	 UZX0ZhKg8Ie+x4t0z09Q9DHHnkqzMc6aeiSg8Mil6ft7nnZ7lUtXjuGQI+Pon2S7l
	 v77Hyi5oYQlF2jlAZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1qq7OK39l1-00Uewe; Tue, 07
 Nov 2023 18:12:15 +0100
Date: Tue, 7 Nov 2023 18:12:15 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Hans Meiser <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Explanation of `eol` attribute doesn't seem correct for Windows
 machines
Message-ID: <20231107171215.GA28569@tb-raspi4>
References: <AS4P195MB15272FE283D0CF606A8B074EE2AAA@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
 <20231106162125.GA31375@tb-raspi4>
 <AS4P195MB1527BC2DF67412D4FF340989E2A9A@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4P195MB1527BC2DF67412D4FF340989E2A9A@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:uVs+uw1Zv8aHoP2ZG3bGCJ9vnk6XVFPd3d3rdbxy0bjmGk/dyXm
 5tjkX1FeZtj0yPc1Rd/tOkmITnyaKDjN+hvasT6nqzSxGdevvBWfftlM4EDe2doY/0osK4X
 HLmsX8Squ2jsjXes8fob2XlFA81YDnVoL5w7kDorOtz1EwW2hHTmMyPfMi7np0YOsF6UVrI
 0hRrL6GbRPoWmRk0ObsvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oEesbK1gqy0=;J6NTEJPN4A+vhcLCzBGyf2d9gQX
 i/+DCNXEwq7krA8XqNkP10FymNCNSeWY4r2HTsZ7kX4k82s2qxNjbxJQ11bs9apJv09erkFFL
 m/2Kg8F4wNzPErYHjsqIl/1kZ56mUEhnDL8aJntmrO85N2kkx/fPaD2PYt28DLHCt59k9/3YT
 mbkvq8Gd2YLGo/RI6/VmJYb09XMXX632oBDaGSzckQ8vFfxU+AHC7nFpeGQvvgaG4ZMKrbIuy
 6J7E7kc875OvCBQ1RrEgyORF2xAyqT+4H/rQ4WlllE5zg1xe5VQgkz/IDjT/xBGI+AkQIq5Hx
 06WSWUzIRDjlqydGVgsG3VAUkAslMg0keiNY0iXS8P2JnH/NP4aHyZyL9vYlnr7iROzz7bfxJ
 B0lTYhQ4rz7DVn9q8ahB4kCs3nzCD5i0YF1TqhmkPMtE3pFQP4BsWutL0wgzwgTgR1A1g7Xt7
 wZyOMNFAuqp5OEhI/ojgas9Vj4ql3h0LN13Tc70cCnRoIKN0R08J2tjv4IeLiVKHmkZAycBdZ
 Agxf65oMwiAAAtoEW6WQgpgoJth4z4d8vtWO74GkPg/iAttB0Pin293lVQK6eI7wkb3e4DdeF
 VqAh6TiSaRxUatdYlPOwBsp0W5EUvrzFt9R4E2lkZ2u+ajg2AzmfVPmYPboyfJl1po5JilWvs
 ggEy38Ua+PoV4C873bz8NFfnM8DxnjtOTtIXru9TaNMzvQZ94ytnbGLjs0+1I/8MX0hDm1qLI
 SSLYizTW7JRPK0g2PYwmlbeiktvmwykVH/wnOr6Qy+uOo1iyNncwdF+/BKWvRAus7u6Kfvs1X
 vCZagpDymVRb1xLIgRCz/E7ASvf+/o+o792aHCQFuSiCBTS8B5dwguhSFIPlzeNlUrJv5ngYL
 lOgHS0Bumu6QPpIIh1nDzCy41p9PmEixZz+D2Fpy8o94AKvLstFr8url0dZ8VCLcSvhPly/M3
 3nCoJDv73xz+MwewSxqM41uwPMw=
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 12:23:29AM +0000, Hans Meiser wrote:
> > > And what happens when a file is added to the index with `core.autocr=
lf=3Dinput` on Windows machines?
> > Do you have a .gitattributes file ? Or not ?
> > Is the file a new one, or does it exist ?
>
> Exactly all these questions/cases should be explained by the documentati=
on, I suppose.

In general, the CRLF - LF ("line endings") conversion is defined by
different settings.

The .gitattributes file (which is typically added to the repo and commited=
,
so that it travels trough into all repos by using `git clone`, `git pull`
or `git fetch` followed by a `git checkout`

This link
https://git-scm.com/docs/gitattributes#_text
should describe everything you may want to know about
.gitattributes
to handle line endings.
If I say "should" then this is from a perspective of someone who has read =
and used this
too often to see with fresh eyes what may be missing.

