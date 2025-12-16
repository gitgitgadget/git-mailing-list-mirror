Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2E33CE95
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921805; cv=none; b=b4JF/m4G3Lk5EyvRgADu9/LHdJzz91AWk8KsGjj1soyJOarKKNwBTxfC54PF8Rtz8U+gIgxMTDPbhha8dV9ZFeuXNCZtuufRstI6W9LW14/7x0fCPIDcfsvRSBY6vFxmPXownu98ZNgxjHbAzJMeAiJ0OdNNlC5cCERcd4usPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921805; c=relaxed/simple;
	bh=jFiO2BKRq00NM5+U9MmbPiH1H6L1C+c5bkyqz+PUY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2XWe+Z/rUps89yvw6Zj5xWHEKhu0DVg+4jD8E52SGpMv0tliVj76oCC1zH1eVBgQwiMIK0FuxdL9NgPOEOrFwCuMPaOeiELvi6ooWVtGVdaOP46AqeWWW8/hZj3mBErbGlduMbysPAqsukUUOI8RDgT+TmIk85AnuIT6yaDh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=SeGSbY8V; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="SeGSbY8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765921784; x=1766526584; i=tboegi@web.de;
	bh=jFiO2BKRq00NM5+U9MmbPiH1H6L1C+c5bkyqz+PUY+A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SeGSbY8VSXgr1Pp63INWhCdMr/b0ab/wMycLoyqeADwHcKQ1BS6TxuDdfEsXX2/+
	 cLr+909mkV+AkXVwBSi/56TfVfRRsB3EanoDiRH9fE+VF6JziCQLIlhj3+XpmkXyb
	 DSMZ0mUkoYyMlT97L0GhzA8C4Lk+a7Q6o0cLoHXpdkvT4MPdMBWiwKO4qdGQugCsm
	 8ZXj2jyXKrBXYwbn9a5MVqzkLI4tK+mXGXPI6xe6ENSGXZJbgP+Pv1oloUXHezGC+
	 8k4hPg3Kpw6mZm45eAlvKNXrQ+937RsG7ud2uBLufby34LuVRoT2vhd/iWCL6LDNO
	 vxDNOmniOgfo5kSlZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1wBpEA0IDi-00hlbH; Tue, 16
 Dec 2025 22:49:44 +0100
Date: Tue, 16 Dec 2025 22:49:43 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Koji Nakamaru <koji.nakamaru@gree.net>,
	Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v3 1/2] macOS: make Homebrew use configurable
Message-ID: <20251216214943.GA31390@tb-raspi4>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <98695ef0-b6bc-4929-8581-2ecb894cd604@web.de>
 <d2f033fc-222a-4fe8-8d24-6501e6f7a4c3@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d2f033fc-222a-4fe8-8d24-6501e6f7a4c3@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:K0FLlktlNkonkeBcVXAMhPZ2jsK1pAIdTds5jlmgu2/BboyU18t
 /h3CudJIvfRNxWtrgWjwk7j8AeOvTddwZv8wf0mVVJNJvJu0YLy/h11Lb1vzQJ4VkHiSS9D
 h65tRPCHtvrDEhPNhVqQKtkxZc6bycibz0dLyh/he1OilamBh6n9RJgVR27dGfzIj+Fgl2F
 9PCYJiub7tQesH6xdEDIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6v/0H1r72xA=;RldyTb07JenF75zpJylOOKzDGxF
 TnA8zoAdnhA7Rmz4fk5j2PSqhRC8JJaGm7wpLytQj+rwLxg4ZmAztwMc79LFAnvopc924L+iJ
 soT989AQkK1b0zzGbXmWs8AIV1062P+52prwfujy+3ivm4YKL5Dg9ZRvgBirReRVE/3TFGI8s
 T7A6E/J0HukFI0+wNCT0QopR1Eebw/AMyt+KxM89g1ckzCmNqSNojSb/4/JUy5zwaKT983pDb
 Ud1LRqyG3njkkOitOygKR7RMEs36XpTAa7SlhJydxgq4anu0WNKnwLDTMXcYxzesn4XSH3SQj
 /Fkf+eWxJtdxnaa9Gl9EX6MlKh3Re4QbO4Ll80maA3RbLoDPpwCFopDTxRMkoSd6WW/sJ308r
 LCXRAa0eUs0msJQFhRfCqSgw8zKPYcwGwXYtCGxQv5FgBWWjBk+IJ8lnCShdI76ssh2H/v1iI
 xglqTvGwiAl9mDmy7jCA3VkW+CfiFRIQFVQKc0M0tsyFLKK2iMkJpcxledgf87gJzo2H1/3P8
 UIBUiN/TrAdqM3q0Fk6v96xInqvKvv5fUw6bduUb/MLN+RJk9eBG06vYnrhyyrvUN089hCCES
 Ck+aXYyyyFA5Kp/eWKA+RWE0mHjha/9t+flM7H6MjA4gRBneuIQV2aB4u4W/zfR+8Di8kRQG+
 ISgqfTJU/rCKX79MAhZl9CeVb4rOakq0keX/curB7vvGOE1QIhpKrrf6F7Rm2VBK04unVL4+q
 fwcfYRe7dgUtsNfvPxz6Tz+p4NjAuCCk6NgGwT0MwlbDONBiDCrIm0+8T7FJviElPWE9l4m5v
 1ej38fhyPD3ZI4e4EvVjJ0BbRSFat4eOWVz3Kna9LuIGDGjLUfVoAUOfGN7bUrQvYczlxkNsM
 r2esSFA31VEcNwHwUfEE7vojhV8HBWgzuGwcYgatBlUMLtzTr9zgNstQu9YCRIQCwZbFtxPz/
 PUzlkfvB1CBLM7SKoBcoKYmEfroq8/qNsqfq/rrty5ADErsYB2D7z3kIZHJKH++vvCgebE7Xj
 MbxNjfivtEY4t7faQxPDHESjy1nnj9n155xIkrZ+BdORxijukdMELT8bKlOrSSRZHWkd4c6AK
 GeWGBmPSlTMuCN4v8eusKa1vIMJx6YRs7d8YvOuX59KHlWaDabcP4lT1yzkoab0vG78znuN2A
 hFeeTtrbqvfNafgdhta5Ylya5995Rq/a6Qn1DNePFGdmXc5hAOgWk9aW3sr7qVZpu9pFteVI0
 CxBFGm1qHjIKbcbMJlPE6bDR6eg1qkHIQV9BFb9rcxPJtkaR1x/nHFMqOucIGMnCuF8RPlKH+
 PUc7Nkiq/Tjg9Z9kRDigfC6AeExY8ES9EAxAaBlu/x5RPocgX8VgdYJ6QWuP5kugrnsTiSDfo
 roBHitXZ+cahXyV774FlDH1ncvnkJcf3tSlwaMZAkIQf4OEiFogYwkLsUAsb9t3Z8euHzgHVA
 B3sVoKC/ibSPviTCeExqHfMy4O4GaAsRBpR+ahXbw/4WOzV8ysPKQt0Izwf5YLXL19xyiuqjV
 4xanLVmhPtYf1kOAO1vYuKvROLK695yYkYjy2T94zoorJRpWdmk2+VEDi+vRqBCaedrOZgBBi
 c+9Q0SFVEP6uEFmfhxtldGvD5wyumjhG+euB78P4zRvLsMFrVoW+IJ5YnEE6zfdHTxf+AdtTt
 C5RcfOFIkndpvqKbdtxWWs6Dna/cvDsaag7tiHTmAOkJmpDlKYJm6/FFVKlaV52Nx6WEENk1P
 zy09c05cR/DpgtDYsXX0FpDfj+4pwM1EZ0XfekkE1RTHaLL64vlU2wvbkQL/3CCnYXOiuiyJ2
 YCPLYHtZTazOwsjNHeqUXeCRfj++5GcgNn5Xr0ga7/zQjzoVze7qssx9M3ZsaZhJj+uke9MBX
 /svsgVoBfgXDU8Mr0zdir5GXRPMWf/1P+PA4pXjmSk29LGcXKJwFv/5ZUYfZ/I0JsbSjewF3f
 Bz28GoBtSMo2hv3LVOeoeP0e40wxlreXfte1k/p6yEoNCsC8YPjHqqvkMrtH/SkfWDHyb3lfP
 op1VESteKjWc8Bh1uZSkqQR4JxVbxxw7v5Co3EQRKLIKe4Dct4RrlIn5/oUpfuF5PlGQQKXeX
 N1jlmnwVy+TOfoTtVsXfbDwEXafAdnvYStXKzHDAvYniAwGjIfOiHMo4JzpKSP9nwhYszLVjE
 8LmHToXba7fSFnPBQi4Fb1QZD/gPxpANeMRUzyFbvey8su3th8uUnbakuMiZ0H0b5e7EWR+2p
 IxpW8ogyK1jZBP//kE4hfOkRi1VuzaOODZJqMsJYhrElJmGd5RjK5bMCa17SlBdB76JNq25m8
 8Vx8wxyUsdUgLu3tGBOWAIkpw9M61BelptRJSEXFDOO2KPy4lgSJ0grB/LkyMhX+wDXvxb/Zl
 PcgnK9ogzrhc0ePcgnMNtC45J3R6Y2mhCQPu8BzD8oyEhYObR7Lqu4Iuq6z4AIBLlZtH7S86k
 qCU4tf5mNS2P6U0v59UrK//qKtnYBW/+B7rjTZx8LF34daa6gjc+i5WUVRrQuPMioh6gx38ZM
 kIqYxCePsSpz4cZrM1ueUVU1YCGjH/TSwudImN6U4BmwBgyle3V5kFkOeaKxAz8iCZgVNeff2
 z6ZR52x06wU3ayTXWodbK3dCh/95+fdAF0X1RxbZdxoGzGszQsLiXAERNZHbTZkI6HpjcT20s
 WWJk/qXAoXji2fXf8rawGJRqcoIoANxEk71Ugg0Yh2xarA3GJ7y5ytt3e1a8/u1RFtEaxWddH
 nR6h9pPyx7RONzLyC+r8yBF/F3GuIxHGbndrVkJeODOuJxDD0G3Do78IokDyT91hRN0AsWIda
 EERNxYeKlEYNqumQgYVnt0qhQlFE0TBLJEnJfDC6a7CcshGXY724VDixbeDzcpcqyrfqwEzmS
 pfKH2NJ8O4/H3GDMmKPy6dzNX2W3/pTCT6/8FW94/WPIY0oxb9T0wrZBex500zCPHyg0q9a5B
 Hsfl6wcQInKREqMExvCg4iwA8/rICFBel+C57UAZsMsKdU0okbubJQfER3GoQIy28FeztBq8b
 Wv2S25ehBV62dNe2t3+kxg/Yd7ZfDXWm9cHoVmQiBKBLBx0wEzlqEWp1HmYZoam3UM0QTb+jA
 lEn+1TBdgZsEH5DJjOvB3bn+FKqTwglTZvAefar9YO2i8XmhcsfQESbIOhUG+m4JhCHz3AKBm
 WSckJ9FJy9dPZSyrzRim0C+X9n2H5zGsDgO8ULK9Aoi3BFHqosVzkqp09ve3k1GjuKTu8ELVX
 ErBUV1PwzVUpLS/FzJD24hfiDEzgBX7xKz52wjdId7CNXwlJ/U8ThjlMv0OfuLze/ksvj8c5c
 n5fgn3CEu/RU8RtBVtXx5B7jq1wcGidQzb3Gl99DFwJw+aUMxwhqH+TURpQVI9BQ+hZlu4HCn
 Kc/9tnSY3drARQcq+7nBnvkpEyWwVgbB0IA8Em0OMOjyq7fu7jkLTW9G1pcYEVnuyCsqYT0as
 iUMCiigW8fxfIpvd5/QAzY7il36EGG2pn73pzSXoFErjj9WYkCXNblKGvlEjVnhUdsEzokht0
 d3/TX0bK1XRO3S7k+h/oMgWwnr0SxwWcqTAlRDAnfFa9m+dD2uqflORjGAc2j9TlhM0hDNGBZ
 UcrbIXXcr0G0f9SINqAoVcbtH1TL/K7ntOTejVasBpALGfAZeqwUrEUG/ZfB7tz1oQVhpFSNI
 lYesBzFH32eBhQbudzuatpjlPGHZ0TbxNsskm8oIrA2Uo0qwb7uzFl53x4UWOsSyc4vObpqMv
 SYRYdVV5tvD9lMTCnhu8rIQH0P/vyh9DO7Z08sEmh6/e+1qtoJigb3hEPcsFzlxjiSPQlqDiu
 a9PGYaSi9UAduh8g1xqY929M6RaYPEAeSE1b0cKp2pt6i2y6CVZRYR6oL+gKYOKS5g4wYFWCa
 Vs1vzZdPk/KYOqKHaoH1/lzqWQhEyszeC96v+a+M8E9M3uB5Mg9RzkVH3LJrzNghTCbCYzhab
 JLi8MG0tV9GePas6PAEvdR6nCZMESGqg8Jvg/YROUjdSWVsRyCK1rjBB8Mb2dJFlRWynCUCI9
 95KaEJJhn+2ZmqJtNBsCsbYJDFyDlJQCK/Sb6JvF52OlGO3yfN0ilEJNSK0cjNXJcXcwhwhF3
 7mxnhbuvNZiVosYmQ4pEfo73ipXijmy5/NWrhukC2sDREZWjWYC4jjJ4y+0ofXVjL9pLvd3pm
 Ft9m2buc7m0lg1Mb/zAoKj9Z10gFsXNh0GjSprmMUUTFb2heFSrE66OrNknPVJt5KGOK3ZDBd
 ABG/noh8fz244bpVvOMtB81sPoCSAH2eKmdIBdT9/fRH5py2XlQtTALk6O+aUSXWJTkSEr2eZ
 prjbehxJ0un33W6aYoB9CiOeSLBVC8FkQC3nxxLpdr1B+grls4UJz9Z8288T9ye1Q6psap/vx
 Pz+efpx9SyLqEVMG82SowdRrMihJDIfFBQe5IfVc6mq0XOdb4ChpoOV+R6AviaR2H1mpH5HCA
 Mhn5+Xb69Br2JQpzf21/Zl4N1V7vZApS5BB5M+yFCQvw3ivlZLBcpN/hGUOZ3e7DUaTTrS2LV
 PQUJx4b1YRvk53eA9rnMggzqoDWaVfFi5ZEVNAhVmYcH8CzhV67z3BZpPgD9E700mKSMO9moC
 OGmOY2AIg7JCKW+rNlGaUtXP8TKcsafu0JB7PT7amnSiRXIR76WxpJl6pHg1dZ5r9d9YV7UgH
 Jgf2UiTf/YqApv4xfpfhtFEnN7aRTU3KTXyQE3opivONy/Q9gM4PE4xW/MwaOCzaPlMaAFwEl
 d8NrXDKUBSXgPHw870NVSZXfAwjyRmIrez0z9ftf2NO9WBsUGeiIt/k2iyxNIhMUzYfHYJxEv
 s3DRsK6Gc7Y2KE545OwgPU7/FSXL1JvXJ6QupB/boIi8SWVciqgyhZA5qJK5wOupfF8gNVi4b
 9cn4/lhtLPX3FAYQIcfW56ABlfmGn1yMKpEBtsYti5+S8b5aZg9iW1Hjs4v02WqIhbmSQv8rp
 KZuu5S/s3Fc9hnPvVIPZ7ci62e0ms6g2xSdWtaJDhDKdIhUmFFj1frBbAUtDNCnzwmsxtKizm
 3GEgxRUz4L/1bMOurDXajYBk24BC4fyRr2wu3L14DY10zxbcv2TUahqOpA+OODZV9Nbm8HmT+
 BWj8qsdbQOdOPYzdkgAz1zdh2FMJVXSELHCixfU6KRIRJZbJ9nPV/i+6fKbw==

> > +#
> > +# Define USE_HOMEBREW_GETTEXT to link against the gettext library
> > +# installed by Homebrew, if present.
> > +#
> > +# Define USE_HOMEBREW_MSGFMT to use the msgfmt command installed by
> > +# Homebrew to compile message catalogs during build, if present.
>=20
> Do we even need these fine-grained USE_ variables?

If someone asks me: Probably not.

>=20
> Ren=E9
>=20
>=20
